class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は「ひらがな」か「カタカナ」か「漢字」で入力してください' }
    validates :password, format: { with: /\A[0-9]+\z/ , message: 'は半角数字のみで入力してください'}
  end
        
  has_many :schedules
end
