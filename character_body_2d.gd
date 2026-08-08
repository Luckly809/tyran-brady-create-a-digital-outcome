extends Area2D
var health = 100

func _ready() -> void:
	monitoring = true


func _proccess(_delta:float) -> void:
	print(health)
	if health < 1:

		queue_free()
		


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Mobs"):
		get_tree().change_scene_to_file("res://Dead.tscn")
