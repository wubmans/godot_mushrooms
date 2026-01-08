extends Node2D

const MUSHROOM = preload("uid://c7evtdgqr3euf")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#for i in range(10 + randi() % 20):
	for i in range(4):
		create_mushroom()
		#var mushroom = MUSHROOM.instantiate()
		#mushroom.global_position = Vector2(randf_range(0, 1200), randf_range(0, 800))
		#mushroom.final_radius = randf_range(50, 250)
		#add_child(mushroom)
	#pass # Replace with function body.

func create_mushroom():
	var mushroom = MUSHROOM.instantiate()
	mushroom.global_position = Vector2(randf_range(0, 1200), randf_range(0, 600))
	mushroom.final_radius = randf_range(50, 200)
	add_child(mushroom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if randi() % 1000 > 983: 
		create_mushroom()
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	pass
