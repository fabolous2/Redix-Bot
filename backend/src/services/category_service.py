import uuid
from typing import Optional, Any, List

from src.data.dal import CategoryDAL
from src.schema import Category


class CategoryService:
    def __init__(self, category_dal: CategoryDAL) -> None:
        self.__category_dal = category_dal

    async def get_categories(self, **params: Optional[Any]) -> Optional[List[Category]]:
        return await self.__category_dal.get_all(**params)
    
    async def get_category(self, **params: Optional[Any]) -> Optional[Category]:
        return await self.__category_dal.get(**params)
    
    async def add_category(self, **params) -> None:
        await self.__category_dal.add(**params)
    
    async def update_category(self, category_id: int, **params) -> None:
        await self.__category_dal.update(category_id=category_id, **params)
