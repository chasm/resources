class Api::V1::ReviewsController < Api::V1::ApiController
  def create

    unless item = Item.find_by_id(params[:item_id])
      render status: 404, json: { error: "requested item could not be found" } and return
    end

    review = item.reviews.new(review_params)
    if review.save
      render json: review.as_json(except: [:item_id, :created_at, :updated_at])
    else
      render status: 400, json: { errors: review.errors.full_messages }
    end
  end

  private
    def review_params
      params.require(:review).permit(:title, :body, :rating)
    end
end