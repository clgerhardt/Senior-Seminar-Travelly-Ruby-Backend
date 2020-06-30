class Document < ApplicationRecord
  validates :image_url, :expense_report_id, presence: true
  validates :expense_report, :presence => true
  belongs_to :expense_report
  mount_uploader :image_url, ImageUploader
end
