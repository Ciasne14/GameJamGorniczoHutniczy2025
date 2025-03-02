extends CanvasLayer



func _on_go_on_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/GameMap.tscn")
