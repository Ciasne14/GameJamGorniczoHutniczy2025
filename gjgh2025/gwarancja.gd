extends Node3D

@onready var gwarancja = true
func _on_area_3d_area_entered(area: Area3D) -> void:
	if(area.name=="CarCollider" && gwarancja):
		$AudioStreamPlayer3D.play()
		$"../../Character-male-b".visible = false
		gwarancja=false
