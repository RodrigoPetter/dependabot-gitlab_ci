# frozen_string_literal: true

require "dependabot/metadata_finders"
require "dependabot/metadata_finders/base"

module Dependabot
  module GitlabCi
    class MetadataFinder < Dependabot::MetadataFinders::Base
      private

      def look_up_source
        # TODO: Find a way to add links to PRs
        nil
      end
    end
  end
end

Dependabot::MetadataFinders.register("gitlab-ci", Dependabot::GitlabCi::MetadataFinder)
