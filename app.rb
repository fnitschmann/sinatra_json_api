# coding: utf-8
require "json"
require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"

require "./lib/settings"

Dir[File.expand_path("../models/*.rb", __FILE__)].each do |file|
  require file
end

class App < Sinatra::Application
  configure :development, :production do
    Settings.configure_database
  end

  configure :test do
    Settings.configure_test_database
  end

  before do
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
end
