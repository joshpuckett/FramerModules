"""
SVGLayer class

properties
- linecap <string> ("round" || "square" || "butt")
- fill <string> (css color)
- stroke <string> (css color)
- strokeWidth <number>
- dashOffset <number> (from -1 to 1, defaults to 0)
"""

class exports.SVGLayer extends Layer

	constructor: (options = {}) ->
		options = _.defaults options,
			dashOffset: 1
			strokeWidth: 2
			stroke: "#28affa"
			backgroundColor: null
			clip: false
			fill: "transparent"
			linecap: "round"
		super options

		if options.fill == null
			@fill = null

		@width += options.strokeWidth / 2
		@height += options.strokeWidth / 2

		# HTML for the SVG DOM element, need unique class names
		d = new Date()
		t = d.getTime()
		cName = "c" + t
		header = "<svg class='#{cName}' x='0px' y='0px' width='#{@width}' height='#{@height}' viewBox='-#{@strokeWidth/2} -#{@strokeWidth/2} #{@width + @strokeWidth/2} #{@height + @strokeWidth/2}'>"
		path = options.path
		footer = "</svg>"
		@html = header + path + footer

		# wait with querying pathlength for when dom is finished
		Utils.domComplete =>
			domPath = document.querySelector('.'+cName+' path')
			@_pathLength = domPath.getTotalLength()
			@style = {"stroke-dasharray":@pathLength;}
			@dashOffset = options.dashOffset

	@define "pathLength",
		get: -> @_pathLength
		set: (value) -> print "SVGLayer.pathLength is readonly"

	@define "linecap",
		get: -> @style.strokeLinecap
		set: (value) ->
			@style.strokeLinecap = value

	@define "strokeLinecap",
		get: -> @style.strokeLinecap
		set: (value) ->
			@style.strokeLinecap = value

	@define "fill",
		get: -> @style.fill
		set: (value) ->
			if value == null
				value = "transparent"
			@style.fill = value

	@define "stroke",
		get: -> @style.stroke
		set: (value) -> @style.stroke = value

	@define "strokeColor",
		get: -> @style.stroke
		set: (value) -> @style.stroke = value

	@define "strokeWidth",
		get: -> Number(@style.strokeWidth.replace(/[^\d.-]/g, ''))
		set: (value) ->
			@style.strokeWidth = value

	@define "dashOffset",
		get: -> @_dashOffset
		set: (value) ->
			@_dashOffset = value
			if @pathLength?
				dashOffset = Utils.modulate(value, [0, 1], [@pathLength, 0])
				@style.strokeDashoffset = dashOffset
