extends Sprite2D


var good :Texture2D = Globals.load_file_from_path("res://ui_story/good_ending.png", "png")
var bad :Texture2D = Globals.load_file_from_path("res://ui_story/bad_ending.png", "png")


func _ready() -> void:#+
	
	var score = Globals.get_end_score();
	var mult = Globals.get_end_mult();
	
	if( score > 100):
		self.texture = good;
	else:
		self.texture = bad;
	
	$"../RichTextLabel".text = ""
	$"../RichTextLabel".push_color(Color(0,0,0))
	$"../RichTextLabel".add_text("Your Eco-Score: "+ str(int(score))+ " Max-Multiplier: "+ str(mult));
	
	
