from aiogram.fsm.state import State, StatesGroup


class ProductManagementSG(StatesGroup):
    GAMES = State()
    GAME_MANAGEMENT = State()
    CHANGE_GAME_IMAGE = State()
    CATEGORIES = State()
    CATEGORY_MANAGEMENT = State()
    CHANGE_CATEGORY_IMAGE = State()
    ADD_CATEGORY_NAME = State()
    ADD_CATEGORY_REQUIRED_FIELDS = State()
    ADD_CATEGORY_PHOTO = State()
    EDIT_CATEGORY_REQUIRED_FIELDS = State()
    ADD_CATEGORY_THREAD_ID = State()
    EDIT_CATEGORY_NAME = State()
    PRODUCT = State()
    SET_PURCHASE_LIMIT = State()
    EDIT_PRODUCT_NAME = State()
    EDIT_PRODUCT_DESCRIPTION = State()
    EDIT_PRODUCT_INSTRUCTION = State()
    EDIT_PRODUCT_PRICE = State()
    EDIT_PRODUCT_PHOTO = State()
    ADD_PRODUCT_NAME = State()
    ADD_PRODUCT_DESCRIPTION = State()
    ADD_PRODUCT_INSTRUCTION = State()
    ADD_PRODUCT_INSTRUCTION_PHOTO = State()
    ADD_PRODUCT_PRICE = State()
    ADD_PRODUCT_PHOTO = State()
    SET_AUTO_PURCHASE_TEXT = State()
