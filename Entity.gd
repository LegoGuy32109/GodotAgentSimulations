extends RigidBody2D

@export_range(5, 500, 1) var impulse_range : int = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	apply_central_impulse(Vector2(randi_range(-impulse_range, impulse_range),randi_range(-impulse_range, impulse_range)))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

