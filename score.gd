extends RichTextLabel

var score = 0;


var spawned_blues = 0;

func _process(delta: float) -> void:
	var mult = $"../House/battery".get_score_multiplier();
	score += delta * mult;
	
	self.text = ""
	self.push_color(Color(0,0,0))
	self.add_text("score: "+ str(int(score)) + "\n" + "mult: x" + str(mult));
	

	if(int(score)/50 > spawned_blues || spawned_blues == 0):
		spawned_blues+=1;
		var scene = load("res://objects/character/blu.tscn")
		var player = scene.instantiate()
		player.position = $"../House".get_room_point(Globals.Position.spawn)
		player.scale = Vector2(0.2, 0.2);
		$"../".add_child(player)
	
