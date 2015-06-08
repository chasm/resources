class Api::V1::ItemsController < Api::V1::ApiController
  def index
    render json: Item.all.as_json(
      except: [:updated_at, :created_at],
      methods: [:average_rating, :latest_review]
    )
  end

  def show
    if item = Item.find_by_id(params[:id])
      render json: item.as_json(
        except: [:updated_at, :created_at],
        methods: [:average_rating, :latest_review],
        include: {
          reviews: { except: [:updated_at, :created_at, :item_id] }
        }
      )
    else
      render status: 404, json: { error: "requested item not found"}
    end
  end
end