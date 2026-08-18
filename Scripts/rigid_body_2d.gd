extends Area2D
var health = 9.5
var damaged = false
var speed = 150
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if damaged && health > 0 && alive:
		damaged = false
		$Sprite2D.play("damage")
		$CPUParticles2D.emitting = true
		await get_tree().create_timer(0.2).timeout
		$CPUParticles2D.emitting = false
		$Sprite2D.play("default")
	position += Vector2(1,0) * delta * speed
	if health < 0 && alive:
		alive = false
		speed = 0
		$Sprite2D.play("die")
		await get_tree().create_timer(2).timeout
		get_parent().get_parent().score += 1
		get_parent().get_parent().upgradeProgress += 1
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
