# coding: utf-8
require "data_mapper"
require "dm-timestamps"
require "dm-validations"

class Product
  include DataMapper::Resource

  property :id,
    Serial

  property :name,
    String,
    :required => true,
    :length => 1..100,
    :unique_index => true

  validates_uniqueness_of :name

  property :price,
    Float,
    :required => true,
    :default => 0.01

  property :created_at,
    DateTime

  property :updated_at,
    DateTime

  def self.create_defaults
    products = [
      {
        :name => "80 L Warmwasserspeicher HAJDU 80L Boiler",
        :price => 215.00
      },
      {
        :name => "120 L Warmwasserspeicher AJZ Boiler",
        :price => 330.00
      },
      {
        :name => "240 L Warmwasserspeich LLX Boiler",
        :price => 420
      }
    ]

    products.each do |p|
      product = Product.new(p)
      product.save
    end
  end
end
