# frozen_string_literal: true

##
# the User model, for persistance related operation
class User < ApplicationRecord
  self.primary_key = :uuid

  enum gender: {
    male: 'male',
    female: 'female'
  }

  def updatable_attributes
    slice('uuid', 'gender', 'name', 'location', 'age')
  end
end
