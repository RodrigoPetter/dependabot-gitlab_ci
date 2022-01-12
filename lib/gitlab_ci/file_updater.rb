# frozen_string_literal: true

require "dependabot/file_updaters"
require "dependabot/file_updaters/base"

module Dependabot
  module GitlabCi
    class FileUpdater < Dependabot::FileUpdaters::Base
      def self.updated_files_regex
        [/gitlab-ci.yml/i]
      end

      def updated_dependency_files
        [updated_file(
          file: dependency_files.first,
          content: updated_gitlabci_content(dependency_files.first)
        )]
      end

      private

      def updated_gitlabci_content(file)
        file.content.gsub(dependency.previous_version, dependency.version)
      end

      def dependency
        # will only ever be updating a single dependency
        dependencies.first
      end
      
    end
  end
end

Dependabot::FileUpdaters.register("gitlab-ci", Dependabot::GitlabCi::FileUpdater)
