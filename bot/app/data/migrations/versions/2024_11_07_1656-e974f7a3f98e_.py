"""empty message

Revision ID: e974f7a3f98e
Revises: 7bfabdffe72e
Create Date: 2024-11-07 16:56:00.755088

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'e974f7a3f98e'
down_revision: Union[str, None] = '7bfabdffe72e'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('feedback', sa.Column('message_id', sa.Integer(), nullable=True))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('feedback', 'message_id')
    # ### end Alembic commands ###
