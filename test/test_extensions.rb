require 'test/unit'
require File.dirname(__FILE__) + '/../lib/json-schema'

class ExtensionsTest < Test::Unit::TestCase
  def test_value_dependencies
    schema = {
      "type" => "object",
      "properties" => {
        "status" => { "enum" => ["a", "b", "c"]}
      },
      "valueDependencies" => {
        "status" => {
          "a" => "status_a"
        }
      }
    }
    data = {"status" => "a", "status_a" => 1}
    assert(JSON::Validator.validate(schema,data))
    data = {"status" => "b"}
    assert(JSON::Validator.validate(schema,data))

    #invalid:
    data2 = {"status" => "a", "status_a_not_here" => 1}
    assert(!JSON::Validator.validate(schema,data2))
    data3 = {"status" => "a"}
    assert(!JSON::Validator.validate(schema,data3))

  end

  def test_metaschema
    assert JSON::Validator.validate(JSON::Schema::metaschema, JSON::Schema::metaschema)
  end
end