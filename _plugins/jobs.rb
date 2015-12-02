require "open-uri"
require "yaml"

module Jekyll
  class AdminGenerator < Generator
    safe true

    def generate(site)
      positions_yml = open("http://admin.rookieoven.com/jobs.yml").read
      positions = YAML.load(positions_yml)
      site.data["jobs"]["positions"] = positions
    end
  end
end
