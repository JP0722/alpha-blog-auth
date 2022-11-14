class Article < ApplicationRecord
	validates :title, presence: true, length: {minimum: 4, maximum: 50}
	validates :description, presence: true, length: {minimum: 5, maximum: 300}
	belongs_to :user

	has_many :article_categories
	has_many :categories, through: :article_categories
end