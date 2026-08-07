extends Area2D
var health = 100

func _ready() -> void:
	monitoring = true


func _proccess(_delta:float) -> void:
	print(health)
	if health < 1:

		queue_free()
		


func _on_fireball_area_entered(area: Area2D) -> void:
	print("owie, owie")
	print(area.get_groups())
	if area.is_in_group("Mobs"):
		area.queue_free()
