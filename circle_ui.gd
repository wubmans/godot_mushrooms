extends Node2D

@onready var node_2d: Node2D = $".."
var r = 20.0
var r_max = 20.0
var fill_color = Color.CORNFLOWER_BLUE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass


func _draw() -> void:
	var p: float = clamp (r / r_max, 0.0, 1.0)
	p = 1.0 - pow(1.0 -p, 4.0)
	var color = Color.WHITE
	color.a = 0.2
	#draw_arc(Vector2.ZERO, r_max, 0.0, TAU, 64, color, 0.5, true)
	fill_color.a = 0.7 - (r / r_max)
	#draw_arc(Vector2.ZERO, r, 0.0, TAU, 64, color, 0.5, true)
	draw_circle(Vector2.ZERO, r_max * p, fill_color)
	#var p : float = clamp(circle_timer / duration, 0.0, 1.0)
	#p = 1.0 - pow(1.0 - p, 3.0)

	#var r := final_radius * p
	#
	#r = 0.0
#
	## filled circle
	#fill_color.a = lerp(1.0, 0.0, p)
	#
	

	# outline (optional)
	#if outline_width > 0.0:
		# draw_arc is in radians; 0..TAU is full circle
		#
