extends StaticBody2D
@export var Enemy : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var b = Enemy.instantiate()
		add_child(b)
		b.position += Vector2(20,1)
	pass
