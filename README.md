##### FramerModules
Modules that extend Framer.js
* * *

### SVG Layer
A module and corresponding Sketch plugin that make it trivial to work with SVG Paths in Framer. 

![Numbers animating](https://dl.dropboxusercontent.com/u/1603978/svg_numbers1.gif)

Install the Sketch Plugin; select any path layer and run it. This automatically copies code to your clipboard.

In Framer Studio, after installing the module and importing it, create SVGLayers like so

    layer = new SVGLayer.create

Then paste in what the Sketch plugin copied, which will look something like this:

    layer = new SVGLayer.create
      strokeWidth: 4
      width: 502.6700134277344
      height: 204.3515625057028
      path: '<path d="M0,204.351562 C0,204.351562 383.764204,204.390625 502.670013,0"></path>'

###### Animation
Use **layer.animatePath()** to animate a path from start to end.

![line animating](https://dl.dropboxusercontent.com/u/1603978/svgAnimate.gif)

Alternatively, you can pass in properties to specify the direction and animation curve/time

    layer.animatePath
      curve: "ease-out"
      time: 0.33
      direction: "backward"


###### Utils
Use **layer.pathLength** to get the length of the SVG path


###### The bad parts
First the bad parts: animating SVGs is still a little less than ideal; it’s essentially a hack. This method, while clever, relies on changing the perspective property of the layer. While this is very rarely used, there might be some cases where modifying that property on an SVG layer breaks the out of box behavior of this module. It also uses layer states to drive the animation.

###### Tutorial
Head over to Medium to read [Working with SVG Paths in Framer](https://medium.com/@joshpuckett/working-with-svg-paths-in-framer-43d3c2d08adc "Working with SVG Paths in Framer").
