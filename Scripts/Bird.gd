extends KinematicBody2D

export var acceleration: int = -20


func _ready():
	$AnimationPlayer.play("bird_flying")


func _physics_process(delta):
	var speed = Vector2(acceleration, 0)
	speed = move_and_slide(speed, Vector2.UP)
