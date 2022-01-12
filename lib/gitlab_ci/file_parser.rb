# frozen_string_literal: true

require "dependabot/dependency"
require "dependabot/file_parsers"
require "dependabot/file_parsers/base"
require "dependabot/errors"

module Dependabot
  module GitlabCi
    class FileParser < Dependabot::FileParsers::Base
      require "dependabot/file_parsers/base/dependency_set"

      #At the moment it only works on files with one include
      INCLUDE_WITH_REF = /^include:(.|\n)*project: '(?<project>.*)'(.|\n)*ref: (?<version>\S*)/mi.freeze

      def parse
        dependency_set = DependencySet.new
        
        if INCLUDE_WITH_REF.match?(gitlabcifile.content)
          parsed_from_file = INCLUDE_WITH_REF.match?(gitlabcifile.content).named_captures

          dependency_set << Dependency.new(
            name: "include",
            version: parsed_from_file["version"],
            package_manager: "gitlab-ci",
            requirements: [
              requirement: nil,
              groups: [],
              file: gitlabcifile.name,
              source: parsed_from_file['project']
            ]
          )
        end

        dependency_set.dependencies
      end

      private

      def gitlabcifile
        # The Gitlabci file fetcher only fetches one gitlab-ci.yml file, so no need to
        # filter here
        dependency_files.first
      end

      def check_required_files
        # Just check if there are any files at all.
        return if dependency_files.any?

        raise "No gitlab-ci.yml file!"
      end
    end
  end
end

Dependabot::FileParsers.register("gitlab-ci", Dependabot::GitlabCi::FileParser)
