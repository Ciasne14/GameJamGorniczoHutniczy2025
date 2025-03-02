extends CanvasLayer


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Intro.tscn")
