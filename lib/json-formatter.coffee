module.exports = class JsonFormatter
	constructor: (@options) ->
	
	output: (data) ->
		@options.output.write JSON.stringify(data, null, 4)
		@options.output.write "\n"


