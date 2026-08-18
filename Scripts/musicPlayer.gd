extends AudioStreamPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
# Called when the node enters the scene tree for the first time.
func finished():
	play(0)


func _on_finished() -> void:
	play(0)
