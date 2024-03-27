extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_player_primary_fire(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)


func _on_player_secondary_fire(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)

func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/PlayerCamera, 'zoom', Vector2(0.75, 0.75), 1.5)

func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/PlayerCamera, 'zoom', Vector2(0.5, 0.5), 1.5)
