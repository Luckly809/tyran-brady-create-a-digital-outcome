extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D2
var oldPos = Vector2(0,0)
var velocity = Vector2(1,-1)
var oldVelocity = Vector2(0,0)
var dmgMulti = 1
func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$AnimatedSprite2D.play("run")
	monitoring = true
	await get_tree().create_timer(0.5).timeout
	
	
func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("run")
	velocity += (get_local_mouse_position() * 0.75 * delta)
	if velocity.length() > 0.1 * get_local_mouse_position().length():
		velocity = velocity.normalized() * 15
	position += velocity 
	animated_sprite_2d.rotation = (position - oldPos).angle()
	oldPos = position
	oldVelocity = velocity
	
func _on_fireball_area_entered(area: Area2D) -> void:
	if area.is_in_group("Mobs"):
		area.health -= velocity.length() 
		area.damaged = true
		
