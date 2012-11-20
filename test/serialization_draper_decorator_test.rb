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

  def name
    "Something"
  end
end

class SomeSerializer < ActiveModel::Serializer
  attributes :title, :name
end

class SerializationDraperDecoratorTest < ActiveModel::TestCase
  def test_uses_overriden_methods
    decorated_some = SomeDecorator.new(Some.new)
    some_serialized = SomeSerializer.new(decorated_some)
    assert_equal decorated_some.title, some_serialized.title
  end

  def test_uses_decorator_methods
    decorated_some = SomeDecorator.new(Some.new)
    some_serialized = SomeSerializer.new(decorated_some)
    assert_equal decorated_some.name, some_serialized.name
  end
end