import uuid

from aiogram import Router, Bot, F
from aiogram.types import CallbackQuery, Chat, ReplyKeyboardRemove, Message
from aiogram.fsm.context import FSMContext

from dishka import FromDishka

from aiogram_dialog import DialogManager, StartMode, ShowMode

from src.bot.app.bot.filters import AdminFilter
from src.bot.app.bot.keyboards import inline
from src.bot.app.bot.states import MailingSG, UpdateUserSG
from src.services import OrderService, ProductService, UserService, CategoryService
from src.schema.order import OrderStatus
from src.bot.app.bot.states.product import ProductManagementSG
from src.utils import json_text_getter
from src.bot.app.bot.states.order import CancelOrderSG
from src.bot.app.bot.states.admin import AdminManagementSG


router = Router()
router.callback_query.filter(AdminFilter)


@router.callback_query(F.data == 'back_apanel')
async def admin_panel_handler(
    query: CallbackQuery,
    bot: Bot,
    event_chat: Chat,
) -> None:
    await bot.edit_message_text(
        message_id=query.message.message_id,
        chat_id=event_chat.id,
        text="Админ-меню",
        reply_markup=inline.admin_menu_kb_markup,
    )


#MAILING HANDLERS
@router.callback_query(F.data == 'admin_mailing')
async def mailing_handler(
    query: CallbackQuery,
    bot: Bot,
    event_chat: Chat,
    state: FSMContext,
) -> None:
    await bot.edit_message_text(
        message_id=query.message.message_id,
        chat_id=event_chat.id,
        text="Отправьте сообщение, которое желаете разослать всем пользователям:",
        reply_markup=inline.back_to_apanel_kb_markup,
    )
    await state.set_state(MailingSG.MESSAGE)


@router.callback_query(F.data == 'confirm_mailing')
async def mailing_sender_handler(
    query: CallbackQuery,
    state: FSMContext,
    bot: Bot,
    event_chat: Chat,
    user_service: FromDishka[UserService],
) -> None:
    state_data = await state.get_data()
    media_group = state_data.get("media_group")
    message_id = state_data.get("message_id")

    users = await user_service.get_users()
    rkm = ReplyKeyboardRemove()
    for user in users:
        try:
            if media_group:
                await bot.send_media_group(chat_id=user.user_id, media=media_group.build())
            elif message_id:
                await bot.copy_message(
                    chat_id=user.user_id,
                    message_id=message_id,
                    from_chat_id=event_chat.id,
                    reply_markup=rkm,
                )
        except Exception as ex:
            print(ex)

    await bot.send_message(chat_id=event_chat.id, text="Сообщение успешно разослано пользователям!")
    await bot.delete_message(
        chat_id=event_chat.id,
        message_id=query.message.message_id,
    )
    await state.clear()


@router.callback_query(F.data == 'cancel_mailing')
async def mailing_sender_handler(
    query: CallbackQuery,
    state: FSMContext,
    bot: Bot,
    event_chat: Chat,
) -> None:
    await state.clear()
    await bot.delete_message(chat_id=event_chat.id, message_id=query.message.message_id)
    await bot.send_message(chat_id=event_chat.id, text="Рассылка успешно отменена")


#User Management
@router.callback_query(F.data == 'user_management')
async def user_profiles_handler(query: CallbackQuery, state: FSMContext) -> None:
    await query.message.answer('👤 Введите ID пользователя, чей профиль хотите редактировать.')
    await state.set_state(UpdateUserSG.USER_ID)


@router.callback_query(F.data.startswith('top_up_balance'))
async def top_up_handler(
    query: CallbackQuery, 
    state: FSMContext,
    bot: Bot,
    event_chat: Chat,
) -> None:
    user_id = query.data.split(':')[-1]
    await state.update_data(user_id=user_id)
    
    await bot.edit_message_text(
        chat_id=event_chat.id,
        text='Введите сумму, на которую хотите пополнить баланс пользователя.',
        message_id=query.message.message_id,
    )
    await state.set_state(UpdateUserSG.TOP_UP_BALANCE)


@router.callback_query(F.data.startswith('lower_balance'))
async def lower_balance_handler(
    query: CallbackQuery, 
    state: FSMContext,
    bot: Bot,
    event_chat: Chat,
) -> None:
    user_id = query.data.split(':')[-1]
    await state.update_data(user_id=user_id)

    await bot.edit_message_text(
        chat_id=event_chat.id,
        text='Введите сумму, которую хотите отнять у пользователя.',
        message_id=query.message.message_id,
    )
    await state.set_state(UpdateUserSG.LOWER_BALANCE)


@router.callback_query(F.data.startswith('set_balance'))
async def set_balance_handler(
    query: CallbackQuery, 
    state: FSMContext,
    bot: Bot,
    event_chat: Chat,
) -> None:
    user_id = query.data.split(':')[-1]
    await state.update_data(user_id=user_id)
    
    await bot.edit_message_text(
        chat_id=event_chat.id,
        text='Введите сумму, которую хотите установить пользователю.',
        message_id=query.message.message_id,
    )
    await state.set_state(UpdateUserSG.SET_BALANCE)


#ORDER
@router.callback_query(F.data.startswith('confirm_order'))
async def confirm_order_handler(
    query: CallbackQuery,
    order_service: FromDishka[OrderService],
    product_service: FromDishka[ProductService],
    bot: Bot,
    event_chat: Chat,
) -> None:
    order_id = query.data.split(':')[-1]
    order = await order_service.get_one_order(id=order_id)

    if order.status == OrderStatus.PROGRESS:
        product = await product_service.get_one_product(id=order.product_id)

        await order_service.update_order(
            order_id=uuid.UUID(order_id),
            status=OrderStatus.COMPLETED,
        )
        await product_service.update_product(product_id=order.product_id, purchase_count=product.purchase_count + 1)

        await bot.send_message(
            chat_id=order.user_id,
            text='✅ Ваш заказ выполнен! Спасибо за покупку, буду рад увидеться снова, могли бы оставить отзыва по кнопке снизу 👇',
            reply_markup=inline.post_feedback_kb_markup(order_id=order.id),
        )
        await query.answer(text='Ответ был успешно отправлен пользователю!', show_alert=True)
        await bot.delete_message(chat_id=event_chat.id, message_id=query.message.message_id)
    else:
        await query.answer(text='Заказ уже обработан другим администратором', show_alert=True)
        await bot.delete_message(chat_id=event_chat.id, message_id=query.message.message_id)


@router.callback_query(F.data.startswith('cancel_order_reason'))
async def cancel_order_reason_handler(
    query: CallbackQuery,
    state: FSMContext,
) -> None:
    order_id = query.data.split(':')[-1]
    await state.update_data(order_id=order_id)
    await query.message.answer('Введите причину отмены заказа.', reply_markup=inline.cancel_without_reason_kb_markup(order_id=order_id))
    await state.set_state(CancelOrderSG.REASON)


@router.message(CancelOrderSG.REASON)
async def cancel_order_reason_handler(
    message: Message,
    state: FSMContext,
    order_service: FromDishka[OrderService],
    product_service: FromDishka[ProductService],
    user_service: FromDishka[UserService],
    bot: Bot,
    event_chat: Chat,
) -> None:
    order_id = (await state.get_data()).get('order_id')
    order = await order_service.get_one_order(id=order_id)

    try:
        if order.status == OrderStatus.PROGRESS:
            user = await user_service.get_one_user(user_id=order.user_id)
            product = await product_service.get_one_product(id=order.product_id)

            await order_service.update_order(
                order_id=uuid.UUID(order_id),
                status=OrderStatus.CLOSED,
                cancel_reason=message.text,
            )
            await user_service.update_user(user_id=order.user_id, balance=user.balance + order.price)

            await bot.send_message(
                chat_id=order.user_id,
                text=f'❌ Ваш заказ на {product.name} был отклонен по причине: {message.text}. Средства были возвращены на ваш счет.',
            )
            await message.answer(text='Ответ был успешно отправлен пользователю!', show_alert=True)
            await bot.delete_message(chat_id=event_chat.id, message_id=message.message_id)
        else:
            await message.answer(text='Заказ уже обработан другим администратором', show_alert=True)
            await bot.delete_message(chat_id=event_chat.id, message_id=message.message_id)
    except Exception as ex:
        print(ex)
    finally:
        await state.clear()

@router.callback_query(F.data.startswith('cancel_order'))
async def cancel_order_handler(
    query: CallbackQuery,
    order_service: FromDishka[OrderService],
    product_service: FromDishka[ProductService],
    user_service: FromDishka[UserService],
    bot: Bot,
    event_chat: Chat,
) -> None:
    order_id = query.data.split(':')[-1]
    order = await order_service.get_one_order(id=order_id)
    
    if order.status == OrderStatus.PROGRESS:
        user = await user_service.get_one_user(user_id=order.user_id)
        product = await product_service.get_one_product(id=order.product_id)

        await order_service.update_order(
            order_id=uuid.UUID(order_id),
            status=OrderStatus.CLOSED,
        )
        await user_service.update_user(user_id=order.user_id, balance=user.balance + order.price)

        await bot.send_message(
            chat_id=order.user_id,
            text=f'❌ Ваш заказ на {product.name} был отклонен! Средства были возвращены на ваш счет.',
        )
        await query.answer(text='Ответ был успешно отправлен пользователю!', show_alert=True)
        await bot.delete_message(chat_id=event_chat.id, message_id=query.message.message_id)
    else:
        await query.answer(text='Заказ уже обработан другим администратором', show_alert=True)
        await bot.delete_message(chat_id=event_chat.id, message_id=query.message.message_id)


@router.callback_query(F.data == 'product_management')
async def product_management_handler(
    query: CallbackQuery,
    dialog_manager: DialogManager,
) -> None:
    await dialog_manager.start(
        ProductManagementSG.GAMES,
        mode=StartMode.RESET_STACK,
        show_mode=ShowMode.DELETE_AND_SEND,
    )


@router.callback_query(F.data.startswith('take_order'))
async def take_order_handler(
    query: CallbackQuery,
    bot: Bot,
    event_chat: Chat,
    order_service: FromDishka[OrderService],
    product_service: FromDishka[ProductService],
    category_service: FromDishka[CategoryService],
) -> None:
    order_id = query.data.split(':')[-1]
    order = await order_service.get_one_order(id=order_id)
    product = await product_service.get_one_product(id=order.product_id)
    category = await category_service.get_category(id=product.category_id)

    await bot.send_message(
        chat_id=query.from_user.id,
        text=json_text_getter.get_order_info_text(
            user_id=query.from_user.id,
            order_id=order_id,
            order_data=order.additional_data,
            product=product,
            category=category.name,
        ),
        reply_markup=inline.order_confirmation_kb_markup(order_id=order_id)
    )
    await bot.delete_message(chat_id=event_chat.id, message_id=query.message.message_id)


@router.callback_query(F.data == 'bot_statistics')
async def bot_statistics_handler(
    query: CallbackQuery,
    product_service: FromDishka[ProductService],
    user_service: FromDishka[UserService],
) -> None:
    purchase_count = await product_service.get_purchase_count()
    total_purchase_amount = await product_service.get_total_purchase_amount()
    users_count = await user_service.get_new_users_amount()

    await query.message.answer(
        text=f"""
<b>Статистика бота</b>

<b>Количество покупок:</b>
За день: {purchase_count['today']}
За неделю: {purchase_count['week']}
За месяц: {purchase_count['month']}
За все время: {purchase_count['all_time']}

<b>Сумма покупок:</b>
За день: {total_purchase_amount['today']}
За неделю: {total_purchase_amount['week']}
За месяц: {total_purchase_amount['month']}
За все время: {total_purchase_amount['all_time']}

<b>Количество пришедших пользователей:</b>
За день: {users_count['today']}
За неделю: {users_count['week']}
За месяц: {users_count['month']}
За все время: {users_count['all_time']}
""",
    )


@router.callback_query(F.data == 'admin_management')
async def admin_management_handler(
    query: CallbackQuery,
    dialog_manager: DialogManager,
) -> None:
    await dialog_manager.start(
        AdminManagementSG.ADMIN_LIST,
        mode=StartMode.RESET_STACK,
        show_mode=ShowMode.DELETE_AND_SEND,
    )
