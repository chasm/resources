class Api::V1::CategoriesController < Api::V1::ApiController
  def index
    render json: Category.all.as_json(only: [:id, :title])
  end

  def show
    if category = Category.find_by_id(params[:id])
      render json: category.as_json(
        only: [:id, :title],
        include: {
          items: { 
            except: [:created_at, :updated_at, :category_id],
            methods: [:average_rating, :latest_review]
          }
        }
      )
    else
      render status: 404, json: { 
        error: "requested category not found"
      }
    end
  end
end