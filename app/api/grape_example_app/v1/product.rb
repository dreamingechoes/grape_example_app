module GrapeExampleApp
  class V1::Product < Grape::API
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
          desc: 'Params attributes of product'
        }
      end
    end

    resource :products do
      desc 'REST GET with no other parameter than authentication token.' do
        detail <<-NOTE
            Make a query for products.
            -----------------

            Returns an array of all products.
          NOTE
      end
      params do
        use :token, type: String, desc: 'Authentication token'
      end
      get do
        api_response(::Product.all.to_json)
      end

      route_param :id do
        desc 'REST GET with id param.' do
          detail <<-NOTE
              Make a query for a product with certain id.
              -----------------

              Returns the result of query for a product.
            NOTE
        end
        params do
          use :token, type: String, desc: 'Authentication token'
          use :id, type: Integer, desc: 'Product ID'
        end
        get do
          begin
            authenticate!

            product = ::Product.find(params[:id])
            api_response(product.to_json)
          rescue ActiveRecord::RecordNotFound => e
            status 404 # Not found
          end
        end
      end

      desc 'REST Post with attributes param.' do
        detail <<-NOTE
            Creates a product with the information passed through attributes param.
            -----------------

            This is a hash, with the estruture:

            ```
              {"name": "Example", "description": "Description example", "image_url": "url", "price": 30, "stock": 4}
            ```
          NOTE
      end
      params do
        use :token
        requires :attributes, type: Hash, desc: 'Product object to create' do
          requires :name, type: String, desc: 'Name of product'
          requires :description, type: String, desc: 'Description of product'
          requires :image_url, type: String, desc: 'URL of image for product'
          requires :price, type: Integer, desc: 'Price of product'
          requires :stock, type: Integer, desc: 'Stock of product'
        end
      end
      post do
        begin
          authenticate!
          safe_params = clean_params(params[:attributes])
                        .permit(:name, :description, :image_url, :price, :stock)

          if safe_params
            ::Product.create!(safe_params)
            status 200 # Saved OK
          end
        rescue ActiveRecord::RecordNotFound => e
          status 404 # Not found
        end
      end

      desc 'REST Put with attributes param.' do
        detail <<-NOTE
            Updates a product with the information passed through attributes param.
            -----------------

            This is a hash, with the estruture:

            ```
              {"name": "Example", "description": "Description example", "image_url": "url", "price": 30, "stock": 4}
            ```
          NOTE
      end
      params do
        use :token, type: String, desc: 'Authentication token'
        use :id, type: Integer, desc: 'Product ID'
        requires :attributes, type: Hash, desc: 'Product object to create' do
          requires :name, type: String, desc: 'Name of product'
          requires :description, type: String, desc: 'Description of product'
          requires :image_url, type: String, desc: 'URL of image for product'
          requires :price, type: Integer, desc: 'Price of product'
          requires :stock, type: Integer, desc: 'Stock of product'
        end
      end
      put ':id' do
        begin
          authenticate!
          safe_params = clean_params(params[:attributes]).permit(:name, :description, :image_url, :price, :stock)

          if safe_params
            product = ::Product.find(params[:id])
            product.update_attributes(safe_params)
            status 200 # Saved OK
          end
        rescue ActiveRecord::RecordNotFound => e
          status 404 # Not found
        end
      end
    end

  end
end
