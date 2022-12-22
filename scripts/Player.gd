extends Area2D

# custom signals that the player will emit (send out) later
signal pickup
signal hurt

export (int) var speed
var velocity = Vector2()
var screensize = Vector2(480, 720)

# class memeber variables go here, for example
# var a = 2
# var b = "textvar"

func _ready():
	# called every time the node is added to the scene
	# initilization here
	pass

func _process(delta):
	get_input()
	position += velocity * delta
	# prevent user from going outside of bounds of screen
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
#	if velocity.length() > 0:
#		$AnimatedSprite.play("run")
#		$AnimatedSprite.flip_h = velocity.x < 0
#	else:
#		$AnimatedSprite.play("idle")

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.play("idle")

func die():
	$AnimatedSprite.play("hurt")
	set_process(false)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


# EVENTS

func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup", "coin")
	if area.is_in_group("powerups"):
		area.pickup()
		emit_signal("pickup", "powerup")
	if area.is_in_group("obstables"):
		emit_signal("hurt")
		die()
