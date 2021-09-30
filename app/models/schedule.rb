class Schedule < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :start_time
    validates :end_time
    validates :place
    validates :info
  end

  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  has_many :comments, dependent: :destroy
end
