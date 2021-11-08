class Api::V1::PlaygroundController < ApplicationController
  def index
    playground = Playground.all
    render json: playground, status: :ok
  end

  def show
    playground = Playground.find(params[:id])
    if playground == nil
      return render json: {}, status: :not_found
    end
    render json: playground, status: :ok

    ActionCable.server.broadcast 'playground_channel', playground
  end

  def create
    # check if room exist
    if Playground.find_by(roomName: params[:roomName], password: params[:password]) == nil
      playground = Playground.new(playground_params)
      if playground.save
        render json: playground, status: :created
      else
        return render json: playground.errors, status: :unprocessable_entity
      end
    else
      playground = Playground.find_by(roomName: params[:roomName], password: params[:password])
    end
    # serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #   ConversationSerializer.new(playground)
    # ).serializable_hash
    ActionCable.server.broadcast 'playground_channel', playground
  end

  def update
    if Playground.find(params[:id]) == nil
      return render json: {}, status: :unprocessable_entity
    else
      Playground.update(params[:id], playground_update_params)
      playground = Playground.find(params[:id]);
      render json: playground, status: :ok
    end
    ActionCable.server.broadcast 'playground_channel', playground
  end

  # def playerJoin
  #   if Playground.find(params[:id]) == nil
  #     return render json: {}, status: :unprocessable_entity
  #   else
  #     Playground.update(player_join_params)
  #     playground = Playground.find(params[:id]);
  #     ActionCable.server.broadcast 'playground_channel', playground
  #   end
  # end

  private
  def playground_params
    params.require(:playground).permit(:username, :roomName, :password, :moves, :people, :next, :status, :scores)
  end

  def playground_update_params
    params.require(:playground).permit(:next, :moves, :people, :scores, :status, :wonby)
  end

  # def player_join_params
  #   params.require(:playground).permit(:id, :people)
  # end
end
