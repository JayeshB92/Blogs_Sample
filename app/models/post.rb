class Post < ApplicationRecord
  include UserInput

  enum status: [:draft, :published, :archived]
  
  belongs_to :user
  has_many :tags
  has_many :comments, as: :commentable, dependent: :destroy


  validates_length_of :title, :maximum => 50, allow_blank: false
  validates_length_of :body, :maximum => 200, allow_blank: false
  validates_inclusion_of :status, in: %w(draft published archived)

  validate :custom_validation

  # Can be in 3 states
  # draft, published, archived
  scope :filter_status, ->(status) { where(status: status) }
  scope :filter_status_and_user, ->(user) { where(status: 'draft', user: user) }

  def custom_validation
    if self.status == 'draft' && Post.filter_status_and_user(self.user).count >= 1
      errors.add(:base, "Only 1 post can be in draft status.")
    end
  end
end
