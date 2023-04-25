# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sesitive: false }

  passwordless_with :email
end
