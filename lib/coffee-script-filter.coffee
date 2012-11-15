vm = require "vm"
_ = require("underscore")
coffee = require("coffee-script")

module.exports = class CoffeeScriptFilter
	constructor: (@expression) ->

	match: (data) ->
		data = _.clone(data)
		test = coffee.compile("__result = (#{@expression})", bare: true)
		vm.runInNewContext(test, data)
		data.__result

