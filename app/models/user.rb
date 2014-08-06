class User < ActiveRecord::Base
  rolify role_join_table_name: 'roles_users'


  include Authority::UserAbilities
  include Authority::Abilities

  self.authorizer_name = "UserAuthorizer"


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answer_sessions
  has_many :answers
  has_many :votes


  scope :search_by_email, ->(terms) { where("LOWER(#{self.table_name}.email) LIKE ?", terms.to_s.downcase.gsub(/^| |$/, '%')) }

  def forem_name
    email
  end

  def forem_admin?
    self.has_role? :admin
  end
end
