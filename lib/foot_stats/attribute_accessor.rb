module FootStats
  module AttributeAccessor
    def self.included(base)
      base.extend(ClassMethods)
    end

    def attributes
      attrs = Hash.new
      self.class.attributes.each{ |attribute| attrs[attribute] = send attribute }
      attrs
    end

    module ClassMethods
      def attributes
        @attributes ||= []
      end

      def attribute_accessor(*attrs)
        self.attributes.concat attrs
        attr_accessor *attrs
      end
    end
  end
end