module Jekyll
  class ImageTag < Liquid::Tag
    def initialize(tag_name, params, tokens)
      super
      @attributes = {}
      params.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = value
      end
    end

    def render(context)
      html = '<div class="image">'
      html << "<img src=#{@attributes['src']} alt=#{@attributes['alt']} title=#{@attributes['title']}>"
      html << '</div>'
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::ImageTag)
