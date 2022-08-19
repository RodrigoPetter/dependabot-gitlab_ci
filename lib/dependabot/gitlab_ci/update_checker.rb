# frozen_string_literal: true

require "dependabot/update_checkers"
require "dependabot/update_checkers/base"

module Dependabot
  module GitlabCi
    class UpdateChecker < Dependabot::UpdateCheckers::Base
      def latest_version
        @latest_version ||= fetch_latest_version
      end

      def latest_resolvable_version
        # Resolvability isn't an issue
        latest_version
      end

      def latest_resolvable_version_with_no_unlock
        # No concept of "unlocking"
        latest_version
      end

      def updated_requirements
        #We never want to update
        dependency.requirements
      end

      private

      def latest_version_resolvable_with_full_unlock?
        # Full unlock checks aren't relevant
        false
      end

      def updated_dependencies_after_full_unlock
        raise NotImplementedError
      end

      def fetch_latest_version
        # TODO: Deve usar os dados descobertos pelo file_parser para buscar a última tag do projeto que é feito a referência
        Version.new("6.4.0")        
      end
    end
  end
end

Dependabot::UpdateCheckers.register("gitlab-ci", Dependabot::GitlabCi::UpdateChecker)
