extends Node3D

@onready var tween = get_tree().create_tween()
@onready var range = .4
func _ready():
	range = randf_range(0.4, 4.0)
	patrol()

func patrol():
	# Move right
	tween.tween_property(self, "position:z", range, 1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "rotation:y", deg_to_rad(180), 0.5)  # Face forward

	# Move left
	tween.tween_property(self, "position:z", -range, 1.0).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "rotation:y", deg_to_rad(0), 0.5)  # Face backward

	tween.set_loops()  # Loops indefinitely
