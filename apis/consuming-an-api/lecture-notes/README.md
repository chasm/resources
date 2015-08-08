## Slides 1 - 2: 
- Reintroduce APIs. There are APIs for everything. Show programmableweb api directory.

## Slide 3: 
- demonstrate Amelia Laundy's (former EDA grad) app 'interstalk'
  - this app makes use of the google maps + geocoding APIs, instagram API, and UClassify API
  - google takes an address, goes to that location on the map, and returns the first set of coordinates matching that address. 
  - instagram takes those coordinates, and returns the most recent pictures from around that area.
  - the pictures, and their author and coordinates are given to google maps API which places a pin on the map for each one.
  - finally all the tags from the instagram images are given to the UClassify API which returns a matching 'theme' for the given tags.

## Slide 4: 
- Explain how there are APIs which require authentication or authorization. Give a short list of ones that dont: wikipedia, github, itunes, weather data, uk police reports.

## Slides 5 - 6:
- ignore

## Slide 7:
- Open up github's API page. Show how we can get event data. Show the format of the event data. Talk about how we are going to build a simple app that scrapes the commits of any github user.
- we will be consuming the 'GET /users/:username/events' route soon
- speak briefly on api rate limits

## Slides 8 - 9: 
- Show how we are going to take the massive amount of information that comes with a 'GET /users/:username/events' request, and condense it down to just what we need. 

## Slide 10:
- Ruby model for parsing the raw data from HTTParty.

## Slides 11 - 15:
- code example walkthrough
  - Introduce HTTParty as a way to interact with APIs. Show rubydocs page, and github documentation. 
  - process data with ruby
    - first we get raw data from httparty
    - then we get only pushevents from the events
    - then we get only commits from the events
    - then we get only messages from the commits
    - then we extract words from the messages.
    - then we build a histogram, keeping track of the number of times words appear.
    - talk about api rate limiting, and how we need a method to let us know if we've reached the limit. 
  - display data with sinatra
    - Ruby controller, creates a parser that produces a histogram.
    - if we've reached the rate limit, create error message.
    - show view, and error message template. briefly explain css. 
- Demo the application! Visit http://commitments.herokuapp.com/euglazer. Try a couple other students' usernames. answer any questions students might have.

IGNORE THE REST OF THE SLIDES
