module UserInput
  extend ActiveSupport::Concern

  def has_invalid_words(input)
    invalid_words = %w(bad poor filthy dirty stupid)
    invalid_words.any? { |invalid_word| input.include? invalid_word }
  end

  def contains_words(string = "", array_of_words = [])
    array_of_words.any? { |word| string.include? word }
  end
  
  module ClassMethods # Compulsory to use ClassMethods when using ActiveSupport::Concern
    def count_vowels(string)
      string.downcase.count('aeiou')
    end
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