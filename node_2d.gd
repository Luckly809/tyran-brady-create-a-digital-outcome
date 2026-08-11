extends Node2D

@export var mob_scene : PackedScene
var timer = 1.0
var toughness = 1.0
var score = 0
var score2 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if score != score2:
		print(score)
		score2 = score
	$Label.text = "Score : " + str(score)

func _on_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position 
	mob.health *= toughness
	if timer != 0:
		$Timer.wait_time = timer
		timer = timer * 0.999
		toughness *= 1.01
	add_child(mob)
