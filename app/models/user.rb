class User < ApplicationRecord
  self.primary_key = :uuid

  def updatable_attributes
    slice("uuid", "gender", "name", "location", "age")
  end

  def female?
    gender == "female"
  end

  def male?
    gender == "male"
  end
end
