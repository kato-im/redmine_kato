module RedmineKato
  module Patches
    module ProjectPatch
      def self.included(base)
        base.class_eval do
          safe_attributes 'kato_url'
          safe_attributes 'kato_uses_markdown'
        end
      end
    end
  end
end
