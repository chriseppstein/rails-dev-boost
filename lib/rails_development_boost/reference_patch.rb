module RailsDevelopmentBoost
  module ReferencePatch
    if defined?(ActiveSupport::Dependencies::ClassCache) # post Rails' f345e2380cac2560f3bb
      def self.apply!
        ActiveSupport::Dependencies::ClassCache.send :include, self
      end
      
      def loose!(const_name)
        @store.delete(const_name)
      end
    else
      def self.apply!
        ActiveSupport::Dependencies::Reference.cattr_reader :constants
        ActiveSupport::Dependencies::Reference.extend ClassMethods
      end

      module ClassMethods
        def loose!(const_name)
          constants.delete(const_name)
        end
      end
    end
  end
end