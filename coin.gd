extends Area3D
signal coin_collected

const ROT_SPEED = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Coins")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))
	
func _on_body_entered(body: Node3D) -> void:
		emit_signal("coin_collected")
		queue_free()
