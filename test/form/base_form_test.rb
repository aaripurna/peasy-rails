require 'test_helper'

class BaseFormTest < ActiveSupport::TestCase
  Mock = Minitest::Mock.new
  test 'def execute not implemented' do
    kls = Class.new(BaseForm)

    assert_raises(NotImplementedError) { kls.new.perform }
  end

  test 'def execute implemeted' do
    kls = Class.new(BaseForm) do
      def execute
        true
      end
    end

    assert_nothing_raised { kls.new.perform }
  end

  test 'it handles callback' do
    Mock.expect :foo, true

    kls = Class.new(BaseForm) do
      after_perform :exec_foo

      def exec_foo
        Mock.foo
      end

      def execute
        true
      end
    end

    kls.new.perform

    assert_mock Mock
  end
end
