"""empty message

Revision ID: 72371f483380
Revises: 96da3f392cb5
Create Date: 2024-10-26 16:23:09.799843

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '72371f483380'
down_revision: Union[str, None] = '96da3f392cb5'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('user', sa.Column('joined_at', sa.TIMESTAMP(), server_default=sa.text('now()'), nullable=False))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('user', 'joined_at')
    # ### end Alembic commands ###
