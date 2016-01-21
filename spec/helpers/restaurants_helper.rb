
def sign_in
  User.create(email: "test@live.com", password: "password", password_confirmation: "password")
  visit '/restaurants'
  click_link 'Sign in'
  fill_in "Email", with: "test@live.com"
  fill_in "Password", with: "password"
  click_button 'Log in'
end

  def sign_in_two
    User.create(email: "test@email.com", password: "12345678", password_confirmation: "12345678")
    visit '/restaurants'
    click_link 'Sign in'
    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "12345678"
    click_button 'Log in'
  end

def sign_in_and_create_restaurant
  sign_in
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
