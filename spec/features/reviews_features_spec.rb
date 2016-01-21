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



end
