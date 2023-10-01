extends Node

var jump = preload("res://assets/audio/jump.wav");
var jump2 = preload("res://assets/audio/jump2.wav");
var damage = preload("res://assets/audio/damage.wav");
var death = preload("res://assets/audio/death.wav")
var death2 = preload("res://assets/audio/death2.wav")
var finish = preload("res://assets/audio/finish.wav");
var hurt = preload("res://assets/audio/hurt.wav")
var win = preload("res://assets/audio/win.wav")

func play_sfx(sfx_name : String):
	var stream  = null
	if sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "damage":
		stream = damage
	elif sfx_name == "jump":
		stream = jump
	elif sfx_name == "death":
		stream = death
	elif sfx_name == "win":
		stream = win
	elif sfx_name == "jump2":
		stream = jump2
	elif sfx_name == "finish":
		stream = finish
	else:
		print("INVALID SFX NAME")
		
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	
	asp.play()
	
	await asp.finished
	asp.queue_free()
	
