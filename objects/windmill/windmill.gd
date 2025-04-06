extends Node2D

@export var power_gain_per_action = 10;

func _ready() -> void:
	for blade in $blades.get_children():
		if blade.name == "blade":
			continue; 
		blade.button_down.connect(self._on_button_down)
		blade.button_up.connect(self._on_button_up)

var gained_rotation = 0
var pressed = false;

func _process(delta: float) -> void:
	if pressed:
		$blades.look_at(get_global_mouse_position())
	
	if($blades.rotation - gained_rotation > 2* TAU):
		gained_rotation += 2*TAU
		power_gained.emit(self.power_gain_per_action)

func _on_button_down():
	self.pressed = true;
	
func _on_button_up():
	self.pressed = false;

signal power_gained(change);
