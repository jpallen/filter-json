utils = require "./utils"

module.exports = class TableFormatter
	constructor: (@options = {}) ->
		@options.cellHorizontalPadding ||= 1
		@options.columns ||= []
		@options.widths ||= []
		while @options.widths.length < @options.columns.length
			@options.widths.push 30

		@drawRule()
		for attribute, i in @options.columns
			@drawCell attribute, @options.widths[i]
		@drawEndOfRow()
		@drawRule()

	drawRule: () ->
		totalWidth = 0
		for width in @options.widths
			totalWidth = totalWidth + width + @options.cellHorizontalPadding * 2
		totalWidth = totalWidth + @options.columns.length + 1
		@options.output.write utils.repeatString("-", totalWidth) + "\n"

	drawCell: (data, width) ->
		@options.output.write "|"
		@options.output.write utils.repeatString(" ", @options.cellHorizontalPadding)
		@options.output.write @fitToWidth(data, width)
		@options.output.write utils.repeatString(" ", @options.cellHorizontalPadding)

	fitToWidth: (string, width) ->
		string = string + ''
		if string.length < width
			return string + utils.repeatString(" ", width - string.length)
		else
			return string.slice(0, width - 3) + "..."

	drawEndOfRow: () ->
		@options.output.write("|\n")

	output: (data) ->
		for attribute, i in @options.columns
			value = utils.getAttribute(data, attribute)
			if !value?
				value = ""
			@drawCell(value, @options.widths[i])
		@drawEndOfRow()
	

