# frozen_string_literal: true

require "dependabot/utils"

module Dependabot
  module GitlabCi
    class Version < Gem::Version
    end
  end
end

Dependabot::Utils.register_version_class("gitlab-ci", Dependabot::GitlabCi::Version)
