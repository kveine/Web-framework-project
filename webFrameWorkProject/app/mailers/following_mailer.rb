class FollowingMailer < ActionMailer::Base
  default from: "newrecipe@myrecipe.com"

  def new_recipe_email(to_users, from_user, title, ingredients, instructions)
  	@to_users = to_users
  	@from_user = from_user
  	@title = title
  	@ingredients = ingredients
  	@instructions = instructions
  	mail(to: @to_users, subject: 'New recipe from #{@from_user}')
  end
end
