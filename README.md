# RookieOven
##Creating a more vibrant startup community in Scotland
The RookieOven website has several aims

* To promote Scottish startups, events and general news through the RookieOven blog
* For information on the monthly RookieOven Meetups
* Provide information on the RookieOven Coworking Space in Govan

Contributions in any way are welcome.

##Getting started

The site is using [Jekyll](http://jekyllrb.com) so make sure you have the Jekyll Gem installed and use ```jekyll serve``` to get started.

 Posts are written in markdown and should be put into the ```_draft``` folder, live posts are kept in the ```_posts``` folder. For general markdown help see the [Markdown Documention by Gruber](http://daringfireball.net/projects/markdown/syntax) there are some custom parts to the blog.
 
####Front Matter
 
 Posts should have front matter in the following format:
 ```
 ---
title: Blog post title
author: 1
layout: post
headerImage: /images/blog/filename.jpg
permalink: /2014/12/08/blog-post-title/
categories:
  - tag1
  - tag2
  - tag3
  - tag4
---
```

####headerImage

The headerImage is used for the large image at the top of each post. Ensure headerImages are legible against the post title which is overlayed. headerImages should be put into the same directory as blog images ie ```/images/blog```.

####Blog Images

Images in the body of a post use a specific format in the RookieOven Markdown and should be in ```/images/blog``` directory..

```
{% image src:"/images/blog/filename.jpg" alt:"alt text" title:"title text" %}
```

This is used for layour purposes and should be used for all images in the body of a post.

####AuthorID

Author id should line up with the author data in the ```/_data/contributors.yml``` folder. This uses the following format:

```
- name: Whole Name
  id: 1
  twitter: handle
```

##Other

If you want to help in any other way or are interested in attending a meetup or joining the RookieOven Co-Working space drop Michael a message michael@rookieoven.com or get him on Twitter [@_MDHayes](http://twitter.com/_MDhayes)
