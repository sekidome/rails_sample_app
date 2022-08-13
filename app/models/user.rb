class User < ApplicationRecord
    before_save { email.downcase! } #could also write self.email = (self.)email.downcase - () indicates self is optional on the right side
    validates :name, presence: true, length: { maximum: 50 }
    # could also be written like validates(:name, {presence: true...})
    #VALID_EMAIL_REGEX is a constant, indicated in Ruby by a
    #name starting with a capital letter
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true
    #has_secure_password
end
