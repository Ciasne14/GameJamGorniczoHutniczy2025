extends Node3D

var green = true
var yellow = false
var red = false

func _on_timer_timeout() -> void:
	if(green):
		green=false
		yellow = true
		red=false
		$Timer.wait_time=10
	elif(yellow && red):
		green = true
		yellow = false
		red = false
		$Timer.wait_time=1
	elif(yellow):
		green=false
		yellow = false
		red=true
		$Timer.wait_time=1
	elif(red):
		green=false
		yellow = true
		red=true
		$Timer.wait_time=5
	
	set_lights()
		

func set_lights():
	$Green.visible=green
	$Yellow.visible=yellow
	$Red.visible=red
	$Trafficlight.visible = red
func _on_trafficlight_info_area_entered(area: Area3D) -> void:
	if(area.name=="CarCollider"):
		$Timer.autostart=true
		$Timer.start()
		set_lights()# Replace with function body.
