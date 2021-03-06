module JSON
  class Schema
    class DependenciesAttribute < Attribute
      def self.validate(current_schema, data, fragments, validator, options = {})
        if data.is_a?(Hash)
          current_schema.schema['dependencies'].each do |property,dependency_value|
            if data.has_key?(property)
              if dependency_value.is_a?(String)
                unless data.has_key?(dependency_value)
                  message = "The property '#{build_fragment(fragments)}' has a property '#{property}' that depends on a missing property '#{dependency_value}'"
                  raise ValidationError.new(message, fragments, current_schema)
                end
              elsif dependency_value.is_a?(Array)
                dependency_value.each do |value|
                  if !data.has_key?(value)
                    message = "The property '#{build_fragment(fragments)}' has a property '#{property}' that depends on a missing property '#{value}'"
                    raise ValidationError.new(message, fragments, current_schema)
                  end
                end
              else
                schema = JSON::Schema.new(dependency_value,current_schema.uri,validator)
                schema.validate(data, fragments)
              end
            end
          end
        end
      end
    end
  end
end