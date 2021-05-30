class User < ApplicationRecord
  has_secure_password
  # Rails has authentication already built in. Calling this method within a model will initialize the authentication logic for the model
  # It does the following:
  # Provides authentication
  # Adds two attr_accessors :password & :password_confirmation
  # Adds a presence validation for :password
  # It will hash passwords automatically for us and store them in a column called password_digest
  # It will add an instance method called authenticate() that accepts a string(password) as an argument. It will run the string(password) against the same hashing algorithm, if the hash matches the one stored in the database then the password is correct and it will return the user, if the hash does not match it will return false.
  # This method requires:
  # 1) the bcrypt library/gem
  # 2) a column in the table(model) called password_digest
  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question
  # through: :likes <- the join table
  # source: :question <- the associated model relative to this current model (the association foreign key on the likes table)

  # has_and_belongs_to_many(
  #   :liked_questions,
  #   {
  #     class_name: 'Question',
  #     join_table: 'likes',
  #     association_foreign_key: 'question_id',
  #     foreign_key: 'user_id'
  #   }
  # )
  # Docs:
  # has_and_belongs_to_many(name, scope=nil, {options}, &extension)
  # the options are as follows:
  # :class_name -> the Model that the association points to
  # :join_table -> the join table used to create this association
  # :foreign_key -> on the join table, which foreign key points to this current model
  # :association_foreign_key -> on the join table, which foreign key points to the associated table
  has_many :questions
  # u = User.find(15)
  # u.questions -> because of the has_many relationship will return all the questions that belong to user
  has_many :answers
  has_many :job_posts, dependent: :nullify

  # validates(:email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)

  validates(:email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, unless: :from_oauth?)

  def from_oauth?
    uid.present? && provider.present?
  end

  def self.create_from_oauth(oauth_data)
    name = oauth_data["info"]["name"]&.split || 	oauth_data["info"]["nickname"]
    self.create(
    first_name: name[0],
    last_name: name[1] || "",
    uid: oauth_data["uid"],
    provider: oauth_data["provider"],
    oauth_raw_data: oauth_data,
    password: SecureRandom.hex(32)
    )
  end

  def self.find_by_oauth(oauth_data)
    self.find_by(
      uid: oauth_data["uid"],
      provider: oauth_data["provider"]
    )
  end

  has_one_attached :avatar
  def full_name 
    "#{first_name} #{last_name}".strip
  end
end
