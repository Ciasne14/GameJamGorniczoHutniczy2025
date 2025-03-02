extends Node3D


func _on_end_game_timer_timeout() -> void:
	$Finisher.visible=true
	$Finisher2.visible=true
	$Finisher3.visible=true
	$Finisher4.visible=true
	$Finisher/MeshInstance3D/Finisher/CollisionShape3D.disabled=false
	$Finisher2/MeshInstance3D/Finisher/CollisionShape3D.disabled=false
	$Finisher3/MeshInstance3D/Finisher/CollisionShape3D.disabled=false
	$Finisher4/MeshInstance3D/Finisher/CollisionShape3D.disabled=false
