module Api
  module V1
    class FavoritesController < ApiBaseController
      def index
        @favorites = current_user.favorites
      end

      def create
        @favorite = Favorite.new(user: current_user, place_id: favorite_params[:place_id])

        if @favorite.save
          render :show
        else
          render :error, status: :unprocessable_entity
        end
      end

      def destroy
        @favorite = Favorite.find(params[:id])

        @favorite.destroy

        head :no_content
      end

      private

      def favorite_params
        params.require(:favorite).permit(:place_id)
      end
    end
  end
end
