extends Sprite2D

enum Position { kitchen, living_room, bath, ladder ,bedroom, level2, level3, entry, garden, spawn}


func get_room_point(pos: Globals.Position):
	match pos:
		Globals.Position.kitchen:
			return $points/kitchen.global_position;
		Globals.Position.living_room:
			return $points/living_room.global_position;
		Globals.Position.bath:
			return $points/bath.global_position;
		Globals.Position.level1:
			return $points/level1.global_position;
		Globals.Position.bedroom:
			return $points/bedroom.global_position;
		Globals.Position.level2:
			return $points/level2.global_position;
		Globals.Position.level3:
			return $points/level3.global_position;
		Globals.Position.entry:
			return $points/entry.global_position;
		Globals.Position.garden:
			return $points/garden.global_position;
		Globals.Position.spawn:
			return $points/spawn.global_position;
		Globals.Position.console:
			return $points/console.global_position;
		Globals.Position.lampl3:
			return $points/lampl3.global_position;
		_: 
			print("WARN: no pos ",pos)
