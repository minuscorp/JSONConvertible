# JSONConvertible
[![Build Status](https://travis-ci.org/minuscorp/JSONConvertible.svg?branch=main)](https://travis-ci.org/minuscorp/JSONConvertible) 
[![Gem Version](https://badge.fury.io/rb/json_convertible.png)](http://badge.fury.io/rb/json_convertible)
[![Coverage Status](https://coveralls.io/repos/github/minuscorp/JSONConvertible/badge.svg?branch=main)](https://coveralls.io/github/minuscorp/JSONConvertible?branch=main)

A lightweight Ruby mixin for encoding and decoding JSON data classes.

## Requirements

Ruby 2.4.0 or higher.

## Install

```no-highlight
gem install json_convertible
```

Alternatively you can use bundler`:

```ruby
gem "json_convertible"
```

## Usage

From within a class:

```ruby
require "json_convertible"

class Example
  include JSONConvertible
end
``` 

This produces the mixin to be included in the class, which allows the call of two main methods:

```ruby
object = Example.new

# Encode to an object dictionary
object.to_object_dictionary # => {}

# Decode from an object dictionary
Example.from_json({}) # => #<Example>
```

## Basic usage

For straightforward one-to-one attribute mapping the mixin works out-of-box:

```ruby
class AttributedExample
  include JSONConvertible
  
  attr_accessor :one
  attr_accessor :two

  def initialize(one: nil, two: nil)
    self.one = one
    self.two = two
  end
end

object = AttributedExample.new(one: "Hello", two: Time.at(0))

object.to_object_dictionary # => => {"one"=>"Hello", "two"=>1970-01-01 01:00:00 +0100}

deserialized = AttributedExample.from_json!(
                { "one" => "Hello", 
                  "two" => Time.at(0).strftime("%G-W%V-%uT%R%:z") 
                }
               ) # => #<AttributedExample @one="Hello", @two=1970-01-01 01:00:00 +0100>
```

## Advanced usage

1. Custom type properties:

```ruby
class CustomExample
  include JSONConvertible

  def self.attribute_to_type_map
    {
      :@example => Example
    }
  end 

  # @return [Example]
  attr_accessor :example

  def initialize(example: nil)
    self.example = example
  end
end
```

2. Array type properties:

```ruby
class ArrayExample
  include JSONConvertible

  def self.attribute_to_type_map
    {
      :@example => Example
    }
  end

  # @return [Array(Example)]
  attr_accessor :example_array

  def initialize(example_array: nil)
    self.example_array = example_array
  end
end
```

3. Multiple attribute array object:

```ruby
class MultipleAttributeArrayExample
  include JSONConvertible

  attr_accessor :one_array_attribute

  attr_accessor :other_array_attribute

  def initialize(one_array_attribute: nil, other_array_attribute: nil)
    self.one_array_attribute = one_array_attribute
    self.other_array_attribute = other_array_attribute
  end

  def self.map_enumerable_type(enumerable_property_name: nil, current_json_object: nil)
    if enumerable_property_name == :@one_array_attribute
      object = OpenStruct.new(current_json_object)
      object.is_from_one_array_attribute = true
      return object
    elsif enumerable_property_name == :@other_array_attribute
      object = OpenStruct.new(current_json_object)
      object.is_from_other_array_attribute = true
      return object
    end
  end
end
```

4. Required attribute objects:

```ruby
class ExampleWithRequiredParams
  include JSONConvertible

  attr_reader :one_attribute

  def initialize(one_attribute:)
    @one_attribute = one_attribute
  end
end
```

5. Custom value mapping for attributes:

```ruby
class CustomExample
  include JSONConvertible

  def self.json_to_attribute_name_proc_map
    {
      :@example => proc { |_| "foo" }
    }
  end 

  attr_accessor :example

  def initialize(example: nil)
    self.example = example
  end
end
```

* All of this cases can be seen in the specs

## Acknowledgements

This project is inspired on the `JSONConvertible` util created by the [_fastlane_ CI team](https://github.com/fastlane/ci)
