class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts, foreign_key: 'user_id', dependent: :destroy
  has_many :account_appointments, :through => :accounts

  validates_presence_of :name, message: '- deverá ser informado.'

  validates :email,  presence: true,
            format: {
                with: EMAIL_FORMAT, message: "com formato inválido, por favor verifique!"
            }

end
