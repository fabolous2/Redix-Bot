from aiogram_dialog import Window, Dialog, DialogManager
from aiogram_dialog.widgets.input import MessageInput, TextInput
from aiogram_dialog.widgets.kbd import (
    Button,
    ScrollingGroup,
    Select,
    Back,
    PrevPage,
    CurrentPage,
    NextPage,
    Row,
    SwitchTo,
)
from aiogram_dialog.widgets.text import Format, Const
from aiogram_dialog.widgets.media import DynamicMedia

from aiogram import F
from aiogram.enums.content_type import ContentType

from app.bot.states.product import ProductManagementSG
from .getter import games_getter, one_game_getter, one_product_getter, one_category_getter
from .handlers import (
    selected_game,
    selected_product,
    add_product,
    edit_product_name,
    edit_product_description,
    edit_product_instruction,
    edit_product_price,
    edit_product_photo,
    delete_product,
    on_product_name,
    on_product_description,
    on_product_instruction,
    on_product_price,
    on_input_photo,
    back_to_product,
    on_input_photo_new_product,
    back_to_game_management,
    on_product_name_new_product,
    on_product_description_new_product,
    on_product_instruction_new_product,
    on_product_price_new_product,
    message_input_fixing,
    add_category,
    selected_category,
    on_category_thread_id,
    on_input_photo_new_category,
    on_category_name,
    hide_category,
    show_category,
    hide_product,
    show_product,
    disable_auto_delivery,
    on_auto_purchase_text,
    disable_purchase_limit,
    on_set_purchase_limit,
    on_category_required_fields,
    on_edit_category_required_fields,
    turn_on_gift_purchase,
    turn_off_gift_purchase,
    delete_category,
    on_edit_category_name,
)


async def close_dialog(_, __, dialog_manager: DialogManager, **kwargs):
    await dialog_manager.done()


product_management_dialog = Dialog(
    Window(
        Const("🎮 Список игр"),
        ScrollingGroup(
            Select(
                id="game_select",
                items="games",
                item_id_getter=lambda item: item.id,
                text=Format("{item.name}"),
                on_click=selected_game,
            ),
            id="game_group",
            height=10,
            width=2,
            hide_on_single_page=True,
            hide_pager=True
        ),
        Row(
            PrevPage(
                scroll="game_group", text=Format("◀️"),
            ),
            CurrentPage(
                scroll="game_group", text=Format("{current_page1}"),
            ),
            NextPage(
                scroll="game_group", text=Format("▶️"),
            ),
        ),
        MessageInput(
            func=message_input_fixing
        ),
        state=ProductManagementSG.GAMES,
        getter=games_getter,
    ),
    Window(
        Format("Игра: {game.name}"),
        ScrollingGroup(
            Select(
                id="category_select",
                items="categories",
                item_id_getter=lambda item: item.id,
                text=Format("🔴 | {item.name}"),
                on_click=selected_category,
            ),
            id="category_group",
            height=10,
            width=2,
            hide_on_single_page=True,
            hide_pager=True,
            when="categories"
        ),
        Button(
            id='add_category',
            text=Format("Добавить категорию"),
            on_click=add_category,
        ),
        Row(
            PrevPage(
                scroll="category_group", text=Format("◀️"),
            ),
            CurrentPage(
                scroll="category_group", text=Format("{current_page1}"),
            ),
            NextPage(
                scroll="category_group", text=Format("▶️"),
            ),
            when="categories"
        ),
        MessageInput(
            func=message_input_fixing
        ),
        Back(Format("◀️ Назад")),
        state=ProductManagementSG.GAME_MANAGEMENT,
        getter=one_game_getter,
    ),
    Window(
        Format("Категория: {category.name}"),
        ScrollingGroup(
            Select(
                id="product_select",
                items="products",
                item_id_getter=lambda item: item.id,
                text=Format("🔴 | {item.name}"),
                on_click=selected_product,
            ),
            id="product_group",
            height=10,
            width=2,
            hide_on_single_page=True,
            hide_pager=True,
            when="products"
        ),
        Button(
            id='add_product',
            text=Format("Добавить товар"),
            on_click=add_product,
        ),
        Button(
            id='hide_category',
            text=Format("Скрыть категорию"),
            on_click=hide_category,
            when=F['category'].is_visible
        ),
        Button(
            id='show_category',
            text=Format("Показать категорию"),
            on_click=show_category,
            when=~F['category'].is_visible
        ),
        Button(
            id='delete_category',
            text=Format("🗑️ Удалить категорию"),
            on_click=delete_category,
        ),
        SwitchTo(
            id='edit_category',
            text=Format("Изменить обязательные поля"),
            state=ProductManagementSG.EDIT_CATEGORY_REQUIRED_FIELDS,
        ),
        SwitchTo(
            id='edit_category_name',
            text=Format("Изменить название категории"),
            state=ProductManagementSG.EDIT_CATEGORY_NAME,
        ),
        Row(
            PrevPage(
                scroll="product_group", text=Format("◀️"),
            ),
            CurrentPage(
                scroll="product_group", text=Format("{current_page1}"),
            ),
            NextPage(
                scroll="product_group", text=Format("▶️"),
            ),
            when="products"
        ),
        MessageInput(
            func=message_input_fixing
        ),
        Back(Format("◀️ Назад")),
        state=ProductManagementSG.CATEGORY_MANAGEMENT,
        getter=one_category_getter,
    ),
    Window(
        DynamicMedia(selector="photo", when="photo"),
        Const("Выберите изменение"),
        Row(
            Button(
                id="edit_product_name",
                text=Format("Название"),
                on_click=edit_product_name,
            ),
            Button(
                id="edit_product_photo",
                text=Format("Фото"),
                on_click=edit_product_photo,
            ),
        ),
        Row(
            Button(
                id="edit_product_description",
                text=Format("Описание"),
                on_click=edit_product_description,
            ),
            Button(
                id="edit_product_instruction",
                text=Format("Инструкция"),
                on_click=edit_product_instruction,
            ),
        ),
        Row(
            Button(
                id="edit_product_price",
                text=Format("Цена"),
                on_click=edit_product_price,
            ),
        ),
        Button(
            id="delete_product",
            text=Format("🗑️ Удалить товар"),
            on_click=delete_product,
        ),
        Button(
            id="hide_product",
            text=Format("Скрыть товар"),
            on_click=hide_product,
            when=F['product'].is_visible
        ),
        Button(
            id="show_product",
            text=Format("Показать товар"),
            on_click=show_product,
            when=~F['product'].is_visible
        ),
        SwitchTo(
            id="enable_auto_delivery",
            text=Format("Включить автовыдачу"),
            when=~F['product'].is_auto_purchase,
            state=ProductManagementSG.SET_AUTO_PURCHASE_TEXT
        ),
        SwitchTo(
            id="purchase_limit_on",
            text=Format("Включить ограничение на количество покупок"),
            when=~F['product'].purchase_limit,
            state=ProductManagementSG.SET_PURCHASE_LIMIT
        ),
        Button(
            id="purchase_limit_off",
            text=Format("Выключить ограничение на количество покупок"),
            on_click=disable_purchase_limit,
            when=F['product'].purchase_limit,
        ),
        Button(
            id='turn_on_gift_purchase',
            text=Format("Вкл. подарком"),
            on_click=turn_on_gift_purchase,
            when=~F['product'].is_gift_purchase,
        ),
        Button(
            id='turn_off_gift_purchase',
            text=Format("Выкл. подарком"),
            on_click=turn_off_gift_purchase,
            when=F['product'].is_gift_purchase,
        ),
        Button(
            id="disable_auto_delivery",
            text=Format("Выключить автовыдачу"),
            on_click=disable_auto_delivery,
            when=F['product'].is_auto_purchase,
        ),
        Back(Format("◀️ Назад")),
        MessageInput(
            func=message_input_fixing
        ),
        state=ProductManagementSG.PRODUCT,
        getter=one_product_getter,
    ),
    Window(
        Const("Введите новое название товара"),
        TextInput(
            id="edit_product_name_text",
            on_success=on_product_name,
        ),
        Back(Format("◀️ Назад")),
        state=ProductManagementSG.EDIT_PRODUCT_NAME,
    ),
    Window(
        Const("Введите новое название категории"),
        TextInput(
            id="edit_category_name_text",
            on_success=on_edit_category_name,
        ),
        state=ProductManagementSG.EDIT_CATEGORY_NAME,
    ),
    Window(
        Const("Введите ограничение на количество покупок (число)"),
        TextInput(
            id="set_purchase_limit_text",
            on_success=on_set_purchase_limit,
            type_factory=int,
        ),
        SwitchTo(
            id="back_to_product",
            text=Format("◀️ Назад"),
            state=ProductManagementSG.PRODUCT
        ),
        state=ProductManagementSG.SET_PURCHASE_LIMIT,
    ),
    Window(
        Const("Введите текст для автовыдачи"),
        MessageInput(
            func=on_auto_purchase_text,
        ),
        SwitchTo(
            id="back_to_product",
            text=Format("◀️ Назад"),
            state=ProductManagementSG.PRODUCT
        ),
        state=ProductManagementSG.SET_AUTO_PURCHASE_TEXT,
    ),
    Window(
        Const("Введите новое описание товара"),
        TextInput(
            id="edit_product_description_text",
            on_success=on_product_description,
        ),
        Back(Format("◀️ Назад"), on_click=back_to_product),
        state=ProductManagementSG.EDIT_PRODUCT_DESCRIPTION,
    ),
    Window(
        Const("Введите новую инструкцию товара"),
        MessageInput(
            func=on_product_instruction,
        ),
        Back(Format("◀️ Назад"), on_click=back_to_product),
        state=ProductManagementSG.EDIT_PRODUCT_INSTRUCTION,
    ),
    Window(
        Const("Введите новую цену товара"),
        TextInput(
            id="edit_product_price_text",
            on_success=on_product_price,
        ),
        Back(Format("◀️ Назад"), on_click=back_to_product),
        state=ProductManagementSG.EDIT_PRODUCT_PRICE,
    ),
    Window(
        Const("Отправьте новое фото товара"),
        MessageInput(on_input_photo, content_types=[ContentType.PHOTO]),
        Back(Format("◀️ Назад"), on_click=back_to_product),
        state=ProductManagementSG.EDIT_PRODUCT_PHOTO,
    ),
    Window(
        Const("Введите название нового товара"),
        TextInput(
            id="add_product_name_text",
            on_success=on_product_name_new_product,
        ),
        Back(Format("◀️ Назад"), on_click=back_to_game_management),
        state=ProductManagementSG.ADD_PRODUCT_NAME,
    ),
    Window(
        Const("Введите описание нового товара"),
        TextInput(
            id="add_product_description_text",
            on_success=on_product_description_new_product,
        ),
        state=ProductManagementSG.ADD_PRODUCT_DESCRIPTION,
    ),
    Window(
        Const("Введите инструкцию нового товара"),
        MessageInput(
            func=on_product_instruction_new_product,
        ),
        state=ProductManagementSG.ADD_PRODUCT_INSTRUCTION,
    ),
    Window(
        Const("Введите цену нового товара"),
        TextInput(
            id="add_product_price_text",
            on_success=on_product_price_new_product,
        ),
        state=ProductManagementSG.ADD_PRODUCT_PRICE,
    ),
    Window(
        Const("Отправьте фото нового товара"),
        MessageInput(on_input_photo_new_product, content_types=[ContentType.PHOTO]),
        state=ProductManagementSG.ADD_PRODUCT_PHOTO,
    ),
    Window(
        Const("Введите название новой категории"),
        TextInput(
            id="add_category_name_text",
            on_success=on_category_name,
        ),
        state=ProductManagementSG.ADD_CATEGORY_NAME,
    ),
    Window(
        Const("Введите обязательные поля для заполнения одним сообщением через запятую"),
        TextInput(
            id="add_category_required_fields_text",
            on_success=on_category_required_fields,
        ),
        state=ProductManagementSG.ADD_CATEGORY_REQUIRED_FIELDS,
    ),
    Window(
        Const("Отправьте фото новой категории"),
        MessageInput(on_input_photo_new_category, content_types=[ContentType.PHOTO]),
        state=ProductManagementSG.ADD_CATEGORY_PHOTO,
    ),
    Window(
        Const("Введите ID темы в супергруппе телеграм. (Последнее число в ссылке после слэша на тему)"),
        TextInput(
            id="add_category_thread_id_text",
            on_success=on_category_thread_id,
        ),
        state=ProductManagementSG.ADD_CATEGORY_THREAD_ID,
    ),
    Window(
        Const("Введите новые обязательные поля для заполнения одним сообщением через запятую"),
        TextInput(
            id="edit_category_required_fields_text",
            on_success=on_edit_category_required_fields,
        ),
        state=ProductManagementSG.EDIT_CATEGORY_REQUIRED_FIELDS,
    ),
    on_process_result=close_dialog,
)
