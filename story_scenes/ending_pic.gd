extends Sprite2D


var good :Texture2D = Globals.load_file_from_path("res://ui_story/good_ending.png", "png")
var bad :Texture2D = Globals.load_file_from_path("res://ui_story/bad_ending.png", "png")


func _ready() -> void:#+
	
	var score = Globals.get_end_score();
	
	if( score > 100):
		self.texture = good;
	else:
		self.texture = bad;
	
