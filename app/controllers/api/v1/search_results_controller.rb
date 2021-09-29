module Api
  module V1
    class SearchResultsController < ApiBaseController
      def index
        @results = SearchService.call(search_params, current_user)
      end

      private

      def search_params
        params.require(:search).permit(:query, :latlong, :type)
      end
    end
  end
end
