class_name EnvParser

func _init():
	pass

func parse(filename):
	var file = File.new()
	if(!file.file_exists(filename)):
		return {};

	file.open(filename, File.READ)

	var env = {};
	var line = "";

	while !file.eof_reached():
		line = file.get_line()
		var o = line.split("=")
		if(o.size() == 2): # only check valid lines
			env[o[0]] = o[1].lstrip("\"").rstrip("\"");
	return env
