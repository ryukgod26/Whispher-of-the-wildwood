extends StaticBody2D

@onready var canon_ball_scene = preload("res://Scenes/canon_ball.tscn")
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var sprite: Sprite2D = $Sprite2D

var player = null
var players = []
var health = 10

func  _physics_process(delta: float) -> void:
	if player == null and players.size() > 0:
		player = players.front()
		players.pop_front()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("troop"):
		if player != null:
			players.append(body)
			return
		player = body
		var direction = (global_position - player.global_position).normalized()
		if direction.x < 0:
			sprite.flip_h = false
		elif direction.x > 0:
			sprite.flip_h = true
					
		fire_rate_timer.start()
		_fire_canon()
	
func _fire_canon():
	if player == null:
		return
	var cannonball = canon_ball_scene.instantiate()
	var spawn_position = global_position
	var target_position = player.global_position	
	get_parent().add_child(cannonball)
	cannonball.global_position = spawn_position
	cannonball.shoot_at(target_position)
		

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
	for comp in players:
		if comp == body:
			players.find(comp)
	


func _on_fire_rate_timer_timeout() -> void:
	if player == null:
		return
	call_deferred("_fire_canon")

func take_damage(DAMAGE) -> bool:
	health -= DAMAGE
	if health <=0:
		queue_free()
		return true
	return false
