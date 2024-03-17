# frozen_string_literal: true

class BaseForm
  extend ActiveModel::Callbacks
  include ActiveModel::Model

  define_model_callbacks :perform

  def perform
    run_callbacks :perform do
      execute
    end
  end

  def execute
    raise NotImplementedError
  end
end
