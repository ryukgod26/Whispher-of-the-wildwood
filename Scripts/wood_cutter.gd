
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var health = 3
var DAMAGE = 2

var target_position
var target
var target_body
var targets = []
var intial_reached =false
func _physics_process(delta: float) -> void:
	if target_position == null and intial_reached == false:
		return
	if target_position != null:
		var direction = (target_position - global_position).normalized()
		velocity = direction *SPEED
		if direction.x < 0.1 and direction.y < 0.1:
			intial_reached = true
			target_position = null
	if intial_reached ==true and target_body == null and targets.size() > 0:
		target_body = targets.pop_back()
		target = target_body.global_position
		var direction = (target - global_position).normalized()
		velocity = direction * SPEED
		if direction.x < 0.2 and direction.y < 0.2:
			var attack_id = randi() % 3 +1
			var attackAnimation = "Attack%d" % [attack_id]
			animated_sprite.play(attackAnimation)
			var destroyed = target_body.take_damage(DAMAGE)
			if destroyed:
				target_body = null
	
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('Building'):
		targets.append(body)
		
func take_damage(DAMAGE):
	health -= DAMAGE
	check_health()

func check_health():
	if health <= 0:
		queue_free()

func get_target_position(mouse_pos):
	if target_position == null:
		target_position = mouse_pos
