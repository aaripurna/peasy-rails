class HomepageController < ApplicationController
  def home
    @name = 'Nawa'
    @users = User.all.to_a.map(&:as_json)
    render 'home', locals: { age: 20 }
  end
end
