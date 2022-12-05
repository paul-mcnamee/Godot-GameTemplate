extends Node

# Instance of resource async loader
var loader: = ResourceAsyncLoader.new()

# Starting amount of AudioStreamPlayers
export (int) var start_player_count = 3

# Name of the bus sample players will be aassigned to, if wrong defaults to Main
export (String) var bus_name:String = 'Main'

# If added in scene, can preload from Inspector
export (Array, AudioStream) var sample_collection

# Holds loaded samples
var sample_dictionary: = {}

# Choose time when same sample can be triggered again
export (float) var retrigger_time:float = 1.0/60.0*2
onready var players: = get_children()

# List of AudioStreamPlayer not playing sounds
onready var free_players: = players

# List of AudioStreamPlayer playing samples
var active_players: = {}


func add_players(value:int)->void:
	for i in value:
		var player: = AudioStreamPlayer.new()
		# Must have an existing audio bus name
		player.bus = bus_name
		players.append(player)
		add_child(player)

# Let the manager handle loading sample - async if possible
func load_samples(list:Array)->void:
	var samples:Array
	if loader.can_async:
		samples = yield(loader.load_start( list ), "completed")
	else:
		samples = loader.load_start( list )
	for sample in samples:
		var key:String = sample.get_path().get_file().get_basename()
		if !sample_dictionary.has(key):
			sample_collection.append(sample)
			sample_dictionary[key] = sample_collection.size() -1
		else:
			print("SFXmanager already has: ", key)

# You handle loading and just add already loaded sample
func add_samples(list:Array)->void:
	for sample in list:
		var key:String = sample.get_path().get_file().get_basename()
		sample_collection.append(sample)
		sample_dictionary[key] = sample_collection.size() -1

# Clear up memory if there are unnecessary samples loaded
func remove_samples(list:Array)->void:
	var array_positions: = []
	for key in list:
		array_positions.append(sample_dictionary[key])
		sample_dictionary.erase(key)
	array_positions.sort().invert()
	for i in array_positions:
		sample_collection.remove(i)

func _ready():
	# Add to database all samples preloaded in the Inspector
	for i in sample_collection.size():
		# Reference sample
		var sample:AudioStreamSample = sample_collection[i]
		# Create entry with file name to reference index in array
		sample_dictionary[sample.get_path().get_file().get_basename()] = i

	# Add some players to start with
	add_players(start_player_count)
	var files = get_files("res://Assets/Sounds","wav")
	SfxManager.load_samples(files)


func play(sample_name:String)->void:
	# Same sample is already playing
	if active_players.has(sample_name):
		var player:AudioStreamPlayer = active_players[sample_name]
		# Checks if same sample has played at least certain length
		if player.get_playback_position() > retrigger_time:
			player.play()
	else:
		# There are inactive players
		if !free_players.empty():
			var player:AudioStreamPlayer = free_players.pop_back()
			active_players[sample_name] = player
			player.stream = sample_collection[ sample_dictionary[sample_name] ]
			player.play()
			player.connect("finished", self, "sample_finished", [sample_name])
		else:
			print("not enough audio players - creating new")

			# Create new player
			var player: = AudioStreamPlayer.new()

			# Must have an existing audio bus name
			player.bus = bus_name
			add_child(player)
			active_players[sample_name] = player
			player.stream = sample_collection[ sample_dictionary[sample_name] ]
			player.play()
			player.connect("finished", self, "sample_finished", [sample_name])

# Triggered when player is finished sample and not retriggered while playing.
func sample_finished(sample_name:String)->void:
	var player:AudioStreamPlayer = active_players[sample_name]
	player.disconnect("finished", self, "sample_finished")
	active_players.erase(sample_name)
	free_players.append(player)


func get_files(path,extension):
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	var files = []
	while file_name != "":
		if file_name.get_extension() == extension:
			files.append(path.plus_file(file_name))
		file_name = dir.get_next()
	return files
