# frozen_string_literal: true

# These all need to be required so the various classes can be registered in a
# lookup table of package manager names to concrete classes.
require "dependabot/gitlab_ci/file_fetcher"
require "dependabot/gitlab_ci/file_parser"
require "dependabot/gitlab_ci/update_checker"
require "dependabot/gitlab_ci/file_updater"
require "dependabot/gitlab_ci/metadata_finder"
###  require "dependabot/git_submodules/requirement"
###  require "dependabot/git_submodules/version"

require "dependabot/pull_request_creator/labeler"
Dependabot::PullRequestCreator::Labeler.
  register_label_details("gitlab-ci", name: "gitlab-ci", colour: "e17f3c")

require "dependabot/dependency"
Dependabot::Dependency.
  register_production_check("gitlab-ci", ->(_) { true })