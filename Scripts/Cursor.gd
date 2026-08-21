extends Area2D
var heldEnemies = []
var charged = false
@onready var timer: Timer = $Timer
@onready var fireball: Area2D = $"../Fireball"
@onready var circle: Polygon2D = $Polygon2D
@onready var root: Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	process_mode = Node.PROCESS_MODE_ALWAYS
	monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
	
func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	for area in heldEnemies:
		if charged:
			area.modulate = Color(0.725, 0.431, 1.0, 1.0)

		else:
			area.modulate = Color(0.867, 0.482, 0.312, 1.0)
			circle.modulate = Color(0.774, 0.204, 0.189, 1.0)
	if charged:
		circle.modulate = Color(0.439, 0.0, 0.69, 1.0)
	else:
		circle.modulate = Color(0.774, 0.204, 0.189, 1.0)
func _input(event: InputEvent) -> void:
	
	print(heldEnemies)
	if event is InputEventMouseButton && charged && root.paused == false:
		for x in heldEnemies:
			if x.alive:
				x.health -= 10 * fireball.dmgMulti
				
		charged = false
		timer.wait_time = 1


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Mobs"):
		heldEnemies.push_front(area)
		


func _on_area_exited(area: Area2D) -> void:
	heldEnemies.erase(area)
	area.modulate = Color(1,1,1,1)


func _on_timer_timeout() -> void:
	charged = true
