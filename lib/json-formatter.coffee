utils = require "./utils"

module.exports = class JsonFormatter
	constructor: (@options) ->
		@options.attributes ||= []
	
	output: (data) ->
		if @options.attributes.length > 0
			data = @selectAttributes(data)
		@options.output.write JSON.stringify(data, null, 4)
		@options.output.write "\n"
	
	selectAttributes: (data) ->
		trimmedData = {}
		for attribute in @options.attributes
			value = utils.getAttribute(data, attribute)
			if value?
				utils.insertAttribute(trimmedData, attribute, value)
		return trimmedData

