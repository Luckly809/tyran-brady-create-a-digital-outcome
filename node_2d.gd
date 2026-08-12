extends Node2D

@export var mob_scene : PackedScene
@onready var fireball = $Fireball
@onready var enemySD: Button = $"Node2D/Teal/Enemy Speed Down"
@onready var enemyHD: Button = $"Node2D/Green/Enemy Health Down"
@onready var dmgUp: Button = $"Node2D/Red/Dmg Up"
@onready var teal: Sprite2D = $Node2D/Teal
@onready var green: Sprite2D = $Node2D/Green
@onready var red: Sprite2D = $Node2D/Red



var timer = 1.0
var toughness = 1.0
var speed = 1
var score = 0
var score2 = 0
var upgradeProgress = 0
var upgrade = false



# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if score != score2:
		score2 = score
	$Label.text = "Score : " + str(score)
	if upgradeProgress == 30:
		upgrade = true
	if Input.is_action_just_pressed("pause"):
		pause()
	
	if upgrade:
		shop()
		upgraded()



func _on_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position 
	mob.health *= toughness
	mob.speed *= speed
	if timer != 0:
		$Timer.wait_time = timer
		timer = timer * 0.999
		toughness *= 1.01
	$MobHolder.add_child(mob)


func pause():
	get_tree().paused = true
	$DaPause.show()
	await get_tree().create_timer(0.2).timeout
	while get_tree().paused:
		await get_tree().create_timer(0.1).timeout
		if Input.is_action_pressed("pause"):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			$DaPause.hide()
			get_tree().paused = false


func upgraded():
	upgrade = false
	upgradeProgress = 0


func shop():
	get_tree().paused = true
	red.show()
	green.show()
	teal.show()
	dmgUp.disabled = false
	enemyHD.disabled = false
	enemySD.disabled = false
	await get_tree().create_timer(0.2).timeout
	
func unshop():
	get_tree().paused = false
	
	red.hide()
	green.hide()
	teal.hide()
	dmgUp.disabled = true
	enemyHD.disabled = true
	enemySD.disabled = true

func dmg_up() -> void:
	unshop()
	fireball.dmgMulti *= 1.2
	print(fireball.dmgMulti)

func enemy_health_down() -> void:
	unshop()
	toughness *= 0.85
	print(toughness)


func enemy_speed_down() -> void:
	unshop()
	speed *= 0.9
	print(speed)
