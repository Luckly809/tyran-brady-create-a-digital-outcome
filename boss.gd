extends Area2D
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var health = 300
var damaged = false
var speed = 150.0
var alive = true
var timer = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.play("default")
	get_parent().get_parent().timer *= 0.2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health < 0 && alive:
		alive = false
		speed = 0.0
		get_parent().get_parent().score += 10
		get_parent().get_parent().upgradeProgress += 10
		#$Sprite2D.play("die")
		queue_free()
	if damaged && health > 0 && alive:
		damaged = false
		modulate = Color(1.0, 0.0, 0.0, 1.0)
		$CPUParticles2D.emitting = true
		await get_tree().create_timer(0.2).timeout
		$CPUParticles2D.emitting = false
		modulate = Color(0.5, 0.0, 0.0, 1.0)
		if alive == false:
			sprite.play("die")
			
			get_parent().get_parent().timer = GlobalVar.timer
			get_parent().get_parent().bossDead = true
	position += Vector2(1,0) * delta * speed


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass
