extends Area3D

@export var object_scene: PackedScene  # Scene to instantiate
@onready var existing_object = $ExistingObject  # Reference to the existing object

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(area):
	if(area.name=="CarCollider"):
		spawn_at_existing_object()
		$"..".queue_free()
	
func spawn_at_existing_object():
	var new_object = object_scene.instantiate()  # Create new object
	new_object.position = $"..".position
	var parent_node = get_node("../..")
	parent_node.add_child(new_object)
	  # Add it to the scene tree
