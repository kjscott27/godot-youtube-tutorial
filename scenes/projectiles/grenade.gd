extends RigidBody2D

const speed = 750

func explode():
	$ExplosionPlayer.play('explosion')
