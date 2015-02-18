## Slide 1 - 2

- reintroduce the concept of MVC, division of labor, etc.

## Slide 3

- show example website. introduce what we're going to build. ask students to guess what is happening and how it works.
- explain briefly what is happening. a single div exists on the page -- and we just put a slightly larger div in that div, and then a slightly large div in the slightly larger div, and so on.

## Slide 4

- Show HTML, CSS, and filetree. Show that we are eventually going to import javascript from a model, a view, a controller, and a router.

## Slide 5

- explain in greater detail the roles that our router, controller, model, and view will take in this specific example. 
- expand on the general roles of each part:
	- the router contains a bunch of event listeners that route to various controller actions
	- the controller contains actions for each possible route. each action coordinates between the model and the view
	- the model is for ________
	- the view is for any sort of user i/o

## Slide 6

- Show how the router first creates a controller. The router, of course, needs something to route to. 
- Show how the router doesn't care how the controller does anything. It just tells the controller to do something.

## Slide 7

- Show how the controller first creates a model and a view. The controller, of course, needs things to control.
- Explain the variables and methods of the controller.
- In this.partyTime, emphasize how the controller doesn't really do anything. It mostly just tells the model and the view to do stuff for it. The controller is a coordinator. 

## Slide 8

- Introduce the model and the view. Explain their properties and methods. 
- Emphasize the division of labor between the model and view.

## Slide 9

- Show again the diagram explaining the high-level roles of the router/controller/model/view. Answer any questions students might have. Show website again. Answer any more questions.