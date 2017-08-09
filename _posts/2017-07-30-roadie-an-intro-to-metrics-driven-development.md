---
title: An Introduction to Metrics Driven Development — build features that change real numbers.
author: 11
layout: post
description: Explore Metrics Driven Development with a concrete example of how to build features that change the analytics that matter to your startup.
image: /images/blog/roadie/heading.jpg
permalink: /2017/07/30/roadie-metrics-driven-development
categories:
 - development
 - startup
 - metrics
---
How many times have developers picked up tickets because they were in the backlog? Delivered them and never asked why? Metrics driven development tries to put an end to this. It focuses the teams and business on building features that aim to have high impact on what matters i.e. logins, revenue, or sign ups. You can read more about this in a [blog I posted back in February](https://medium.com/redlightmikey/metrics-driven-development-1c1889dda6ac). I want to talk about where I used this methodology in a real world example, and how this could change the way your organisation works forever.

Recently at Roadie, a Dundee based startup helping learner drivers find the right driving instructor, we have been trying to increase the number of our booking requests. The process is lightweight and something other startups can pick up easily.

We started by looking what we were trying to achieve; more booking requests. Then we looked at our metrics for search results and seen we have 60% drop off. Right now our booking conversion is around 4% so in theory if we managed to lower this drop off we would see more booking requests. A leap of faith assumption but we went with it.

{% image src:"/images/blog/roadie/analytics-original.png" alt:"Roadie Dundee search results analytics" title:"Original analytics with a high bounce rate" %}

So, the objective was simple: Reduce bounce rate on search by 5%. This is our __criteria for success__

Next, we had a brainstorming session where came up with possible solutions, all varying degrees of work.

{% image src:"/images/blog/roadie/trello-options.png" alt:"Brainstorming options for search results" title:"Options for improving search results" %}

We discussed what we thought were worth taking on and that could have high impact. As a team we voted and began the work.

We released three changes on that list; *higher resolution images, banner for popular instructors and a nicer heading*.

Then we released those changes.

__The process of gathering metrics, deciding what to do, then implementing the changes took less than 1 hour.__

When the (cross-functional) team has a clear goal i.e. increase conversion and the team is left to their own devices to solve the problem, development becomes a lot faster. Ownership aids delivery.

{% image src:"/images/blog/roadie/search-results.png" alt:"Roadie Dundee search results" title:"Dundee driving lessons search results within Roadie" %}

###### View [Driving Lessons in Dundee](https://www.goroadie.com/search/dundee) results.

The real test comes from looking back at the analytics. Did we succeed? Is the bounce rate lower?

{% image src:"/images/blog/roadie/analytics-after.png" alt:"Roadie analytics for search greatly improved" title:"Improved search analytics for driving instructors" %}

Ten days after the change, I think the metrics speak for themselves.  60.26% to 46.38% is definite win. This is something we will continue to measure in the coming weeks. However, we did make an assumption that decreasing the search bounce rate would increase the number of requests overall. It is too early to tell if this change has a significant impact on booking requests, however by watching those metrics, and having a predefined __criteria for success__ the team knows that the deliverables met the desired outcome; to lower the bounce rate by 5%.

By using Metrics Driven Development, the team were able to quickly deliver features as the nature of the problem was clear, and by writing out the criteria for success beforehand it is easy to judge wither they failed or not. Using these steps could drastically speed up delivery. Focussing on metrics daily will help startups prioritise it's backlog, give real clarity of success and failure. Try it, putting your analytics first will change the way you look at startups and software.

Michael Carr

Founder of [Roadie](https://www.goroadie.com)

[Twitter](https://www.twitter.com/redlightmikey)

[Blog](https://www.medium.com/@redlightmikey)
