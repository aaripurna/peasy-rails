# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create user' do
    uuid = SecureRandom.uuid
    user = User.new(uuid:)
    assert user.valid?
    assert user.save
  end

  test 'automatically generating uuid' do
    user = User.new
    assert user.valid?
    assert user.save
    assert_not_nil user.uuid
  end

  test 'reject duplicate uuid' do
    uuid = SecureRandom.uuid
    assert User.create(uuid:)
    assert_raises(ActiveRecord::RecordNotUnique) { User.create(uuid:) }
  end
end
