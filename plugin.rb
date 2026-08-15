# frozen_string_literal: true

# name: kigubbs
# about: TODO
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

gem "ulid", "1.4.0"

enabled_site_setting :kigubbs_enabled

module ::Kigubbs
  PLUGIN_NAME = "kigubbs"
end

require_relative "lib/kigubbs/engine"

after_initialize do
  # Code which should run after Rails has finished booting
end
