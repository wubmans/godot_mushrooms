extends Node2D

@onready var body: CharacterBody2D = $CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D

var target
var is_dead : bool = false
var max_distance: float = 400
var health = 250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func find_target():
	target = null
	var min_distance : float = INF
	var mushrooms = get_tree().get_nodes_in_group("mushrooms")
	if mushrooms.size() == 0:
		return null
	for m in mushrooms:
		var distance = (body.global_position - m.global_position).length()
		if distance > max_distance:
			continue
		if distance < min_distance:
			target = m
			min_distance = distance
	
	return target
		

func _draw():
	if is_dead:
		return
	if target:
		draw_circle(to_local(target.global_position), 5, Color.DARK_GOLDENROD)
		draw_circle(to_local(body.global_position), 5, Color.DARK_SEA_GREEN)
		draw_line(to_local(target.global_position), to_local(body.global_position), Color.RED)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
	target = find_target()
	if ! target:
		body.velocity = Vector2.ZERO
		return

	var direction = target.global_position - body.global_position
	if direction.length () < 25.0:
		target.attack()
	body.velocity = direction.normalized() * 5.0 * 10.0 
	body.move_and_slide()
	
	pass

func kill():
	health -= 50
	if health > 0:
		return
	
	is_dead = true
	var gpu_particles_2d: GPUParticles2D = $CharacterBody2D/GPUParticles2D
	gpu_particles_2d.restart()
	animated_sprite_2d.hide()
	await get_tree().create_timer(0.6).timeout
	queue_free()
