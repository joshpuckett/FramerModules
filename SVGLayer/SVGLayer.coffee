class exports.create extends Layer

	constructor: (options = {}) ->
		options.strokeWidth
		options.width = options.width + options.strokeWidth
		options.height = options.height + options.strokeWidth
		options.path
		super options

		#HTML for the SVG DOM element, need unique class names
		d = new Date()
		t = d.getTime()
		cName = "c" + t
		header = "<svg class='#{cName}' x='0px' y='0px' width='#{options.width}' height='#{options.height}' viewBox='-#{options.strokeWidth/2} -#{options.strokeWidth/2} #{options.width + options.strokeWidth/2} #{options.height + options.strokeWidth/2}'>"
		path = options.path
		footer = "</svg>"

		#Hack to get pathLength before construction
		svgPath = new Layer
			html : header + path + footer
			width : options.width
			height : options.height
			backgroundColor: "transparent"
		domPath = document.querySelector('.'+cName+' path')
		pathLength = domPath.getTotalLength()
		svgPath.destroy()

		@html = header + path + footer
		@backgroundColor = "transparent"
		@width = options.width
		@height = options.height
		@perspective = 0
		@direction = "forward"
		@style = {"fill":"transparent";"stroke":"#32A2E6";"stroke-linecap":"round";"stroke-width":options.strokeWidth;"stroke-dasharray":pathLength;"stroke-dashoffset":0}
		@pathLength = pathLength

		#Animation Magic
		@states.add
			forward:
				perspective: 1
		@states.animationOptions = 
			curve:"ease-out"
			time: 1
		@.on "change:perspective", ->
			if @direction == "forward"
				dashOffset = Utils.modulate(@.perspective, [0, 1], [pathLength, 0])
				@.style['stroke-dashoffset'] = dashOffset
			else if @direction == "backward"
				dashOffset = Utils.modulate(@.perspective, [0, 1], [pathLength, pathLength*2])
				@.style['stroke-dashoffset'] = dashOffset

	animatePath: (options={}) =>
		options.direction ?= "forward"
		options.curve ?= "ease-out"
		options.time ?= 1
		@states.animationOptions = 
			curve: options.curve
			time: options.time
		@direction = options.direction
		@states.next()
