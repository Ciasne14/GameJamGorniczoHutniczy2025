extends Area3D

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(area):
	print("Collision with another Area3D:", area.name)
