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
@onready var horn_sounds = [$HornSound, $HornSound2, $HornSound3, $HornSound4, $HornSound5]
@onready var tween = get_tree().create_tween()


@onready var MAX_SPEED_ZONE = 150.0
var horn_index = 0
@onready var lewymiacz = false
@onready var prawymiacz = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var spee2d = linear_velocity.length() * 3.6  # Speed in km/h
	print("Speed: %.1f km/h" % spee2d)
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * MAX_STEER, delta * 2.5)
	
	if Input.is_action_just_pressed("horn"):
		horn_sounds[horn_index].play()
		horn_index = (horn_index + 1) % horn_sounds.size()
			
	#lewy kierunkowskaz
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
			
	#prawy kierunkowskaz
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
		
	#hamulce
	if Input.is_action_pressed("ui_accept"):
		engine_force = 0         
		brake = BRAKE_FORCE 
		$StopLights.visible = true
	#sterowanie przód tył
	else:
		engine_force = Input.get_axis("ui_down", "ui_up") * ENGINE_POWER
		brake = 0
		$StopLights.visible = false
	
	var speed = linear_velocity.length()
	  # Convert km/h to m/s (50 km/h ≈ 13.89 m/s)
	var MAX_SPEED = MAX_SPEED_ZONE / 3.6
	if speed > MAX_SPEED:
		linear_velocity = linear_velocity.normalized() * MAX_SPEED
	var distance_factor = clamp(speed/ SPEED_THRESHOLD, 0.0, 1.0)
	var target_camera_distance = lerp(BASE_CAMERA_DISTANCE, MAX_CAMERA_DISTANCE, distance_factor)
	
	#var lateral_offset = steering * CAMERA_LATERAL_OFFSET  # Wartość dodatnia lub ujemna, w zależności od kierunku skrętu
	var target_camera_position = camera.position
	
	#target_camera_position.x = lateral_offset <-- skręcanie kamerą w kierunek skręcania
	target_camera_position.z=lerp(camera.position.z, -target_camera_distance, CAMERA_LERP_SPEED)
	camera.position = target_camera_position
	

func _update_speed_display() -> void:
	var speed_kmh = linear_velocity.length() * 3.6  # Speed in km/h
	print("Speed: %.1f km/h" % speed_kmh)
	
func _handle_steering(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * MAX_STEER, delta * 2.5)

func _handle_horn() -> void:
	if Input.is_action_just_pressed("horn"):
		horn_sounds[horn_index].play()
		horn_index = (horn_index + 1) % horn_sounds.size()
		

func _handle_indicators() -> void:
	if Input.is_action_just_pressed("lewymiacz"):
		_toggle_indicator("left")
	if Input.is_action_just_pressed("prawymiacz"):
		_toggle_indicator("right")

func _toggle_indicator(side: String) -> void:
	if side == "left":
		lewymiacz = !lewymiacz
		prawymiacz = false
		_set_indicator_visibility($bmw/Left, lewymiacz, $bmw/Left/LeftTimer)
		_set_indicator_visibility($bmw/Right, false, $bmw/Right/RightTimer)
	elif side == "right":
		prawymiacz = !prawymiacz
		lewymiacz = false
		_set_indicator_visibility($bmw/Right, prawymiacz, $bmw/Right/RightTimer)
		_set_indicator_visibility($bmw/Left, false, $bmw/Left/LeftTimer)

func _set_indicator_visibility(light: Node, is_active: bool, timer: Timer) -> void:
	light.visible = is_active
	if is_active:
		timer.start()
	else:
		timer.stop()





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
