extends Node2D

var circleScene := preload("res://Circle.tscn")

@export_range(20, 150, 10) var spawn_range : int = 20

func _ready() -> void:
	for i in range (40):
		# wait in seconds
		await get_tree().create_timer(0.5).timeout
		var circle := circleScene.instantiate()
		
		var rand_x : float = randi_range(-spawn_range,spawn_range)
		var rand_y : float = randi_range(-spawn_range,spawn_range)
		circle.translate(Vector2(rand_x,rand_y))
		self.add_child(circle)
