module UserInput
  extend ActiveSupport::Concern

  def has_words?(input = '', array_of_words = [])
    array_of_words = %w(bad poor filthy dirty stupid) if array_of_words.blank?
    words = array_of_words.select { |invalid_word|
      if input.include? invalid_word then
        invalid_word
      end }
    [words.present?, words]
  end

  def update_word_count
    if self.respond_to?(:word_count) && self.class.const_defined?(:WORD_COUNT_COLUMN)
      self.word_count = self.class.count_words(self.send(self.class::WORD_COUNT_COLUMN))
    end
  end

  module ClassMethods # Compulsory to use ClassMethods when using ActiveSupport::Concern
    def count_words(string)
      string.split.count
    end
  end

  included do
    before_save :update_word_count
  end

  # Using different module name with 'extend ActiveSupport::Concern'
  # included do
  #   extend ClassMethodsTest
  # end

  # When using 'extend ActiveSupport::Concern'
  # included do
  #   belongs_to :user
  # end

  # Not needed when 'extend ActiveSupport::Concern used'
  # def self.included(including_class)
  #   including_class.extend(ClassMethods)
  #   including_class.send(:belongs_to,:user) 
  # end
end