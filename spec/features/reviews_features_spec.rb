require "rails_helper"

feature "Reviewing"  do


  scenario "Allows users to leave a review using a form" do
    sign_in_and_create_restaurant
    visit "/restaurants"
    click_link "Review KFC"
    fill_in "Thoughts", with: "Dench"
    select "3", from: "Rating"
    click_button "Leave Review"
    expect(current_path).to eq "/restaurants"
    expect(page).to have_content "Dench"
  end

  scenario 'displays an average rating for all reviews' do
    sign_in_and_create_restaurant
    leave_review('So so', '3')
    click_link "Sign out"
    sign_in_two 
    leave_review('Great', '5')
    expect(page).to have_content('★★★★☆')
  end

end
