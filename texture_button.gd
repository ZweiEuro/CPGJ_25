extends TextureButton

# stats
@export var power_drain_per_second = 10;


# textures
@export_file("*.svg","*.png") var texture_on_path: String = "";
var texture_on: Texture = null;

@export_file("*.svg","*.png") var texture_off_path: String = "";
var texture_off: Texture = null;

# Audio 
var audio_player: AudioStreamPlayer2D = null;

@export_file("*.wav") var audio_windup_path: String = "";
var audio_windup_stream: AudioStreamWAV = null;

@export_file("*.wav") var audio_loop_path: String = "";
var audio_loop_stream: AudioStreamWAV = null;

@export_file("*.wav") var audio_winddown_path: String = "";
var audio_winddown_stream: AudioStreamWAV = null;

# on click audio sounds

var click_audio_player: AudioStreamPlayer2D = null;

var mouse_click_interaction_paths: Array[String] = ["res://general_sounds/ui_mouse_pressed_01.wav",
"res://general_sounds/ui_mouse_pressed_02.wav",
"res://general_sounds/ui_mouse_pressed_03.wav",
"res://general_sounds/ui_mouse_pressed_04.wav"]

var mouse_click_interaction_streams: Array[AudioStreamWAV] = [];

enum MachineState { start, loop, stop}
var machine_state: MachineState  = MachineState.stop;


func _ready():
	
	texture_on = load(texture_on_path)
	texture_off = load(texture_off_path)
	
	audio_player = AudioStreamPlayer2D.new();
	self.audio_player.finished.connect(self.on_audio_played)
	self.add_child(audio_player);
	
	click_audio_player = AudioStreamPlayer2D.new();
	self.click_audio_player.finished.connect(self.on_audio_played)
	self.add_child(click_audio_player);
	
	audio_windup_stream = load(audio_windup_path)
	audio_loop_stream = load(audio_loop_path)
	audio_winddown_stream = load(audio_winddown_path)
	
	mouse_click_interaction_streams.push_back(load(mouse_click_interaction_paths[0]))
	mouse_click_interaction_streams.push_back(load(mouse_click_interaction_paths[1]))
	mouse_click_interaction_streams.push_back(load(mouse_click_interaction_paths[2]))
	mouse_click_interaction_streams.push_back(load(mouse_click_interaction_paths[3]))
	
	

	
	select_texture()

func select_texture():
	if(machine_state == MachineState.stop):
		self.texture_normal = texture_off
	else:
		self.texture_normal = texture_on
		

# assigning already selected streams should not produce any overhead as they are 
# already loaded
func on_audio_played():
	if(self.machine_state == MachineState.start):
		self.audio_player.stream = audio_loop_stream;
		self.audio_player.play()
		
func _on_pressed() -> void:
	# clicking sound effect
	self.click_audio_player.stop();
	self.click_audio_player.stream = mouse_click_interaction_streams[randi_range(0, len(mouse_click_interaction_streams) - 1)];
	self.click_audio_player.play();
	
	
	# transition the statea machine

	if( self.machine_state != MachineState.stop):
		self.audio_player.stream = audio_winddown_stream;
		self.machine_state = MachineState.stop
		self.audio_player.play()
	select_texture()

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if( self.machine_state == MachineState.stop):
		self.audio_player.stop();
		self.machine_state = MachineState.start
		self.audio_player.stream = audio_windup_stream;
		self.audio_player.play()
		select_texture()

signal power_drained(change)

var time_turned_on = 0.0

var seconds_max_power = 0.0;

func _process(delta: float) -> void:
	if (self.machine_state != MachineState.stop):
		time_turned_on += delta;
		
	if( time_turned_on >= 1 ):
		time_turned_on -= 1.0;
		power_drained.emit(self.power_drain_per_second)
		

		
