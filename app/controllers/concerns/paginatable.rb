# frozen_string_literal: true

module Paginatable # rubocop:disable Style/Documentation
  extend ActiveSupport::Concern
  include Pagy::Backend

  def pagy(collection, vars = {})
    vars[:items] ||= params[:limit] || Pagy::DEFAULT[:items]

    params[:page] = 1 if params[:page].present? && params[:page].to_i < 1

    super(collection, vars)
  end
end
