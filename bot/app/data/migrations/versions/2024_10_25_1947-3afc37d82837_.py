"""empty message

Revision ID: 3afc37d82837
Revises: be585668bcd8
Create Date: 2024-10-25 19:47:56.687864

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '3afc37d82837'
down_revision: Union[str, None] = 'be585668bcd8'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('feedback', sa.Column('images', sa.JSON(), nullable=True))
    op.drop_column('feedback', 'image')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('feedback', sa.Column('image', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.drop_column('feedback', 'images')
    # ### end Alembic commands ###
