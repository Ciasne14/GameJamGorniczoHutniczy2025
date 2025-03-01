extends VehicleBody3D

const MAX_STEER = 0.8
const ENGINE_POWER = 300
const BRAKE_FORCE = 100
const BASE_CAMERA_DISTANCE = 6.0
const MAX_CAMERA_DISTANCE = 10.0
const SPEED_THRESHOLD = 30.0
const CAMERA_LERP_SPEED = 0.1
const CAMERA_LATERAL_OFFSET = 2.0

@onready var camera = $Camera3D
@onready var tween = get_tree().create_tween()

# Called when the node enters the scene tree for the first time.
@onready var lewymiacz = false
@onready var prawymiacz = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * MAX_STEER, delta * 2.5)
	if Input.is_action_just_pressed("lewymiacz"):
		if !lewymiacz:
			$bmw/Left.visible = !$bmw/Left.visible
			$bmw/Left/LeftTimer.start()
			lewymiacz=true
			prawymiacz=false
			$bmw/Right/RightTimer.stop()
			$bmw/Right.visible = false
		else:
			$bmw/Left.visible = false
			$bmw/Left/LeftTimer.stop()
			lewymiacz=false
			
	
	if Input.is_action_just_pressed("prawymiacz"):
		if !prawymiacz:
			$bmw/Right.visible = !$bmw/Right.visible
			$bmw/Right/RightTimer.start()
			prawymiacz=true
			lewymiacz=false
			$bmw/Left/LeftTimer.stop()
			$bmw/Left.visible = false
		else:
			$bmw/Right.visible = false
			$bmw/Right/RightTimer.stop()
			prawymiacz=false
		
	
	if Input.is_action_pressed("ui_accept"):
		engine_force = 0         
		brake = BRAKE_FORCE 
		$StopLights.visible = true
		
	else:
		engine_force = Input.get_axis("ui_down", "ui_up") * ENGINE_POWER
		brake = 0
		$StopLights.visible = false
	
	var speed = linear_velocity.length()
	var distance_factor = clamp(speed/ SPEED_THRESHOLD, 0.0, 1.0)
	var target_camera_distance = lerp(BASE_CAMERA_DISTANCE, MAX_CAMERA_DISTANCE, distance_factor)
	
	var lateral_offset = steering * CAMERA_LATERAL_OFFSET  # Wartość dodatnia lub ujemna, w zależności od kierunku skrętu
	var target_camera_position = camera.position
	
	target_camera_position.x = lateral_offset
	target_camera_position.z=lerp(camera.position.z, -target_camera_distance, CAMERA_LERP_SPEED)
	camera.position = target_camera_position
	


func _on_left_timer_timeout() -> void:
	$bmw/Left.visible=!$bmw/Left.visible # Replace with function body.


func _on_right_timer_timeout() -> void:
	$bmw/Right.visible=!$bmw/Right.visible 
