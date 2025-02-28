extends VehicleBody3D

@export var camera_speed = 10
@export var max_steering = 0.9
@export var engine_power = 300
@onready var camere:Camera3D = $"../Camera3D"
@onready var camera_target:Node3D = $CameraTarget

func _process(delta: float):
 steering = lerp(steering, Input.get_axis("ui_right", "ui_left") * max_steering, delta * 10)
 engine_force = Input.get_axis("ui_down", "ui_up") * engine_power
 #camere.position = lerp(camere.position, camera_target.global_position, delta * camera_speed)
 #camere.rotation.y = rotate_toward(camere.rotation.y, camera_target.global_rotation.y, delta * camera_speed)
