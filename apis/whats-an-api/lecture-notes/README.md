## Slides 1 - 2:
- Explain what an API is briefly and explain what it stands for.

## Slide 3:
- An application is a machine. It does stuff. Complex stuff. Take for example a microwave. It has a whole mess of mechanical + electrical parts. Somehow, they work together to emit microwaves of a particular frequency that rotates water molecules inside of your food. The rotation of your foods water molecules heats it up, and heats it up quite quickly. It's a nice machine, and although we might not be able to build it immediately -- design/assemble the circuitry and software and so on -- we can use it! It has an interface, and a clear set of instructions: 1. input food, 2. input a time, 3. press start, 4. wait for beep, 5. eat heated food. The interface uses a language that we can understand -- English. The buttons have numbers and words that we recognize and understand.

## Slide 4:
- Applications are the same! The insides are quite complex, and possibly written in a language we don't know quite yet. But applications have interfaces. These interfaces have a set of routes (buttons) that we are allowed to access. Each route has a clear set of instructions. Additionally, these interfaces communicate with a common language. This language is Javascript, specifically JSON. JavaScript Object Notation. It doesn't matter what language your app is written in, and what language my app is written in, and it doesn't matter what the guts of our applications look like. As long as we're communicating to eachother with the same language, JSON, and as long as there are a clear set of agreements on how we communicate with eachother, everything is fine. This is satisfyingly convenient.

## Slide 5:
- What does JSON look like? It looks like this. It's a javascript object, it's a hash. It has key value pairs, and that's it. 
- This is a JSON representation of a twitter user. It contains all public information on the user. Their name, the color scheme on their profile page, their join date, their user id, the number of friends they have, etc.
- Show twitter's api, their routes, and agreements for each route.

## Slide 6: 
- Let's build two applications. Let's build apis for both of them, and get them talking to eachother.
- Show both apps, and show how they interact with eachother

## Slide 7:
- Talk briefly on the terms and conditions of the two apis. Talk inputs and outputs.

## Slide 8:
- Show the contracts in greater detail. Specifically show the JSON response from the get request.

## Slide 9: 
- Introduce postman, and use it to test some of the routes

## Slide 10:
- Show a glimpse of the ruby cat server. show the routes and the model. Show how our get request sends json.

## Slide 11: 
- Show a glimpse of the c# dog server. show routes and the model. show json response from get request.

## Slide 12: 
- Show a glimpse of the ruby cat client controller. Talk about httparty. 

## Slide 13: 
- Show a glimpse of the c# dog client controller. Talk about ___________.

## Slide 14:
- Show a glimpse of the ruby cat server view. Show the dogs, and how we access their properties as if they were a hash.

## Slide 15: 
- Show a glimpse of the c# dog client view. Talk about ___________.

## Last Slide: 
- Show the site once more, answer any questions. Invite students to use the site, and to contribute to it.  
