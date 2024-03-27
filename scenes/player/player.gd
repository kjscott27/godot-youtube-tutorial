extends CharacterBody2D

signal primary_fire(pos, direction)
signal secondary_fire(pos, direction)

var can_primary_fire: bool = true
var can_alt_fire: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	var direction: Vector2 = Input.get_vector("Move Left", "Move Right", "Move Forward", "Move Back")
	var is_sprinting: bool = Input.is_action_pressed("Sprint")
	var is_primary_firing: bool = Input.is_action_pressed("Fire") and can_primary_fire
	var is_secondary_firing: bool = Input.is_action_pressed("Secondary Fire") and can_alt_fire
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	# Player Movement
	if is_sprinting:
		speed = 750
	else:
		speed = max_speed
		
	set_velocity(direction * speed)
	move_and_slide()
	
	# Player Rotation
	look_at(get_global_mouse_position())
	
	# Player Weapons
	if is_primary_firing:
		var possible_fire_markers = $LaserStartPositions.get_children()
		var selected_fire_marker_pos = possible_fire_markers[randi() % possible_fire_markers.size()].global_position
		$WeaponParticles.emitting = true
		can_primary_fire = false
		$PrimaryFireTimer.start()
		primary_fire.emit(selected_fire_marker_pos, player_direction)
		
	if is_secondary_firing:
		var possible_fire_markers = $LaserStartPositions.get_children()
		var selected_fire_marker_pos = possible_fire_markers[1].global_position
		can_alt_fire = false
		$AltFireTimer.start()
		secondary_fire.emit(selected_fire_marker_pos, player_direction)

func _on_primary_fire_timer_timeout():
	can_primary_fire = true


func _on_alt_fire_timer_timeout():
	can_alt_fire = true
