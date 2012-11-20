require 'test_helper'
require 'draper'

class Some
  include ActiveModel::Serialization

  def title
    "Some stored title"
  end
end

class SomeDecorator < Draper::Base
  decorates :some

  def title
    "Some processed title"
  end
end

class SomeSerializer < ActiveModel::Serializer
  attributes :title
end

class SerializationDraperDecoratorTest < ActionController::TestCase
  def test_uses_decorated_objects_methods
    some_serialized = SomeSerializer.new(SomeDecorator.new(Some.new))
    assert_equal SomeDecorator.new(Some.new).title, some_serialized.title
  end
end