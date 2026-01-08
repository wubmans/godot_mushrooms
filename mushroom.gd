extends Node2D

@onready var timer_control: Control = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var circle: Node2D = $Circle

var timer: float = 0.0
var circle_timer: float = 0.0
var circle_timer_max : float = 0.4
var cooldown_time: float = 2.4
var is_triggered: bool = false
var has_triggered: bool = false
var triggered_timer: float = 0.0

@export var final_radius: float = 80.0

@onready var sprite_material: ShaderMaterial  = $AnimatedSprite2D.material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = randf_range(0.0, 5.0)
	cooldown_time = randf_range(6.0, 20.0)
	material = $AnimatedSprite2D.material
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_control.progress = timer / cooldown_time
	timer -= delta
	circle_timer += delta
			
	if timer <= 0:		
		flash(Color.WHITE)
		fire()
		circle_timer = 0.0
		timer = cooldown_time
		has_triggered = false
	
	circle.r = 0.0
	circle.r_max = final_radius
	
	if circle_timer < circle_timer_max:
		circle.r = final_radius * pow(circle_timer / circle_timer_max, 0.3)

func is_trigger():
	await get_tree().create_timer(0.05).timeout
	
	if is_triggered:
		return
		
	if timer <= 0:
		return
	
	is_triggered = true
	flash(Color.YELLOW)
	fire()
	await get_tree().create_timer(0.5).timeout 
	is_triggered = false
	#if triggered_timer > 0:
		#triggered_timer = timer
		#is_triggered = true
		#timer = 0	
	#fire()

func fire():
	#if is_triggered:
		#is_triggered = false
		
	var strength = 3.0
	var time = 0.2
	var t := create_tween()
	t.tween_property(animated_sprite_2d, "scale", Vector2.ONE * strength, time).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.tween_property(animated_sprite_2d, "scale", Vector2.ONE, time)
	
	trigger()

	

func trigger():
	if has_triggered:
		return
		
	has_triggered = true
	var shrooms = get_tree().get_nodes_in_group("mushrooms")
	for shroom in shrooms:
		if shroom == self:
			continue
		var distance = (shroom.global_position - global_position).length()
		if distance < final_radius:
			if !shroom.has_triggered:
				shroom.is_trigger()
				
				
	await get_tree().create_timer(0.5).timeout 
	has_triggered = false

func _on_h_slider_value_changed(value: float) -> void:
	final_radius = value
	pass # Replace with function body.

func flash(color):
	#return
	sprite_material.set_shader_parameter("flash_color", color)
	sprite_material.set_shader_parameter("flash", 1.0)
	var flash_tween = create_tween()
	flash_tween.tween_property(sprite_material, "shader_parameter/flash", 0.0, 0.2)
