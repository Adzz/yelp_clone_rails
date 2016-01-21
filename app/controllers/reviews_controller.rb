class ReviewsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show] 
  before_action :check_author, :only => [:destroy]

  def check_author
    if current_user.id != Review.find(params[:id]).user_id
      flash[:notice] = "Nice try, wiseguy. You can only edit reviews you added!"
      redirect_to "/restaurants" and return
    end
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end


  def destroy
   @review = Review.find(params[:id])
   @review.destroy
   flash[:notice] = "Review Deleted, happy now?"
   redirect_to "/restaurants"
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

def create
  @restaurant = Restaurant.find(params[:restaurant_id])
  @review = @restaurant.build_review(review_params, current_user)

  if @review.save
    redirect_to restaurants_path
  else
    if @review.errors[:user]
      # Note: if you have correctly disabled the review button where appropriate,
      # this should never happen...
      redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
    else
      # Why would we render new again?  What else could cause an error?
      render :new
    end
  end
end

end
