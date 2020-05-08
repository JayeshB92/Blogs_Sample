# require 'user_input'

class Comment < ApplicationRecord
  include UserInput
  WORD_COUNT_COLUMN = :description
  # belongs_to :post
  belongs_to :user
  # has_many :comments, class_name: 'Comment', foreign_key: 'comment_id', dependent: :destroy
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates_length_of :description, :maximum => 100, allow_blank: false

end

# Product.joins(:categories,:likes).where(:categories => {name: 'animals'})
#
# Category.joins(products: [:likes]).uniq
#
# Category.joins(products: [:likes, :reviews]).uniq