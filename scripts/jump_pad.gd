extends Area2D

@onready var jump_pad = $"jump pad"
@export var jump_force = 300

func _on_body_entered(body):
	if body is Player:
		jump_pad.play("jump");
		body.jump(jump_force)
	
