from aiogram_dialog import DialogManager

from dishka import FromDishka

from app.services import AdminService
from .inject_wrappers import inject_getter


@inject_getter
async def admins_getter(
    dialog_manager: DialogManager,
    admin_service: FromDishka[AdminService],
    **kwargs
) -> dict:
    admins = await admin_service.get_all()

    return {
        "admins": admins,
    }


@inject_getter
async def one_admin_getter(
    dialog_manager: DialogManager,
    admin_service: FromDishka[AdminService],
    **kwargs
) -> dict:
    admin_user_id = dialog_manager.dialog_data["admin_user_id"]
    admin = await admin_service.get(user_id=int(admin_user_id))
    dialog_manager.dialog_data["permissions"] = admin.permissions    

    return {
        "admin": admin,
        "permissions": admin.permissions,
    }
