##### FramerModules
Modules that extend Framer.js
* * *

### SVG Layer
A module and corresponding Sketch plugin that make it trivial to work with SVG Paths in Framer. 

![Numbers animating](https://dl.dropboxusercontent.com/u/1603978/svg_numbers1.gif)

Install the Sketch Plugin; select any path layer and run it. This automatically copies code to your clipboard.

In Framer Studio, after installing the module and importing it, create SVGLayers like so

```coffee
{SVGLayer} = require "SVGLayer"

layer = new SVGLayer
```

Then paste in what the Sketch plugin copied, which will look something like this:

```coffee
layer = new SVGLayer.create
  strokeWidth: 4
  width: 502.6700134277344
  height: 204.3515625057028
  path: '<path d="M0,204.351562 C0,204.351562 383.764204,204.390625 502.670013,0"></path>'
```

###### Animation
Use dashOffset to animate a path from start to end.

![line animating](https://dl.dropboxusercontent.com/u/1603978/svgAnimate.gif)

```coffee
layer = new SVGLayer
  dashOffset: 0

layer.animate
  properties:
    dashOffset: 1
```

[View example using states](http://share.framerjs.com/tyizdr085xj8/)

###### Properties

- **`linecap`** *\<string>* (options: "round", "square", "butt")
- **`fill`** *\<string>* (css color)
- **`stroke`** *\<string>* (css color)
- **`strokeWidth`** *\<string>*
- **`dashOffset`** *\<string>* (from -1 to 1, defaults to 0)

###### Utils
Use **layer.pathLength** to get the length of the SVG path

###### Tutorial
Head over to Medium to read [Working with SVG Paths in Framer](https://medium.com/@joshpuckett/working-with-svg-paths-in-framer-43d3c2d08adc "Working with SVG Paths in Framer").
