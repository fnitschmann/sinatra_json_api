# coding: utf-8
require "logger"
require "json"
require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"

require "./lib/settings"

Dir[File.expand_path("../models/*.rb", __FILE__)].each do |file|
  require file
end

class App < Sinatra::Application
  ::Logger.class_eval { alias :write :'<<' }
  access_log = ::File.new(::File.join(::File.expand_path("../log/access.log", __FILE__)),"a+")
  access_logger = ::Logger.new(access_log)
  error_logger = ::File.new(::File.join(::File.expand_path("../log/error.log", __FILE__)),"a+")
  error_logger.sync = true

  configure :development, :production do
    Settings.configure_database
  end

  configure :test do
    Settings.configure_test_database
  end

  configure do
    use ::Rack::CommonLogger, access_logger

    if Product.all.count == 0
      Product.create_defaults
    end
  end

  before do
    env["rack.errors"] = error_logger

    auth_token = Settings.auth_token
    if !auth_token.nil? && auth_token == params["token"]
      @authorized = true
    end
  end

  get "/" do
    status 200
  end

  get "/customers" do
    return status 401 unless @authorized

    content_type :json
    Customer.all.to_json
  end

  get "/customers/:id" do
    return status 401 unless @authorized

    content_type :json
    customer = Customer.get(params[:id])

    if customer
      customer.to_json
    else
      status 404
      body "404: Not found"
    end
  end

  post "/customers" do
    return status 401 unless @authorized

    content_type :json

    customer_params = params.tap { |p| p.delete("token") }
    customer = Customer.new(customer_params)

    if customer.save
      status 201
      customer.to_json
    else
      status 400
      { :errors => customer.errors.full_messages }.to_json
    end
  end

  get "/products" do
    content_type :json
    Product.all.to_json
  end

  get "/products/:id" do
    content_type :json
    product = Product.get(params[:id])

    if product
      product.to_json
    else
      status 404
      body "404: Not found"
    end
  end

  post "/products" do
    return status 401 unless @authorized

    content_type :json

    product_params = params.tap { |p| p.delete("token") }
    product = Product.new(product_params)

    if product.save
      status 201
      product.to_json
    else
      status 400
      { :errors => product.errors.full_messages }.to_json
    end
  end
end
