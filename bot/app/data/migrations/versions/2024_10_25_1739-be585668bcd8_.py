"""empty message

Revision ID: be585668bcd8
Revises: e4498cd49dba
Create Date: 2024-10-25 17:39:40.095920

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'be585668bcd8'
down_revision: Union[str, None] = 'e4498cd49dba'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('category', sa.Column('web_app_place', sa.Integer(), autoincrement=True, nullable=True))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('category', 'web_app_place')
    # ### end Alembic commands ###
