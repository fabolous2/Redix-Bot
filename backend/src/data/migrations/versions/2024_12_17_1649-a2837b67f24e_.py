"""empty message

Revision ID: a2837b67f24e
Revises: ffef7d36f285
Create Date: 2024-12-17 16:49:54.566474

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'a2837b67f24e'
down_revision: Union[str, None] = 'ffef7d36f285'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.execute("DROP SEQUENCE IF EXISTS transaction_unique_id_seq CASCADE")
    op.execute("CREATE SEQUENCE transaction_unique_id_seq START 1000001 INCREMENT 1")
    op.alter_column(
        "transaction",
        "unique_id",
        existing_type=sa.Integer(),
        nullable=False,
        server_default=sa.text("nextval('transaction_unique_id_seq'::regclass)"),
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    pass
    # ### end Alembic commands ###