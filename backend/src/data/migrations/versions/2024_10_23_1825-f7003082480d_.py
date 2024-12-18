"""empty message

Revision ID: f7003082480d
Revises: 
Create Date: 2024-10-23 18:25:38.210392

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'f7003082480d'
down_revision: Union[str, None] = None
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
    op.create_table('promo',
    sa.Column('id', sa.UUID(), nullable=False),
    sa.Column('name', sa.String(), nullable=False),
    sa.Column('bonus_amount', sa.DECIMAL(), nullable=False),
    sa.Column('uses', sa.Integer(), nullable=False),
    sa.Column('status', sa.Enum('ACTIVE', 'INACTIVE', name='promostatus'), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.create_table('user',
    sa.Column('user_id', sa.BigInteger(), autoincrement=False, nullable=False),
    sa.Column('referral_id', sa.Integer(), nullable=True),
    sa.Column('balance', sa.DECIMAL(), nullable=True),
    sa.Column('used_coupons', sa.JSON(), nullable=True),
    sa.Column('referral_code', sa.String(), nullable=False),
    sa.Column('nickname', sa.String(), nullable=True),
    sa.Column('profile_photo', sa.String(), nullable=True),
    sa.PrimaryKeyConstraint('user_id'),
    sa.UniqueConstraint('referral_code'),
    sa.UniqueConstraint('referral_id')
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
    op.create_table('transaction',
    sa.Column('id', sa.UUID(), nullable=False),
    sa.Column('user_id', sa.BigInteger(), nullable=False),
    sa.Column('type', sa.Enum('DEBIT', 'DEPOSIT', name='transactiontype'), nullable=False),
    sa.Column('cause', sa.Enum('DONATE', 'ADMIN_DEPOSIT', 'ADMIN_DEBIT', 'COUPON', 'REFUND', 'PAYMENT', 'REFERRAL', name='transactioncause'), nullable=False),
    sa.Column('time', sa.TIMESTAMP(timezone=True), nullable=False),
    sa.Column('amount', sa.DECIMAL(), nullable=False),
    sa.Column('payment_data', sa.JSON(), nullable=True),
    sa.Column('is_successful', sa.Boolean(), nullable=True),
    sa.ForeignKeyConstraint(['user_id'], ['user.user_id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('product',
    sa.Column('id', sa.UUID(), nullable=False),
    sa.Column('game_id', sa.Integer(), nullable=True),
    sa.Column('category_id', sa.Integer(), nullable=True),
    sa.Column('name', sa.String(), nullable=False),
    sa.Column('description', sa.String(), nullable=False),
    sa.Column('price', sa.DECIMAL(), nullable=False),
    sa.Column('instruction', sa.String(), nullable=True),
    sa.Column('purchase_count', sa.Integer(), nullable=False),
    sa.Column('game_name', sa.String(), nullable=True),
    sa.Column('image_url', sa.String(), nullable=True),
    sa.Column('purchase_limit', sa.Integer(), nullable=True),
    sa.Column('is_auto_purchase', sa.Boolean(), nullable=False),
    sa.Column('auto_purchase_text', sa.String(), nullable=True),
    sa.Column('is_manual', sa.Boolean(), nullable=False),
    sa.ForeignKeyConstraint(['category_id'], ['category.id'], ),
    sa.ForeignKeyConstraint(['game_id'], ['game.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('order',
    sa.Column('id', sa.UUID(), nullable=False),
    sa.Column('user_id', sa.BigInteger(), nullable=False),
    sa.Column('product_id', sa.UUID(), nullable=False),
    sa.Column('name', sa.String(), nullable=False),
    sa.Column('status', sa.Enum('PAID', 'CLOSED', 'COMPLETED', 'PROGRESS', name='orderstatus'), nullable=False),
    sa.Column('price', sa.DECIMAL(), nullable=False),
    sa.Column('time', sa.TIMESTAMP(timezone=True), nullable=False),
    sa.Column('additional_data', sa.JSON(), nullable=True),
    sa.ForeignKeyConstraint(['product_id'], ['product.id'], ),
    sa.ForeignKeyConstraint(['user_id'], ['user.user_id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('feedback',
    sa.Column('id', sa.UUID(), nullable=False),
    sa.Column('product_id', sa.UUID(), nullable=False),
    sa.Column('order_id', sa.UUID(), nullable=False),
    sa.Column('user_id', sa.BigInteger(), nullable=False),
    sa.Column('text', sa.String(length=500), nullable=False),
    sa.Column('stars', sa.Integer(), nullable=True),
    sa.Column('time', sa.TIMESTAMP(timezone=True), nullable=False),
    sa.Column('is_active', sa.Boolean(), nullable=False),
    sa.Column('image', sa.String(), nullable=True),
    sa.ForeignKeyConstraint(['order_id'], ['order.id'], ),
    sa.ForeignKeyConstraint(['product_id'], ['product.id'], ),
    sa.ForeignKeyConstraint(['user_id'], ['user.user_id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('feedback')
    op.drop_table('order')
    op.drop_table('product')
    op.drop_table('transaction')
    op.drop_table('category')
    op.drop_table('user')
    op.drop_table('promo')
    op.drop_table('game')
    # ### end Alembic commands ###
