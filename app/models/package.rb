class Package < ApplicationRecord

  # Associations
  has_many :system_dependencies, :dependent => :destroy

  # Attributes
  accepts_nested_attributes_for :system_dependencies, allow_destroy: true, :reject_if => :all_blank

  # Enums
  enum language: {ruby: 1, node: 2}

  # Validations
  validates :name, :presence => true
  validates :name, uniqueness: { scope: :language,
    message: "Package already exists for this language" }
  validates :language, :inclusion => { :in => languages.keys,
    :message => "Please select the package language" }
  validates :source_url, format: { with: URI.regexp }, if: Proc.new { |a| a.source_url.present? }

end
