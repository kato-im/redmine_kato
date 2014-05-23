module RedmineKato
  module Patches
    module ProjectPatch
      def self.included(base)
        base.class_eval do
          safe_attributes 'kato_url'
        end
      end
    end
  end
end
