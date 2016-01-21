require "rails_helper"

feature "restaurants" do

  context "No restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      sign_in
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet!"
      expect(page).to have_link "Add a restaurant"
    end
  end
  context "restaurants have been added" do
    before do
      Restaurant.create(name: "Hooters")
    end
  
    scenario "display restaurants" do
      sign_in
      visit "/restaurants"
      expect(page).to have_link "Hooters"
    end
  end
 
  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_in_and_create_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario "User must be logged in before creating a restaurant" do
       sign_in
       visit '/restaurants'
       click_link "Sign out"
       expect(page).not_to have_content "Add a restaurant"
    end

  end

  context 'viewing restaurants' do

    let!(:hooters){Restaurant.create(name:'Hooters')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Hooters'
      expect(page).to have_content 'Hooters'
      expect(current_path).to eq "/restaurants/#{hooters.id}"
    end

  end

  context 'deleting restaurants' do

    before { sign_in_and_create_restaurant }

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit "/restaurants"
      click_link 'Delete KFC'
      expect(page).not_to have_content 'Hooters'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context "an invalid restaurant" do
    it "does not let you submit a name that is too short" do
      sign_in
      visit "/restaurants"
      click_link "Add a restaurant"
      fill_in "Name", with: "AD"
      click_button "Create Restaurant"
      expect(page).not_to have_css "h2", text: "AD"
      expect(page).to have_content "error"
    end
  end


end
