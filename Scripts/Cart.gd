extends KinematicBody2D


export var const_acceleration: int = 60
export var gravity: int = 20

var speed: Vector2
var collision_normal: Vector2

onready var bottom_detect: RayCast2D = $Bottom
onready var forward_detect: RayCast2D = $Forward

#var to check gravity and supress it on uphills
#var gravity_check:bool = false


func _physics_process(delta):
	var velocity: Vector2 = Vector2.ZERO
	velocity.x += const_acceleration
	velocity.y += gravity
	
	
	
	velocity = move_and_slide(velocity)
	
	if get_slide_count() > 0:
		for collision_index in range(get_slide_count()):
			var collision: KinematicCollision2D = get_slide_collision(collision_index)
			var angleDelta := collision.normal.angle() - (rotation - PI)
			collision_normal = collision.normal
			
			#trying to solve not going uphill --WORKING--
			gravity = 10
			velocity.x = const_acceleration + 20
			
			
			if $RotateTimer.is_stopped():
				rotation = angleDelta + rotation - deg2rad(90)
				$RotateTimer.start()
#	elif !is_on_floor():
#		gravity = 180
#		print("Detection: player not touching floor")
	else:
		gravity = 180
		velocity.x = const_acceleration

