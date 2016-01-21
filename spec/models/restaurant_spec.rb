require "spec_helper"

describe Restaurant, type: :model  do

  it { is_expected.to have_many :reviews}
  it {should belong_to(:user)}

  it "removes reviews when restaurant is deleted" do
    restaurant = Restaurant.create(name: "Hooters")
    restaurant.reviews.create(thoughts: "good", rating: "2")
    expect{restaurant.destroy}.to change{restaurant.reviews.count}.by(-1)
  end

  it "is not a valid name if it's less than three chars long" do
    restaurant = Restaurant.create(name: "YO")
    expect(restaurant).not_to be_valid
    expect(restaurant).to have(1).error_on(:name)
  end

  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe "#avergae_rating" do
    context "no reviews" do
      it "returns N/A when there no reviews" do
        restaurant = Restaurant.create(name: "Bob's Burgers")
        expect(restaurant.average_rating).to eq "N/A"
      end
    end
  end

  context '1 review' do
    it 'returns that rating' do
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(rating: 4)
      expect(restaurant.average_rating).to eq 4
    end
  end

  context 'multiple reviews' do
    it 'returns the average' do
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(rating: 1)
      restaurant.reviews.create(rating: 5)
      expect(restaurant.average_rating).to eq 3
    end
  end


end

