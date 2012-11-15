module.exports =
	repeatString: (string, length) ->
		new Array(length + 1).join(string)

	getAttribute: (object, path) ->
		path_parts = path.split(".")
		attribute = path_parts[0]
		remaining_path = path_parts.slice(1).join(".")
		if object[attribute]?
			if typeof object[attribute] == "object"
				if remaining_path == ""
					return object[attribute]
				else
					return @getAttribute(object[attribute], remaining_path)
			else
				return object[attribute]
		else
			return
