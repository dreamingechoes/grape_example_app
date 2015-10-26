module GrapeExampleApp
  class V1::Review < Grape::API
    use Rack::JSONP

    helpers do
      params :token do
        optional :token, type: String, default: nil,
        documentation: {
          type: 'String',
          desc: 'Authenticate token'
        }
      end

      params :attributes do
        optional :attributes, type: Hash, default: {},
        documentation: {
          type: 'Hash',
          desc: 'Params attributes of review'
        }
      end
    end

    resource :reviews do
      desc 'REST GET with no other parameter than authentication token.' do
        detail <<-NOTE
            Make a query for reviews.
            -----------------

            Returns an array of all reviews.
          NOTE
      end
      params do
        use :token, type: String, desc: 'Authentication token'
      end
      get do
        api_response(::Review.all.to_json)
      end

      route_param :id do
        desc 'REST GET with id param.' do
          detail <<-NOTE
              Make a query for a review with certain id.
              -----------------

              Returns the result of query for a review.
            NOTE
        end
        params do
          use :token, type: String, desc: 'Authentication token'
        end
        get do
          begin
            authenticate!

            review = ::Review.find(params[:id])
            api_response(review.to_json)
          rescue ActiveRecord::RecordNotFound => e
            status 404 # Not found
          end
        end
      end

      desc 'REST Post with attributes param.' do
        detail <<-NOTE
            Creates a review with the information passed through attributes param.
            -----------------

            This is a hash, with the estruture:

            ```
              {"name": "Example", "description": "Description example", "image_url": "url", "price": 30, "stock": 4}
            ```
          NOTE
      end
      params do
        use :token
        requires :attributes, type: Hash, desc: 'Review object to create' do
          requires :title, type: String, desc: 'Title of review'
          requires :body, type: String, desc: 'Body of review'
        end
      end
      post do
        begin
          authenticate!
          safe_params = clean_params(params[:attributes]).permit(:title, :body)

          if safe_params
            ::Review.create!(safe_params)
            status 200 # Saved OK
          end
        rescue ActiveRecord::RecordNotFound => e
          status 404 # Not found
        end
      end

      desc 'REST Put with attributes param.' do
        detail <<-NOTE
            Updates a review with the information passed through attributes param.
            -----------------

            This is a hash, with the estruture:

            ```
              {"name": "Example", "description": "Description example", "image_url": "url", "price": 30, "stock": 4}
            ```
          NOTE
      end
      params do
        use :token, type: String, desc: 'Authentication token'
        requires :attributes, type: Hash, desc: 'Review object to create' do
          requires :title, type: String, desc: 'Title of review'
          requires :body, type: String, desc: 'Body of review'
        end
      end
      put ':id' do
        begin
          authenticate!
          safe_params = clean_params(params[:attributes]).permit(:title, :body)

          if safe_params
            review = ::Review.find(params[:id])
            review.update_attributes(safe_params)
            status 200 # Saved OK
          end
        rescue ActiveRecord::RecordNotFound => e
          status 404 # Not found
        end
      end
    end

  end
end
