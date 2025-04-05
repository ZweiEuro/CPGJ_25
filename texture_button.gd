extends TextureButton


var turned_on = false;

@export_file("*.svg") var texture_on_path: String = "";
var texture_on: Texture = null;

@export_file("*.svg") var texture_off_path: String = "";
var texture_off: Texture = null;

@export_file("*.wav") var audio_on_path: String = "";
var audio_player: AudioStreamPlayer2D = null;


func _ready():
	if(texture_on_path == ""):
		texture_on = preload("res://placeholder/icon_on.svg");
	else:
		var image = Image.load_from_file(texture_on_path)
		texture_on = ImageTexture.create_from_image(image)
	
	if(texture_off_path == ""):
		texture_off = preload("res://placeholder/icon_off.svg");
	else:
		var image = Image.load_from_file(texture_off_path)
		texture_off = ImageTexture.create_from_image(image)
	
	audio_player = AudioStreamPlayer2D.new();
	
	if(audio_on_path == ""):
		audio_player.stream = AudioStreamWAV.load_from_file("res://placeholder/testsound.wav"); 
	else:
		audio_player.stream = AudioStreamWAV.load_from_file("res://placeholder/testsound.wav"); 
		
	self.add_child(audio_player)
	
	
	texture_normal = texture_off
		
func select_texture():	
	if(turned_on):
		self.texture_normal = texture_on
	else:
		self.texture_normal = texture_off
		
func _on_pressed() -> void:
	print("turned: ", turned_on)
	
	if(turned_on):
		turned_on = false;
			
	#Play off stream
	# schedule looping stream
			
	audio_player.play();
	select_texture()

func start_entity():
	print("Starting entity")
	# play on stream
	
	audio_player.play()

	turned_on = true;
	select_texture()
	

	
	
