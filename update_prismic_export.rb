#!/usr/bin/env ruby
# Expects the prismic export to be in a folder named 'export'
# Filters them by type = blog_post and updates the meta data
# based on the _posts md files' frontmatter
#
require "front_matter_parser"
require "json"
require "SecureRandom"
require "fileutils"
require "colorize"
require "jekyll"
require "nokogiri"

@file_count = 0

def posts
  @posts ||= Dir
    .children("_posts")
    .map { |filename| "_posts/#{filename}" }
end

def blog_post_data
  @export_data ||= Dir
    .children("export")
    .select { |filename| filename.end_with? ".json" }
    .map do |filename|
    path = File.join(FileUtils.pwd, "export", filename)
    pp "Parsing file at #{path}"
    contents = File.open(path, "rb").read
    json = JSON.parse(contents)

    {
      filename: filename,
      path: path,
      json: json,
    }
  end
    .select { |data| data[:json]["type"] == "blog_post" }
    .map do |data|
    json = data[:json]

    date = json["published_date"]
    uid = json["uid"]
    post_path = "_posts/#{date}-#{uid}.md"

    parsed = FrontMatterParser::Parser.parse_file(post_path)
    frontmatter = parsed.front_matter

    data.merge({
      post_path: post_path,
      frontmatter: frontmatter,
    })
  end
end

@uid = SecureRandom.hex(4)
@output_dir = "prismic-export-updated-#{@uid}"
puts "Created output directory".green

def write_json(data)
  pp "Writing json for #{data[:post_path]} to #{data[:filename]}"

  group_index = @file_count / 200
  output_dir = "#{@output_dir}-#{group_index}"
  Dir.mkdir(output_dir) unless File.directory?(output_dir)

  output_file_path = "#{output_dir}/#{data[:filename]}"
  File.write(output_file_path, JSON.dump(data[:json]))
  @file_count += 1
end

blog_post_data.map do |export|
  desc = export[:frontmatter]["description"]

  json = export[:json]
  new_json = json.merge({
    "meta_title" => json["title"],
    "meta_description" => desc,
    "short_summary" => desc,
    "og_image" => json["list_image"] || json["header_image"],
    "subtitle" => desc,
  })

  export = export.merge({json: new_json})

  write_json(export)
end

# AUTHORS = {
#   "1" => {
#     # name: "Michael Hayes",
#     id: "W2GE0B8AAB0Ar4Lc",
#     mask: "author",
#   },

#   "2" => {
#     # name: "Jamie McHale",
#     id: "W2GFPB8AACQAr4S_",
#     mask: "author",
#   },

#   "3" => {
#     # name: "Cally Russell",
#     id: "W2GFVB8AACEAr4Ux",
#     mask: "author",
#   },

#   "4" => {
#     # name: "David Wong",
#     id: "W2GFbh8AACEAr4Wj",
#     mask: "author",
#   },

#   "5" => {
#     # name: "Gregg O'Malley",
#     id: "W2GFhR8AACEAr4YX",
#     mask: "author",
#   },

#   "6" => {
#     # name: "Rich Smith",
#     id: "W2GFmx8AAB0Ar4Z8",
#     mask: "author",
#   },

#   "7" => {
#     # name: "Morgan Roberts",
#     id: "W2GFuh8AACQAr4cE",
#     mask: "author",
#   },

#   "8" => {
#     # name: "Kyle Bremner",
#     id: "W2GFwx8AACQAr4cv",
#     mask: "author",
#   },

#   "9" => {
#     # name: "John Bell",
#     id: "W2GF3B8AAB8Ar4ei",
#     mask: "author",
#   },

#   "10" => {
#     # name: "Peter Retson",
#     id: "W2GF_B8AAB0Ar4g5",
#     mask: "author",
#   },

#   "11" => {
#     # name: "Michael Carr",
#     id: "W2GGJB8AAB0Ar4ju",
#     mask: "author",
#   },

#   "12" => {
#     # name: "Charlotte Dougall",
#     id: "W2GFDB8AAB8Ar4Pt",
#     mask: "author",
#   },

#   "13" => {
#     # name: "Rachel Guthartz",
#     id: "W2GGQR8AAB8Ar4lx",
#     mask: "author",
#   },
# }

# # source path => output path
# COPIED_FILES = {}

# def imported_image(key, path, base_dir)
#   return nil unless path

#   input_location = File.join(FileUtils.pwd, path)

#   unless File.file? input_location
#     puts "\tFile at #{path} doesn't exist".red
#     puts "\t\tFull Path: #{input_location}"
#     return
#   end

#   file_path = if COPIED_FILES[path]
#                 COPIED_FILES[path]
#               else
#                 ext = path.split(".").last
#                 new_file_path = "images/#{key}.#{ext}"

#                 # Copy the file
#                 output_location = "#{base_dir}/#{new_file_path}"
#                 output_dir = "#{base_dir}/images"
#                 Dir.mkdir(output_dir) unless File.directory?(output_dir)
#                 FileUtils.cp(input_location, output_location)
#                 @file_count += 1

#                 # Cache result url
#                 COPIED_FILES[path] = new_file_path
#               end

#   {
#     origin: {
#       url: file_path,
#     },
#     url: file_path,
#   }
# end

# def write_json(post, output_dir)
#   group_index = @file_count / 200
#   output_dir = "#{output_dir}-#{group_index}"
#   Dir.mkdir(output_dir) unless File.directory?(output_dir)

#   puts "\tProcessing #{post}"

#   parsed = FrontMatterParser::Parser.parse_file(post)
#   data = parsed.front_matter

#   # Get date and uid from permalink
#   # Permalink is of format /2018/02/17/hello-world-2
#   # uid is hello-world-2 and post_date is 2018-02-17
#   permalink = data["permalink"]
#   uid = permalink.split("/").last
#   post_date = permalink.split("/")[1..3].join("-")

#   # Find the jekyll-outputted content file
#   # Output is to pwd/_site
#   # Post is either in /year/month/day/uid.html or /year/month/day/uid/index.html
#   uid_html = File.join(FileUtils.pwd, "_site", permalink.split(".").first + ".html")
#   index_html = File.join(FileUtils.pwd, "_site", permalink.split(".").first, "index.html")
#   html_location = if File.file? uid_html
#                     uid_html
#                   elsif File.file? index_html
#                     index_html
#                   else
#                     puts "Couldn't find html file for post".red
#                     puts "Tried:".red
#                     puts "\t#{uid_html}".red
#                     puts "\t#{index_html}".red
#                   end

#   # Format the html for prismic
#   html = File.open(html_location, "rb").read
#   doc = Nokogiri::HTML(html)
#   post_html = doc.css(".post")
#   post_html.search(".author").remove
#   post_html.search(".date").remove
#   post_html.search(".relatedPosts").remove
#   post_html = post_html.first.to_s

#   # Prismic wraps indented <p> tags in <code> for some reason, even in their basic text field
#   post_html = post_html.gsub(/\n/, "")
#   post_html = post_html.gsub(/\t/, "")

#   output = {
#     type: "blog_post",
#     lang: "en-gb",
#     uid: uid,
#     tags: data["categories"] || [],
#     published_date: post_date,
#     title: data["title"],
#     subtitle: "",
#     author: AUTHORS["#{data["author"]}"],
#     header_image: imported_image("#{uid}-header_image", data["headerImage"] || data["image"], output_dir),
#     list_image: imported_image("#{uid}-list_image", data["image"] || data["headerImage"], output_dir),
#     body: [
#       {
#         "key": "raw-html-md",
#         "value": {
#           "repeat": [
#             {},
#           ],
#           "non-repeat": {
#             "text": post_html,
#           },
#         },
#       },
#     ],
#   }

#   output_file_path = "#{output_dir}/new_#{SecureRandom.uuid}_en-gb.json"
#   File.write(output_file_path, JSON.dump(output))
#   @file_count += 1
# end

# # Process site
# puts "Generating Jekyll site..."
# conf = Jekyll.configuration({
#   "source" => FileUtils.pwd,
# })
# Jekyll::Site.new(conf).process
# puts "...done".green

# # Process
# puts "Exporting #{posts.length} posts"

# # Prismic accepts up to 200 documents per archive, including images
# # Create folder
# output_dir = "prismic-export-updated-#{uid}"
# puts "Created output directory".green

# # Add json
# puts "Parsing posts"
# posts.map do |post|
#   write_json(post, output_dir)
# end

# # Done
# puts "Finished exporting #{posts.length} posts".green

# # TODO Zip folder contents
# puts "\n\n--------"
# puts "Zip the " + "contents".cyan + " of the folder(s) to upload to prismic."
# puts "Do not zip the folder itself, Prismic won't like it."
# puts "Export id is #{uid}"
# puts "\nhttps://rookieoven.prismic.io/settings/import/"
# puts "--------"
