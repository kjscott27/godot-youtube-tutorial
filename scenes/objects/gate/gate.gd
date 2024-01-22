extends StaticBody2D

signal player_entered_gate
signal player_exited_gate

func _on_gate_entry_way_body_entered(body):
	player_entered_gate.emit(body)
	

func _on_gate_entry_way_body_exited(body):
	player_exited_gate.emit(body)
