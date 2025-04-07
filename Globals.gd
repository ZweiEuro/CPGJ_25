extends Node

enum Position { kitchen, living_room, bath, level1 ,bedroom, level2, level3, entry, garden, spawn, console, lampl3}

var level1 = [Position.kitchen, Position.living_room, Position.garden, Position.spawn,  Position.entry,];
var level2 = [Position.bath,Position.bedroom];
var level3 = [Position.console, Position. lampl3];





func get_random_room() -> Position:
	
	var level = randi_range(0,2);
	
	match level:
		0:
			return level1[randi_range(0,len(level1)-2)]; # do not allow spawn
		1:
			return level2[randi_range(0,len(level2)-1)];
		2: 
			return level3[randi_range(0,len(level2)-1)];
		
	print("ERR no room!")
	return Position.spawn;


var score = 0;
var mult = 1;
func set_end_score(val: int, new_mult: int):
	score = val;
	
	if(new_mult > mult):
		mult = new_mult
	
func get_end_score():
	return score;

func get_end_mult():
	return mult;
	
