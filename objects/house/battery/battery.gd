extends Sprite2D

var spriteSet: Array[Texture2D] = [];

var charge_percentage = 65;

func get_charge_bar_level() -> int:
	return lerp(0, 7, charge_percentage / 100.0);
	

func set_current_level_sprite():
	self.texture = self.spriteSet[get_charge_bar_level()];
	

func _ready():
	
		
	spriteSet.push_back(preload("res://objects/house/battery/bat-1.svg"))
	spriteSet.push_back(preload("res://objects/house/battery/bat-2.svg"))
	spriteSet.push_back(preload("res://objects/house/battery/bat-3.svg"))
	spriteSet.push_back(preload("res://objects/house/battery/bat-4.svg"))
	spriteSet.push_back(preload("res://objects/house/battery/bat-5.svg"))
	spriteSet.push_back(preload("res://objects/house/battery/bat-6.svg"))
	spriteSet.push_back(preload("res://objects/house/battery/bat-7.svg"))
	spriteSet.push_back(preload("res://objects/house/battery/bat-8.svg"))
	
	
		
		
	for applicance in $"../appliances".get_children():
		applicance.power_drained.connect(self.on_power_drained);
		
	for generator in $"../../generators".get_children():
		generator.power_gained.connect(self.on_power_gained);
		
	set_current_level_sprite();
	
	
var seconds_charge_at_max = 0.0;

func _process(delta: float) -> void:
	if(get_charge_bar_level() >= 6):
		if seconds_charge_at_max == 0:
			$battery_max_mult.play();
		
		seconds_charge_at_max += delta;
	else:
		seconds_charge_at_max = 0;

var mult_dict = {
	2: 2,
	10: 5,
	15: 7,
	20: 8,
	30: 10
}


func get_score_multiplier():
	
	var keys = mult_dict.keys()
	keys.reverse()
	
	for key in keys:
		if key <= seconds_charge_at_max:
			return mult_dict[key];
	
	return 1;
	
var previous_level = 0
func on_power_drained(change: int):	
	self.charge_percentage -= change;
	if(self.charge_percentage <= 0):
		self.charge_percentage = 0
		
		
		get_tree().change_scene_to_file("res://story_scenes/outro.tscn")
	
	
	# bar sounds
	var current_level = self.get_charge_bar_level()
	
	if(current_level < 3  && previous_level > current_level ):
		$power_drain.play();
	
	self.previous_level = current_level
	set_current_level_sprite();

	
func on_power_gained(change: int):
	self.charge_percentage += change;
	if(self.charge_percentage >= 100):
		self.charge_percentage = 100
	else: 
		pass
		#$power_gain.play()
	
	set_current_level_sprite();
