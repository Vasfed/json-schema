# this metaschema is the original metaschema converted to ruby.

module JSON
  class Schema
    def self.metaschema_ll
      original = {
      "id"=>"http://json-schema.org/draft-03/schema#",
      "$schema"=>"http://json-schema.org/draft-03/schema#",
      "dependencies"=>{"exclusiveMaximum"=>"maximum", "exclusiveMinimum"=>"minimum"},
      "default"=>{},
      "type"=>"object",
      "properties"=>
      {"dependencies"=>
        {"default"=>{},
         "additionalProperties"=>
          {"items"=>{"type"=>"string"},
           "type"=>["string", "array", {"$ref"=>"#"}]},
         "type"=>"object"},
       "required"=>{"default"=>false, "type"=>"boolean"},
       "items"=>
        {"items"=>{"$ref"=>"#"}, "default"=>{}, "type"=>[{"$ref"=>"#"}, "array"]},
       "format"=>{"type"=>"string"},
       "maxLength"=>{"type"=>"integer"},
       "title"=>{"type"=>"string"},
       "maximum"=>{"type"=>"number"},
       "extends"=>
        {"items"=>{"$ref"=>"#"}, "default"=>{}, "type"=>[{"$ref"=>"#"}, "array"]},
       "default"=>{"type"=>"any"},
       "enum"=>{"minItems"=>1, "type"=>"array", "uniqueItems"=>true},
       "divisibleBy"=>
        {"default"=>1, "type"=>"number", "minimum"=>0, "exclusiveMinimum"=>true},
       "minLength"=>{"default"=>0, "type"=>"integer", "minimum"=>0},
       "exclusiveMaximum"=>{"default"=>false, "type"=>"boolean"},
       "additionalProperties"=>{"default"=>{}, "type"=>[{"$ref"=>"#"}, "boolean"]},
       "id"=>{"format"=>"uri", "type"=>"string"},
       "disallow"=>
        {"items"=>{"type"=>["string", {"$ref"=>"#"}]},
         "type"=>["string", "array"],
         "uniqueItems"=>true},
       "pattern"=>{"format"=>"regex", "type"=>"string"},
       "minItems"=>{"default"=>0, "type"=>"integer", "minimum"=>0},
       "additionalItems"=>{"default"=>{}, "type"=>[{"$ref"=>"#"}, "boolean"]},
       "patternProperties"=>
        {"default"=>{}, "additionalProperties"=>{"$ref"=>"#"}, "type"=>"object"},
       "type"=>
        {"items"=>{"type"=>["string", {"$ref"=>"#"}]},
         "default"=>"any",
         "type"=>["string", "array"],
         "uniqueItems"=>true},
       "$schema"=>{"format"=>"uri", "type"=>"string"},
       "minimum"=>{"type"=>"number"},
       "$ref"=>{"format"=>"uri", "type"=>"string"},
       "description"=>{"type"=>"string"},
       "uniqueItems"=>{"default"=>false, "type"=>"boolean"},
       "maxItems"=>{"type"=>"integer", "minimum"=>0},
       "exclusiveMinimum"=>{"default"=>false, "type"=>"boolean"},
       "properties"=>
        {"default"=>{}, "additionalProperties"=>{"$ref"=>"#"}, "type"=>"object"}}
      }

      #extensions:
      original["properties"].merge!(
      'valueDependencies' => {
        "type" => "object",
        "patternProperties" => {
          "(.*)" => {
            "description" => "each key is a parameter name (value of it will be checked)",
            "type" => "object",
            "patternProperties" => {
              "(.*)" => {
                "description" => "here keys are exact values of parameter,  values are the same like normal dependencies",
                "type" => ["string", "array", {"$ref"=>"#"}],
                "items" => {"type" => "string"}
              }
            }
          }
        }
      })

      return original
    end
  end
end