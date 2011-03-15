module JSON
  class Schema
    class ValueDependenciesAttribute < Attribute

      def self.validate(current_schema, data, fragments, validator, options = {})
        if data.is_a?(Hash)
          current_schema.schema['valueDependencies'].each do |property,dependency|
            if data.has_key?(property) && (dependency_value = dependency[data[property]])
              if dependency_value.is_a?(String) && !data.has_key?(dependency_value)
                message = "The property '#{build_fragment(fragments)}' has a property '#{property}' value '#{data[property]}' that depends on a missing property '#{dependency_value}'"
                raise ValidationError.new(message, fragments, current_schema)
              elsif dependency_value.is_a?(Array)
                dependency_value.each do |value|
                  if !data.has_key?(value)
                    message = "The property '#{build_fragment(fragments)}' has a property '#{property}' value '#{data[property]}' that depends on a missing property '#{value}'"
                    raise ValidationError.new(message, fragments, current_schema)
                  end
                end
              else
                #dependency is a schema
                schema = JSON::Schema.new(dependency,current_schema.uri,validator)
                schema.validate(data, fragments)
              end
            end
          end
        end
      end
    end
  end
end