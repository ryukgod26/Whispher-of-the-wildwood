extends RigidBody2D

@export var SPEED = 3000

var DAMAGE = 1
var target
func _physics_process(delta: float) -> void:
	if target == null:
		queue_free()
	var direction = (target - global_position).normalized()
	linear_velocity = direction*SPEED

func shoot_at(target_position):
	target = target_position
	

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("troop"):
		body.take_damage(DAMAGE)
		queue_free()
		
