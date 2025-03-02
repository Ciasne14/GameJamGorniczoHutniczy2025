extends CanvasLayer

var is_paused = false
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	$".".visible = is_paused
	get_tree().paused = is_paused


func _on_menu_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_powrót_pressed() -> void:
	toggle_pause()
