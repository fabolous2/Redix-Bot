"""empty message

Revision ID: b19e9cab4619
Revises: 37b29d0aa4ca
Create Date: 2024-10-15 17:48:16.107057

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'b19e9cab4619'
down_revision: Union[str, None] = '37b29d0aa4ca'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('game',
    sa.Column('id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('name', sa.String(), nullable=False),
    sa.Column('image_url', sa.String(), nullable=False),
    sa.Column('web_app_place', sa.Integer(), nullable=True),
    sa.Column('supergroup_id', sa.Integer(), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('category',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('game_id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.Column('image', sa.String(length=255), nullable=True),
    sa.Column('is_visible', sa.Boolean(), nullable=False),
    sa.Column('thread_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['game_id'], ['game.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.add_column('feedback', sa.Column('order_id', sa.UUID(), nullable=False))
    op.add_column('feedback', sa.Column('image', sa.String(), nullable=True))
    op.alter_column('feedback', 'text',
               existing_type=sa.VARCHAR(length=4034),
               type_=sa.String(length=500),
               existing_nullable=False)
    op.alter_column('feedback', 'stars',
               existing_type=sa.INTEGER(),
               nullable=True)
    op.create_foreign_key(None, 'feedback', 'order', ['order_id'], ['id'])
    op.drop_column('feedback', 'photo')
    op.add_column('product', sa.Column('game_id', sa.Integer(), nullable=True))
    op.add_column('product', sa.Column('category_id', sa.Integer(), nullable=True))
    op.add_column('product', sa.Column('game_name', sa.String(), nullable=True))
    op.add_column('product', sa.Column('image_url', sa.String(), nullable=True))
    op.add_column('product', sa.Column('purchase_limit', sa.Integer(), nullable=True))
    op.add_column('product', sa.Column('is_manual', sa.Boolean(), nullable=False))
    op.create_foreign_key(None, 'product', 'category', ['category_id'], ['id'])
    op.create_foreign_key(None, 'product', 'game', ['game_id'], ['id'])
    op.drop_column('product', 'category')
    op.drop_column('product', 'game')
    op.add_column('transaction', sa.Column('is_successful', sa.Boolean(), nullable=True))
    op.add_column('user', sa.Column('nickname', sa.String(), nullable=True))
    op.add_column('user', sa.Column('profile_photo', sa.String(), nullable=True))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('user', 'profile_photo')
    op.drop_column('user', 'nickname')
    op.drop_column('transaction', 'is_successful')
    op.add_column('product', sa.Column('game', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.add_column('product', sa.Column('category', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.drop_constraint(None, 'product', type_='foreignkey')
    op.drop_constraint(None, 'product', type_='foreignkey')
    op.drop_column('product', 'is_manual')
    op.drop_column('product', 'purchase_limit')
    op.drop_column('product', 'image_url')
    op.drop_column('product', 'game_name')
    op.drop_column('product', 'category_id')
    op.drop_column('product', 'game_id')
    op.add_column('feedback', sa.Column('photo', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.drop_constraint(None, 'feedback', type_='foreignkey')
    op.alter_column('feedback', 'stars',
               existing_type=sa.INTEGER(),
               nullable=False)
    op.alter_column('feedback', 'text',
               existing_type=sa.String(length=500),
               type_=sa.VARCHAR(length=4034),
               existing_nullable=False)
    op.drop_column('feedback', 'image')
    op.drop_column('feedback', 'order_id')
    op.drop_table('category')
    op.drop_table('game')
    # ### end Alembic commands ###
