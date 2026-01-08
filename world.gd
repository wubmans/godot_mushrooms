extends Node2D

const MUSHROOM = preload("uid://c7evtdgqr3euf")
const ENEMY = preload("uid://cg7r63lyk3nlo")


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
	var position = Vector2(randf_range(0, 1200), randf_range(0, 600))
	var mushrooms = get_tree().get_nodes_in_group("mushrooms")
	if mushrooms.size() > 0:
		if randi() % 100 > 50: 
			position = mushrooms[randi() % mushrooms.size()].global_position
			position = position + Vector2(randf_range(-70, 70 ), randf_range(-70, 70))
	
	var mushroom = MUSHROOM.instantiate()
	mushroom.global_position = position
	mushroom.final_radius = randf_range(50, 100)
	add_child(mushroom)

func create_enemy():
	var enemy = ENEMY.instantiate()
	enemy.global_position = Vector2(randf_range(0, 1200), randf_range(0, 600))
	#enemy.final_radius = randf_range(50, 200)
	add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if randi() % 1000 > 924: 
		create_mushroom()

	var enemy_count = get_tree().get_nodes_in_group("enemies").size()
	
	if randi() % 1000 > (900): 
		create_enemy()
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	pass
