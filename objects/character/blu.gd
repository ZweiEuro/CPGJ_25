extends Sprite2D



enum Moods {calm, excited, angry};

var mood_calm: Texture = null;
var mood_excited: Texture = null;
var mood_angry: Texture = null;



var current_position = Globals.Position.spawn;

func _ready() -> void:
	mood_calm = Globals.load_file_from_path("res://objects/character/calm.svg", "svg")
	mood_excited = Globals.load_file_from_path("res://objects/character/excited.svg", "svg")
	mood_angry = Globals.load_file_from_path("res://objects/character/angry.svg", "svg")
	
	
	self.go_to_pos(Globals.get_random_room())
	
	
func choose_mood(mood: Moods):
	match mood:
		Moods.calm:
			self.texture = self.mood_calm;
		Moods.excited:
			self.texture = self.mood_excited;
		Moods.angry:
			self.texture = self.mood_angry;
			$CPUParticles2D.emitting = true;

enum Position { kitchen, living_room, bath, ladder ,bedroom, level2, level3, entry, garden, spawn}

func tween_end():
	var new_goal = Globals.get_random_room()
	while( new_goal == current_position):
		new_goal = Globals.get_random_room()
	self.go_to_pos(new_goal)
	
func go_to_pos(goal_pos: Globals.Position):
	
	var current_route: Array[Position];
	
	
	var current_pos_floor1 = false;
	var current_pos_floor2 = false;
	var current_pos_floor3 = false;
	
	if(Globals.level1.any(func(any_pos): return any_pos == current_position)):
		current_pos_floor1 = true;
		
	if(Globals.level2.any(func(any_pos): return any_pos == current_position)):
		current_pos_floor2 = true;
		
		
	if(Globals.level3.any(func(any_pos): return any_pos == current_position)):
		current_pos_floor3 = true;
		
		
	var goal_floor1 = false;
	var goal_floor2 = false;
	var goal_floor3 = false;
	
	if(Globals.level1.any(func(any_pos): return any_pos == goal_pos)):
		goal_floor1 = true;
	
	if(Globals.level2.any(func(any_pos): return any_pos == goal_pos)):
		goal_floor2 = true;
		
	if(Globals.level3.any(func(any_pos): return any_pos == goal_pos)):
		goal_floor3 = true;
	
	
	# 1
	if( current_pos_floor1 && goal_floor2):
		current_route.push_back(Globals.Position.level1)
		current_route.push_back(Globals.Position.level2)
	elif( current_pos_floor1 && goal_floor3):
		current_route.push_back(Globals.Position.level1)
		current_route.push_back(Globals.Position.level2)
		current_route.push_back(Globals.Position.level3)
	# 2
	elif( current_pos_floor2 && goal_floor1):
		current_route.push_back(Globals.Position.level2)
		current_route.push_back(Globals.Position.level1)
	elif( current_pos_floor2 && goal_floor3):
		current_route.push_back(Globals.Position.level2)
		current_route.push_back(Globals.Position.level3)
	# 3
	elif( current_pos_floor3 && goal_floor1):
		current_route.push_back(Globals.Position.level3)
		current_route.push_back(Globals.Position.level2)
		current_route.push_back(Globals.Position.level1)
	elif( current_pos_floor3 && goal_floor2):
		current_route.push_back(Globals.Position.level3)
		current_route.push_back(Globals.Position.level2)
		
	current_route.push_back(goal_pos)
	
	var tween = get_tree().create_tween()
	
	for pos in current_route:
		var point:Vector2 = $"../House".get_room_point(pos);
		tween.tween_property(self, "position", point, 1)
		
	tween.tween_callback(self.tween_end)
	
	self.current_position = current_route.back();
	
	
