## Slides 1 - 2: 
- Reintroduce APIs. There are APIs for everything. Show programmableweb api directory.

## Slide 3: 
- Explain how there are APIs which require authentication or authorization. Give a short list of ones that dont: wikipedia, github, itunes, youtube(?), weather data, uk police reports
- Open up github's API page. Show how we can get event data. Show the format of the event data. Talk about how we are going to build a simple app that scrapes the commits of any github user.
- speak briefly on api rate limits

## Slide 4: 
- Show how we are going to take the massive amount of information that comes with a get request, and condense it down to just what we need. 

## Slide 5: 
- Introduce HTTParty as a way to interact with APIs. Show rubydocs page, and github documentation. 

## Slide 6: 
- Ruby model for parsing the raw data from HTTParty.
- first we get raw data from httparty
- then we get only pushevents from the events
- then we get only commits from the events
- then we get only messages from the commits
- then we extract words from the messages.
- then we build a histogram, keeping track of the number of times words appear.
- talk about api rate limiting, and how we need a method to let us know if we've reached the limit. 

## Slide 7: 
- Ruby controller, creates a parser that produces a histogram.
- if we've reached the rate limit, create error message.
- show view, and error message template. briefly explain css. 

## Slide 8: 
- Demo site. Open up code example in terminal. run local server. try a few of the students' usernames. Answer any questions.
