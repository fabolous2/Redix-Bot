from typing import AsyncGenerator

from dishka import Provider, provide, Scope
from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine, async_sessionmaker, AsyncSession

from app.main.config import settings

from app.services import (
    UserService,
    ProductService,
    TransactionService,
    OrderService,
    PromoService,
    SupercellAuthService,
    FeedbackService,
    FreeKassaService,
    GameService,
    YandexStorageClient,
    CategoryService,
    AdminService,
    BileeService,
)
from app.data.dal import (
    UserDAL,
    ProductDAL,
    TransactionDAL,
    OrderDAL,
    PromoDAL,
    FeedbackDAL,
    GameDAL,
    CategoryDAL,
    AdminDAL,
)


class DatabaseProvider(Provider):
    @provide(scope=Scope.APP, provides=AsyncEngine)
    async def get_engine(self) -> AsyncGenerator[AsyncEngine, None]:
        engine = create_async_engine(url=settings.db_connection_url)
        yield engine
        engine.close()

    @provide(scope=Scope.APP, provides=async_sessionmaker[AsyncSession])
    def get_async_sessionmaker(self, engine: AsyncEngine) -> async_sessionmaker[AsyncSession]:
        return async_sessionmaker(bind=engine)

    @provide(scope=Scope.REQUEST, provides=AsyncSession)
    async def get_async_session(self, sessionmaker: async_sessionmaker[AsyncSession]) -> AsyncGenerator[AsyncSession, None]:
        async with sessionmaker() as session:
            yield session


class DALProvider(Provider):
    user_dal = provide(UserDAL, scope=Scope.REQUEST, provides=UserDAL)
    product_dal = provide(ProductDAL, scope=Scope.REQUEST, provides=ProductDAL)
    transaction_dal = provide(TransactionDAL, scope=Scope.REQUEST, provides=TransactionDAL)
    order_dal = provide(OrderDAL, scope=Scope.REQUEST, provides=OrderDAL)
    promo_dal = provide(PromoDAL, scope=Scope.REQUEST, provides=PromoDAL)
    feedback_dal = provide(FeedbackDAL, scope=Scope.REQUEST, provides=FeedbackDAL)
    game_dal = provide(GameDAL, scope=Scope.REQUEST, provides=GameDAL)
    category_dal = provide(CategoryDAL, scope=Scope.REQUEST, provides=CategoryDAL)
    admin_dal = provide(AdminDAL, scope=Scope.REQUEST, provides=AdminDAL)


class ServiceProvider(Provider):
    user_service = provide(UserService, scope=Scope.REQUEST, provides=UserService)
    product_service = provide(ProductService, scope=Scope.REQUEST, provides=ProductService)
    transaction_service = provide(TransactionService, scope=Scope.REQUEST, provides=TransactionService)
    order_service = provide(OrderService, scope=Scope.REQUEST, provides=OrderService)
    promo_service = provide(PromoService, scope=Scope.REQUEST, provides=PromoService)
    supercell_service = provide(SupercellAuthService, scope=Scope.REQUEST, provides=SupercellAuthService)
    feedback_service = provide(FeedbackService, scope=Scope.REQUEST, provides=FeedbackService)
    freekassa_service = provide(FreeKassaService, scope=Scope.REQUEST, provides=FreeKassaService)
    game_service = provide(GameService, scope=Scope.REQUEST, provides=GameService)
    category_service = provide(CategoryService, scope=Scope.REQUEST, provides=CategoryService)
    admin_service = provide(AdminService, scope=Scope.REQUEST, provides=AdminService)
    bilee_service = provide(BileeService, scope=Scope.REQUEST, provides=BileeService)
    
    @provide(scope=Scope.REQUEST, provides=YandexStorageClient)
    def get_yandex_storage_client(self) -> YandexStorageClient:
        return YandexStorageClient(settings.YANDEX_STORAGE_TOKEN, settings.YANDEX_STORAGE_SECRET, settings.YANDEX_STORAGE_BUCKET_NAME)
