extends Area2D
var health = 9.5
var damaged = false
var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if damaged:
		damaged = false
		$Sprite2D.play("damage")
		await get_tree().create_timer(0.2).timeout
		$Sprite2D.play("default")
	position += Vector2(1,0) * delta * speed
	if health < 0:
		$Sprite2D.play("die")
		await get_tree().create_timer(0.2).timeout
		get_parent().get_parent().score += 1
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
