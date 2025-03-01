extends VehicleBody3D

const MAX_STEER = 0.8
const ENGINE_POWER = 300
const BRAKE_FORCE = 100
const BASE_CAMERA_DISTANCE = 4.0
const MAX_CAMERA_DISTANCE = 10.0
const SPEED_THRESHOLD = 30.0
const CAMERA_LERP_SPEED = 0.1

@onready var camera = $Camera3D
@onready var tween = get_tree().create_tween()
@onready var MAX_SPEED_ZONE = 150.0
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var spee2d = linear_velocity.length() * 3.6  # Speed in km/h
	print("Speed: %.1f km/h" % spee2d)
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * MAX_STEER, delta * 2.5)
	
	if Input.is_action_pressed("ui_accept"):
		engine_force = 0  
		brake = BRAKE_FORCE 
	else:
		engine_force = Input.get_axis("ui_down", "ui_up") * ENGINE_POWER
		brake = 0
	
	var speed = linear_velocity.length()
	  # Convert km/h to m/s (50 km/h ≈ 13.89 m/s)
	var MAX_SPEED = MAX_SPEED_ZONE / 3.6
	if speed > MAX_SPEED:
		linear_velocity = linear_velocity.normalized() * MAX_SPEED
	var distance_factor = clamp(speed/ SPEED_THRESHOLD, 0.0, 1.0)
	var target_camera_distance = lerp(BASE_CAMERA_DISTANCE, MAX_CAMERA_DISTANCE, distance_factor)
	
	var camera_position = camera.position
	camera_position.z=lerp(camera_position.z, -target_camera_distance, CAMERA_LERP_SPEED)
	camera.position = camera_position
	


func _on_car_collider_area_entered(area: Area3D) -> void:
	if(area.name == "RightLine"):
		steering = MAX_STEER
	if(area.name == "LeftLine"):
		steering = -MAX_STEER
	if(area.name == "MaxSpeedReduction50"):
		MAX_SPEED_ZONE=50.0
	if(area.name == "MaxSpeedReduction70"):
		MAX_SPEED_ZONE=70.0
	if(area.name == "Trafficlight"):
		engine_force = 0  
		brake = BRAKE_FORCE 
		linear_velocity=Vector3(0,0,0)
	print(area.name) # Replace with function body.
