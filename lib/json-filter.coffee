module.exports = class JsonFilter
	constructor: (@options) ->
		@data = ""
		@options.input.on "data", (chunk) =>
			@data = @data + chunk
			@consumeFullLines()
		@options.input.on "end", (chunk) =>
			@data = @data + chunk
			@consumeFullLines(true)
	
	consumeFullLines: (end_of_file) ->
		lines = @data.split("\n")
		unless end_of_file
			last_line = lines.pop()
			@data = last_line
		for line in lines
			@filterLine(line)
	
	filterLine: (line) ->
		# Ignore non-json lines
		try
			data = JSON.parse(line)
		catch e
			return
		for filter in @options.filters
			return unless filter.match(data)
		@options.formatter.output data
