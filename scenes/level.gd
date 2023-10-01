extends Node2D

@onready var start = $start
@onready var player = $Player
@onready var exit = $exit
@onready var deathzone = $deathzone
@onready var coin = $coin
@onready var healthbar = $Player/healthbar2

@onready var score = 0
@export var health = 100

@export var next_level : PackedScene = null;

func _ready():
	player.global_position = start.get_spawn_pos();
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
	
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)	
	healthbar.set_size(Vector2(44*(health/100),4))

func _process(delta):
	if (Input.is_action_just_pressed("quit")):
		get_tree().quit()
		
	elif (Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	AudioPlayer.play_sfx("death")
	reset_player()
	
		
func _on_trap_touched_player():
	health -= 33.34
	AudioPlayer.play_sfx("hurt")
	print(health)
	healthbar.set_size(Vector2(44*health/100,4))
	if health <= 0:
		health += 100
		reset_player()
		
	


func reset_player():
	player.velocity = Vector2.ZERO
	healthbar.set_size(Vector2(44*health/100,4))
	player.global_position = start.get_spawn_pos();
	
	
func _on_exit_body_entered(body):
	if body is Player:
		if next_level != null:
			exit.animate();
			AudioPlayer.play_sfx("win")
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)


func _on_heart_touched_player(delta):
	print('heart touched')
	delta.is_visible_in_tree(false)
	
	
