# frozen_string_literal: true

require "dependabot/file_fetchers"
require "dependabot/file_fetchers/base"

module Dependabot
  module GitlabCi
    class FileFetcher < Dependabot::FileFetchers::Base
      def self.required_files_in?(filenames)
        filenames.include?(".gitlab-ci.yml")
      end

      def self.required_files_message
        "Repo must contain a .gitlab-ci.yml file."
      end

      private

      def fetch_files
        fetched_files = []
        fetched_files << gitlabci_file
        fetched_files
      end

      def gitlabci_file
        @gitlabci_file ||= fetch_file_from_host(".gitlab-ci.yml")
      end
    end
  end
end

Dependabot::FileFetchers.register("gitlab-ci", Dependabot::GitSubmodules::FileFetcher)
