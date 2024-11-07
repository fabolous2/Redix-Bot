import uuid
from datetime import datetime
from typing import List, Optional

from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse

from aiogram import Bot
from aiogram.types import BufferedInputFile, Message
from aiogram.utils.media_group import MediaGroupBuilder
from aiogram.client.default import DefaultBotProperties
from aiogram.enums import ParseMode
from aiogram.utils.web_app import WebAppInitData

from dependency_injector.wiring import inject, Provide

from src.main.ioc import Container
from src.services import FeedbackService, UserService, YandexStorageClient, AdminService
from src.api.schema.feedback import CreateFeedback
from src.schema import Feedback
from src.api.dependencies import user_provider
from src.api.http.exceptions import MethodNotAllowedError
from src.schema import User
from src.main.config import settings

router = APIRouter(
    prefix="/feedback",
    tags=["Feedback"],
)


@router.post("/post", response_class=JSONResponse)
@inject
async def post_feedback(
    data: CreateFeedback,
    feedback_service: FeedbackService = Depends(Provide[Container.feedback_service]),
    yandex_storage_client: YandexStorageClient = Depends(Provide[Container.yandex_storage_client]),
    user_data: WebAppInitData = Depends(user_provider),
) -> JSONResponse:
    feedback_id = uuid.uuid4()
    feedback_group_id = -1002348273294
    bot = Bot(token=settings.BOT_TOKEN, default=DefaultBotProperties(parse_mode=ParseMode.HTML))
    text = f"""
Рейтинг: {"⭐" * data.stars}
Покупатель: @{user_data.user.username}
Дата: {datetime.now().strftime("%d.%m.%Y %H:%M")}

Отзыв:
{data.text}
"""
    try:
        if data.images:
            media_group = MediaGroupBuilder(caption=text)
            for image_url in data.images:
                image_content = yandex_storage_client.get_file(image_url)
                file = BufferedInputFile(image_content, filename=f"feedback_image_{uuid.uuid4()}.jpg")
                media_group.add_photo(media=file)
            message: Message = await bot.send_media_group(chat_id=feedback_group_id, media=media_group.build())
        else:
            message: Message = await bot.send_message(chat_id=feedback_group_id, text=text)
        
        await feedback_service.add_feedback(
            id=feedback_id,
            product_id=data.product.id,
            order_id=data.order_id,
            user_id=user_data.user.id,
            text=data.text,
            stars=data.stars,
            time=datetime.now(),
            images=data.images,
            message_url=message.get_url(),
        )
    except Exception as e:
        print(e)
    finally:
        await bot.session.close()

    return JSONResponse(
        status_code=200,
        content=dict(detail='success')
    )


@router.get("/", response_model=List[Feedback])
@inject
async def get_feedbacks(
    feedback_service: FeedbackService = Depends(Provide[Container.feedback_service]),
) -> List[Feedback]:
    response = await feedback_service.get_feedbacks(is_active=True)
    return response


@router.get("/{feedback_id}", response_model=Feedback)
@inject
async def get_one_feedback(
    feedback_id: uuid.UUID,
    feedback_service: FeedbackService = Depends(Provide[Container.feedback_service]),
) -> Feedback:
    return await feedback_service.get_one_feedback(id=feedback_id)


@router.get("/is_user_posted_feedback/{order_id}")
@inject
async def is_user_posted_feedback(
    order_id: uuid.UUID,
    feedback_service: FeedbackService = Depends(Provide[Container.feedback_service]),
    user_data: WebAppInitData = Depends(user_provider),
) -> Optional[Feedback]:
    return await feedback_service.get_one_feedback(user_id=user_data.user.id, order_id=order_id)


@router.get("/remove/{feedback_id}", response_class=JSONResponse)
@inject
async def remove_feedback(
    feedback_id: uuid.UUID,
    feedback_service: FeedbackService = Depends(Provide[Container.feedback_service]),
    admin_service: AdminService = Depends(Provide[Container.admin_service]),
    user_data: WebAppInitData = Depends(user_provider),
) -> JSONResponse:
    admins = await admin_service.get_all()
    admin_ids = [admin.user_id for admin in admins]
    if user_data.user.id not in admin_ids:
        raise MethodNotAllowedError

    await feedback_service.delete_feedback(feedback_id=feedback_id)

    return JSONResponse(
        status_code=200,
        content=dict(detail='success')
    )


@router.get("/user/{user_id}", response_model=User)
@inject
async def get_user_feedbacks(
    user_id: int,
    user_service: UserService = Depends(Provide[Container.user_service]),
) -> User:
    return await user_service.get_one_user(user_id=user_id)
