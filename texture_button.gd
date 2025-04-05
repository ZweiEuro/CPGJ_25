extends TextureButton



# textures
@export_file("*.svg") var texture_on_path: String = "";
var texture_on: Texture = null;

@export_file("*.svg") var texture_off_path: String = "";
var texture_off: Texture = null;

# Audio 
var audio_player: AudioStreamPlayer2D = null;

@export_file("*.wav") var audio_windup_path: String = "";
var audio_windup_stream: AudioStreamWAV = null;

@export_file("*.wav") var audio_loop_path: String = "";
var audio_loop_stream: AudioStreamWAV = null;

@export_file("*.wav") var audio_winddown_path: String = "";
var audio_winddown_stream: AudioStreamWAV = null;


enum MachineState { start, loop, stop}
var machine_state: MachineState  = MachineState.stop;

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

func _ready():
	
	texture_on = load_file_from_path(texture_on_path, "svg", "res://placeholder/icon_on.svg")
	texture_off = load_file_from_path(texture_off_path, "svg", "res://placeholder/icon_off.svg")
	
	audio_player = AudioStreamPlayer2D.new();
	self.audio_player.finished.connect(self.on_audio_played)
	self.add_child(audio_player);
	
	print(audio_windup_path, audio_windup_path, audio_winddown_path)
	
	audio_windup_stream = load_file_from_path(audio_windup_path, "wav")
	audio_loop_stream = load_file_from_path(audio_loop_path, "wav")
	audio_winddown_stream = load_file_from_path(audio_winddown_path, "wav")
	
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
	
	self.audio_player.stop();
	if( self.machine_state == MachineState.stop):
		self.machine_state = MachineState.start
		self.audio_player.stream = audio_windup_stream;
	else:
		self.audio_player.stream = audio_winddown_stream;
		self.machine_state = MachineState.stop
	self.audio_player.play()
	select_texture()
	
