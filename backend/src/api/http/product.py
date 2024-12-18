import uuid
from typing import List, Optional

from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse

from aiogram import Bot
from aiogram.types import BufferedInputFile
from aiogram.client.default import DefaultBotProperties
from aiogram.enums import ParseMode
from aiogram.utils.web_app import WebAppInitData

from dependency_injector.wiring import inject, Provide

from src.main.ioc import Container
from src.api.http.exceptions.user import MethodNotAllowedError
from src.schema import Product
from src.services import ProductService, UserService, OrderService, TransactionService, GameService, CategoryService, YandexStorageClient, AdminService
from src.api.schema.order import CreateOrderDTO
from src.api.schema.product import CreateProduct
from src.main.config import settings
from src.api.http.keyboard import take_order_kb_markup
from src.utils import json_text_getter
from src.api.dependencies import user_provider
from src.schema.transaction import TransactionCause, TransactionType


router = APIRouter(
    prefix="/products",
    tags=["Products"],
)


@router.get('/search')
@inject
async def search_products(
    search: str,
    product_service: ProductService = Depends(Provide[Container.product_service]),
) -> List[Product]:
    response = await product_service.search(search)

    return response


@router.get('/', response_model=List[Product])
@inject
async def get_products(
    product_service: ProductService = Depends(Provide[Container.product_service]),
    category_id: Optional[int] = None,
) -> List[Product]:
    if category_id:
        products = await product_service.get_products(category_id=category_id, is_visible=True)
    else:
        products = await product_service.get_products(is_visible=True)

    return products


@router.get('/{product_id}', response_model=Product)
@inject
async def get_one_product(
    product_id: uuid.UUID,
    product_service: ProductService = Depends(Provide[Container.product_service]),
) -> Optional[Product]:
    product = await product_service.get_one_product(id=product_id)
    
    return product


@router.post('/{product_id}/purchase')
@inject
async def purchase_product(
    order_data: CreateOrderDTO,
    product_service: ProductService = Depends(Provide[Container.product_service]),
    user_service: UserService = Depends(Provide[Container.user_service]),
    order_service: OrderService = Depends(Provide[Container.order_service]),
    transaction_service: TransactionService = Depends(Provide[Container.transaction_service]),
    game_service: GameService = Depends(Provide[Container.game_service]),
    category_service: CategoryService = Depends(Provide[Container.category_service]),
    yandex_storage_client: YandexStorageClient = Depends(Provide[Container.yandex_storage_client]),
    user_data: WebAppInitData = Depends(user_provider),
) -> JSONResponse:
    user = await user_service.get_one_user(user_id=user_data.user.id)
    product = await product_service.get_one_product(id=order_data.product_id)
    game = await game_service.get_game(id=product.game_id)
    category = await category_service.get_category(id=product.category_id)

    if not product:
        return JSONResponse(status_code=404, content='Product not found.')
    elif not user:
        return JSONResponse(status_code=404, content='User not found.')
    elif user.balance < product.price:
        return JSONResponse(
            status_code=409,
            content=dict(
                description='Insufficient funds on user balance',
                user_balance=float(user.balance),
                top_up_amount=float(product.price - user.balance),
            )
        )
    
    order_id = uuid.uuid4()
    await order_service.add_order(
        id=order_id,
        user_id=user.user_id,
        product_id=order_data.product_id,
        name=product.name,
        price=product.price,
        additional_data=order_data.additional_data,
    )
    await user_service.update_user(user_id=user.user_id, balance=user.balance - product.price)
    await transaction_service.add_transaction(
        id=uuid.uuid4(),
        user_id=user.user_id,
        type=TransactionType.DEBIT,
        cause=TransactionCause.PAYMENT,
        amount=product.price,
        is_successful=True,
    )

    try:
        bot = Bot(token=settings.BOT_TOKEN, default=DefaultBotProperties(parse_mode=ParseMode.HTML))
        if product.is_auto_purchase:
            if product.auto_purchase_image_url:
                auto_purchase_image_bytes = yandex_storage_client.get_file(product.auto_purchase_image_url)
                photo = BufferedInputFile(auto_purchase_image_bytes, filename=f"auto_purchase_image_{uuid.uuid4()}.jpg")
                await bot.send_photo(
                    chat_id=user_data.user.id,
                    caption=f'Текст Авто-выдачи:\n\n{product.auto_purchase_text}',
                    photo=photo,
                )
            else:
                await bot.send_message(
                    chat_id=user_data.user.id,
                    text=f'Текст Авто-выдачи:\n\n{product.auto_purchase_text}',
                )
        else:
            await bot.send_message(
                chat_id=game.supergroup_id,
                text=json_text_getter.get_order_info_text(
                    user_id=user.user_id,
                    order_id=order_id,
                    order_data=order_data.additional_data,
                    product=product,
                    category=category.name,
                ),
                message_thread_id=category.thread_id,
                reply_markup=take_order_kb_markup(order_id=order_id)
            )
    except Exception as e:
        print(e)
    finally:
        await bot.session.close()

    return JSONResponse(status_code=200, content=dict(message="success"))


@router.post("/create")
@inject
async def create_product(
    data: CreateProduct,
    product_service: ProductService = Depends(Provide[Container.product_service]),
    admin_service: AdminService = Depends(Provide[Container.admin_service]),
    user_data: WebAppInitData = Depends(user_provider),
) -> JSONResponse:
    admins = await admin_service.get_all()
    admin_ids = [admin.user_id for admin in admins]
    if user_data.user.id not in admin_ids:
        raise MethodNotAllowedError
    
    await product_service.create_product(
        id=data.id,
        name=data.name,
        game_id=data.game_id,
        description=data.description,
        price=data.price,
        instruction=data.instruction,
        purchase_count=data.purchase_count,
        game_name=data.game_name,
        category=data.category,
        image_url=data.image_url,
    )

    return JSONResponse(status_code=200, content=dict(message='success'))
