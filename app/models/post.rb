class Post < ApplicationRecord
  include UserInput
  WORD_COUNT_COLUMN = :body
  enum status: [:draft, :published, :archived]
  
  belongs_to :user
  has_many :tags
  has_many :comments, as: :commentable, dependent: :destroy

  validates_length_of :title, :maximum => 50, allow_blank: false
  validates_length_of :body, :maximum => 200, allow_blank: false
  validates :status, inclusion: {in: statuses.keys}

  validate :custom_validation, on: :create

  # Can be in 3 states
  # draft, published, archived
  # scope :filter_status, ->(status) { where(status: status) }
  # scope :filter_status_and_user, ->(user) { where(status: 'draft', user: user) }

  def custom_validation
    if draft? && user.posts.draft.any?
      errors.add(:base, "Only 1 post can be in draft status.")
    end

    words_present, words = has_words?(self.title)
    if words_present
      errors.add(:title, "cannot have words containing: " + words.join(", "))
    end

    words_present, words = has_words?(self.body, %w(bad poor filthy stupid custom))
    if words_present
      errors.add(:body, "cannot have words containing: " + words.join(", "))
    end
  end
end
