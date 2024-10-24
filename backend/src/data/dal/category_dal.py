from typing import Optional, TypeAlias, List, Any

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import insert, update, select, exists, delete, Result

from src.schema import Category
from src.data.models import CategoryModel


_CategoryResult: TypeAlias = Result[tuple[CategoryModel]]


class CategoryDAL:
    def __init__(self, session: AsyncSession) -> None:
        self.session = session
    
    async def add(self, **kwargs) -> None:
        query = insert(CategoryModel).values(**kwargs)
        await self.session.execute(query)
        await self.session.commit()

    async def update(self, id: int, **kwargs) -> None:
        query = update(CategoryModel).where(CategoryModel.id == id).values(**kwargs)
        await self.session.execute(query)
        await self.session.commit()

    async def get(self, **kwargs: Optional[Any]) -> CategoryModel:
        query = select(CategoryModel).filter_by(**kwargs)
        result = await self.session.execute(query)
        db_result = result.scalar_one_or_none()
        return Category(
            id=db_result.id,
            game_id=db_result.game_id,
            name=db_result.name,
            image=db_result.image,
            is_visible=db_result.is_visible,
            thread_id=db_result.thread_id
        )

    async def get_all(self, **kwargs: Optional[Any]) -> List[Category]:
        if kwargs:
            query = select(CategoryModel).filter_by(**kwargs)
        else:
            query = select(CategoryModel)
        result = await self.session.execute(query)
        results = result.scalars().all()
        return [
            Category(
                id=result.id,
                game_id=result.game_id,
                name=result.name,
                image=result.image,
                is_visible=result.is_visible,
                thread_id=result.thread_id
            )
            for result in results
        ]

    async def delete(self, id: int) -> None:
        query = delete(CategoryModel).where(CategoryModel.id == id)
        await self.session.execute(query)
        await self.session.commit()

