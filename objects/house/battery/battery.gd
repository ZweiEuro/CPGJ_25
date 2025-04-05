extends Sprite2D

var spriteSet: Array[Texture2D] = [];

var charge_percentage = 100;


func set_current_level_sprite():
	var level = lerp(0, 7, charge_percentage / 100.0);
	self.texture = self.spriteSet[level];
	

func _ready():
	for i in range(1,9):
		spriteSet.push_back(Globals.load_file_from_path("res://objects/house/battery/bat-" + str(i) + ".svg", "svg"))
		
	for applicance in $"../appliances".get_children():
		applicance.power_drained.connect(self.on_power_drained);
		
	for generator in $"../../generators".get_children():
		generator.power_gained.connect(self.on_power_gained);
		
	set_current_level_sprite();
	
	
	
func on_power_drained():
	self.charge_percentage -= 10;
	if(self.charge_percentage <= 0):
		self.charge_percentage = 0
	else:
		$power_drain.play();
	set_current_level_sprite();
	
func on_power_gained():
	self.charge_percentage += 10;
	if(self.charge_percentage >= 100):
		self.charge_percentage = 100
	else: 
		$power_gain.play()
	
	set_current_level_sprite();
