# coding: utf-8
require "data_mapper"
require "dm-timestamps"
require "dm-validations"

class Customer
  include DataMapper::Resource

  property :id,
    Serial

  property :company,
    String,
    :required => true,
    :length => 1..50

  property :contact_person,
    String,
    :required => true,
    :length => 1..50

  property :email,
    String,
    :required => true,
    :length => 1..100,
    :unique_index => true

  validates_uniqueness_of :email

  property :address,
    String,
    :required => true,
    :length => 1..100

  property :yearly_turnover,
    String,
    :required => true,
    :default => "< 500.000"

  property :created_at,
    DateTime

  property :updated_at,
    DateTime

  def url
    "/customers/#{self.id}"
  end
end
