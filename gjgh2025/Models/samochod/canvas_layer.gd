extends CanvasLayer

@onready var speed_label = $"Control/predkosc"
@onready var left_indicator = $Control/lewymiacz
@onready var right_indicator = $Control/prawymiacz


var vehicle  # Odniesienie do pojazdu


func _ready():
	vehicle = get_parent()  # Pobieramy pojazd jako nadrzędny obiekt

func _process(delta):
	if vehicle:
		# Aktualizacja prędkości
		var speed_kmh = vehicle.linear_velocity.length() * 3.6
		speed_label.text = "Speed: %.1f km/h" % speed_kmh
		$Control/HSlider.value=speed_kmh
		# Aktualizacja kierunkowskazów
		left_indicator.visible = vehicle.lewymiacz and vehicle.get_node("bmw/Left").visible
		right_indicator.visible = vehicle.prawymiacz and vehicle.get_node("bmw/Right").visible


	
func _on_timer_timeout() -> void:
	$Control/HSlider2.value = $Control/HSlider2.value - 1
	if($Control/HSlider2.value==0):
		get_tree().change_scene_to_file("res://Scenes/end_game_bateria.tscn")
