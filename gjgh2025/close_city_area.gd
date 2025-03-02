extends Node3D


func _on_close_city_area_area_entered(area: Area3D) -> void:
	if(area.name == "CarCollider"):
		$Blockage.visible = true
		$Blockage/HouseType21.visible = true
		$Blockage/HouseType21/StaticBody3D.visible = true
		$Blockage/HouseType21/StaticBody3D/CollisionShape3D.visible = true
		$Blockage/HouseType21/StaticBody3D/CollisionShape3D.disabled = false
		$"../EndGame/EndGameTimer".start()
