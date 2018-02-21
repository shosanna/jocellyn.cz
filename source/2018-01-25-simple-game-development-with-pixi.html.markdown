---
title: The simplest game development with Pixi.js
date: 2018-01-25 20:50 UTC
tags: game development, programming, javascript
layout: post
---

In one of my recent job interviews I have been asked to do a simple web based game, where you would navigate a car between three lines. There could be obstacles in those lines and if you would not switch line and hit such a obstacle, you would lose a life. That was the whole assignment, I also got a spritesheet with all the needed textures (but they were not aligned in a grid, but just placed in one image randomly).

There were many interesting aspects of this assignment, which I had to deal with (as someone with little JavaScript experience), for example:

- how to deal with the spritesheet not being aligned - basically how to use the individual images in a sensible way
- how to build everything together, what build tool to use and how to configure it
- what framework for game development to use
- how to program the actual game
- how to publish my result easily and fast

In this article, I want to discuss only the parts about choosing framework and programming the game, although if you are interested, I provided also short answers to all those question in the end.

## What framework to choose?
I have some experience with Unity (check out my current game - [Little Planets](https://github.com/shosanna/LittlePlanets)) and I have even smaller experience with Phaser ([https://phaser.io/](https://phaser.io/)), however I did not pick either one of those. Unity is mainly for desktop games, there is a possibility to develop also web based games, but I did not know how and it seemed like a over-kill for such a small game. Unity is really great and powerful but it is meant for bigger projects.

Phaser on the other hand felt too easy, and since it was an interview task, I wanted to impress a little bit. It felt almost like not programming at all, but just gluing together some higher level pieces of code and I overall do not like their image. It is so colorful and so cartoon-ish that it just doesn't feel professional.

I picked Pixi.js ([http://pixijs.io/](http://pixijs.io/)), as it is not a whole game development framework like those two mentioned, but rather just a rendering engine. It doesn't even have to be used for games, but also for presentations and all kind of visualizations. I also wanted to learn something new. 

## How to program a game with Pixi.js
Pixi helped me with 3 main things:

- loading and displaying of assets
- interactivity
- game loop

The rest of the code was just plain JavaScript, but those are the essential parts of any game.

## Loading and displaying
So, I started to write my game with declaring all of my assets, turning them into sprites and displaying them in the world. The first thing needed was to initialize the game window like this:

```javascript
let worldWidth = 512;
let worldHeight = 512;

let app = new PIXI.Application({
    width: worldWidth,
    height: worldHeight,
    transparent: true
});

// attach the created app to the HTML document - create the canvas element
document.body.appendChild(app.view);
```

After having the blank game window (the canvas element, because that's how you draw in HTML5, you use canvas), I loaded my atlas of textures. Pixi has a handy way how to run something only after the asset is loaded - via the callback (in this case it is the `setup` function). The flow is thus as follow, you load all your needed asset, in the callback, which is run after it is loaded, you turn them into sprites and do all you setup.

```javascript
PIXI.loader
  .add("images/tileset.json")
  .load(setup);
```

Now I just needed to prepare all the sprites, set their size, their position and other attributes - this was just simple JavaScript. For example, this is how the main car was setup:

```javascript
let car;

function setup() {
    car = new PIXI.Sprite(tileset["red_car.png"]);
    car.anchor.set(0.5, 0.5);
    // lane is my own property
    car.lane = 0;
    car.y = app.renderer.height - car.height / 2;
}
```

And we must not forgot to add those prepared sprites to the canvas - to our game view. We can do it as well in the setup function.

```javascript
// in the setup function
app.stage.addChild(car);
```

I did a couple more steps to display the background and initialize the enemies, but in the same manner as was described here with the car. To summarize, you
- load the asset into the loader, provide a callback function
- in the callback function do all the remaining setup
    - create sprite from the asset
    - save it to a variable to have it accessible from elsewhere
    - set up some properties for it like for example its position
    - add it to the game - the app stage

## Interactivity
Now you have the basic but static world - you have some images on the canvas. It is time to make them react when you click (or do something else). First thing is to allow this interactivity and that is done like this:

```javascript
app.renderer.interactive = true;
```

You can set `interactive` also on sprites, in this case I am allowing it on the whole canvas. 
Then you just register a callback - what should happen when some action is triggered - in my case it is to run function `moveCar` when the canvas is touched or clicked.

```javascript
app.renderer.plugins.interaction.on('pointerdown', function(click){ moveCar(click)});

function moveCar(click) {
    let isMoveLeft = click.data.global.x <= app.renderer.width / 2;

    if (isMoveLeft) {
        car.lane = Math.max(-1, car.lane - 1);
    } else {
        car.lane = Math.min(1, car.lane + 1);
    }
}
```

## Game loop
The last piece is to make the game running - to have a cycle of frames to allow animations and any kind of movement, or progression. Pixi has a helper `ticker` which can do just that - it will run 60x per second. You just again must register the callback:

```javascript
let score = 0;
const CAR_START_X = app.renderer.width / 2;
const LANE_WIDTH = 50;
let enemySpeed = 50;

app.ticker.add(dt => gameLoop(dt));

function gameLoop(deltaTime) {
    // Move the car based on its lane
    car.x = CAR_START_X + LANE_WIDTH * car.lane;

    // assume enemy is the sprite created the same way  as car
    // deltaTime is time for the frame
    enemy.y += enemySpeed * deltaTime;   
    enemy.x = CAR_START_X + LANE_WIDTH * enemy.lane;
}
```

This is a bit simplified but it is all there is. The `gameLoop` function runs 60x per second and each time, the positions of car and enemy is recalculated and updated - they are moving in the screen. They are moving based on their attribute `lane` which we assigned via the interactivity - when we tapped the screen, we changed the lane of the car. The enemy is also gaining more and more speed which makes the games more difficult in progress.

## The result
It is a very simple game and here you have just parts of it, but still the important ones. You can check out the result [here](https://shosanna.github.io/gamee/) and you can of course read the whole source code [here](https://github.com/shosanna/gamee/blob/master/src/index.js). I hope you liked it :)

## P.S. Here are the promised answers ..


- **how to deal with the spritesheet not being aligned - basically how to get out the individual images in a sensible way**
    - I basically did it in a very clumsy way. I decomposed the spritesheet via the [http://renderhjs.net/shoebox/](http://renderhjs.net/shoebox/)
    - I got an individual images, which I loaded into another tool - [https://www.codeandweb.com/texturepacker](https://www.codeandweb.com/texturepacker)
    - I picked this tool because in can generate json file for Pixi with the information about where is concrete image located in the spritesheet
    - with the png and the json describing that, I could have use Pixi way how to work with atlases - I used [this tutorial](https://github.com/kittykatattack/learningPixi#using-a-texture-atlas). 
- **how to build everything together, what build tool to use and how to configure it**
    - first of all - why do I need any build tool? It can definitely be done without, but I wanted to use some ES6 features and also I wanted to be able to easily add dependencies - for example Pixi.js is a package available through npm, so it was very easy to include that.
    - I chose [https://webpack.js.org/](https://webpack.js.org/) as it seemed the easiest. I followed the simplest example of config. I did not include any loader for images, I just copied my images as well as CSS file into the dist folder (to keep it simple). Dist folder is simple the folder with the end result, the one which you would then grab and publish somewhere.
    - I created a simple HTML file in the dist folder, which would link the JavaScript file, which is outputted by Webpack.
    - in the dist folder, I have:
        - folder of images
        - CSS file (created)
        - HTML file (created, which links the CSS and the JS files)
        - JS file - build by Webpack from the source file
    - In the config, I am just declaring what is my source (`src/index.js`) and to which file to build the result (`bundle.js`):

        ```javascript
        const path = require('path');

        module.exports = {
            entry: './src/index.js',
            devServer: {
                contentBase: './dist'
            },
            output: {
                filename: 'bundle.js',
                path: path.resolve(__dirname, 'dist')
            }
        };
        ```

    - and thats it - now I could have just run `npx webpack` from the console to run the process and transform my dependencies and source file into the result.
- **how to publish my result easily and fast**
    - I used [https://pages.github.com/](https://pages.github.com/) and it was done in a few minutes!
