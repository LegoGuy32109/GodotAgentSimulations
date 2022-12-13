extends CharacterBody2D

var agentsISee = []

var speed = 200

var random_range = 7

var moving = true

var desired_rotation = 0

@onready var sprite : Sprite2D = $Sprite2D

# sprites illustrating state change
var defaultSprite = preload("res://Assets/Default.png")
var scaredSprite = preload("res://Assets/Scared.png")
var evilSprite = preload("res://Assets/Evil.png")
var deadSprite = preload("res://Assets/Dead.png")

var state = 0

func _ready():
	randomize()
	self.set_rotation(randf_range(0, 2*PI)) 
	
func _physics_process(delta):

	self.set_velocity(Vector2(1,0).rotated(self.get_rotation())*speed)
	self.set_rotation(lerp_angle(self.get_rotation(), desired_rotation, 0.1))
	if moving:
		move_and_slide()
	
	if state == 0:
		sprite.set_texture(defaultSprite)
		if self.get_rotation() - desired_rotation < .1:
			desired_rotation = randf_range(0, 2*PI)
		
	if state == 1:
		sprite.set_texture(scaredSprite)
		
	if state == 2:
		sprite.set_texture(evilSprite)
	
	if agentsISee:
		if state != 2:
			var playerNear = false
			for agent in agentsISee:
				var a : CharacterBody2D = agent
				if a.name == "Player":
					desired_rotation = self.position.angle_to_point(a.position) - PI
					state = 1
					playerNear = true

					if self.position.distance_to(a.position) < 60:
						# touching player
						state = 2
		else:
			var smallestDistance = 10000
			var smallestDistanceCords = Vector2()
			for agent in agentsISee:
				var a : CharacterBody2D = agent
				if smallestDistance > self.position.distance_to(a.position) and self.position.distance_to(a.position) > 1:
					smallestDistanceCords = a.position
					smallestDistance = self.position.distance_to(a.position)
			desired_rotation = self.position.angle_to_point(smallestDistanceCords)


				

func _on_vision_body_entered(body):
	if body.is_in_group("agents"):
		agentsISee.append(body)

func _on_vision_body_exited(body):
	if body:
		agentsISee.erase(body)

