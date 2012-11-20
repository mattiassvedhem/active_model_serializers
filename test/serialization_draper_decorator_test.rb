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
    some_serialized = SomeSerializer.new(SomeDecorator.new(Some.new))
    assert_equal SomeDecorator.new(Some.new).title, some_serialized.title
  end

  def test_uses_decorator_methods
    some_serialized = SomeSerializer.new(SomeDecorator.new(Some.new))
    assert_equal SomeDecorator.new(Some.new).name, some_serialized.name
  end
end