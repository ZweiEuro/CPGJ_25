extends Node

enum Position { kitchen, living_room, bath, level1 ,bedroom, level2, level3, entry, garden, spawn, console, lampl3}

var level1 = [Position.kitchen, Position.living_room, Position.garden, Position.entry, Position.spawn];
var level2 = [Position.bath,Position.bedroom];
var level3 = [Position.console, Position. lampl3];


func load_file_from_path(filePath:  String, ext: String, alternative_file = ""):
	var ret = null
	
	if(filePath == ""):
		if(alternative_file != ""):
			ret = load_file_from_path(alternative_file, "svg");
	else:
		if(ext == "wav"):
			ret = AudioStreamWAV.load_from_file(filePath);
		if(ext == "svg"):
			var image = Image.load_from_file(filePath)
			ret = ImageTexture.create_from_image(image)
	
	return ret;


func get_random_room() -> Position:
	
	var level = randi_range(0,2);
	
	match level:
		0:
			return level1[randi_range(0,len(level1)-1)];
		1:
			return level2[randi_range(0,len(level2)-1)];
		2: 
			return level3[randi_range(0,len(level2)-1)];
		
	print("ERR no room!")
	return Position.spawn;
