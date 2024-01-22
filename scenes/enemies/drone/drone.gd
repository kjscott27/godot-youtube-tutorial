extends CharacterBody2D

const speed: int = 300


func _process(_delta):
	var direction = Vector2.RIGHT
	velocity = direction * 100
	move_and_slide()
