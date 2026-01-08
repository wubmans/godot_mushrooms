extends Control

@export var radius := 32.0
@export var thickness := 3.0 # 0 = filled pie, >0 = ring thickness
@export var start_angle := -PI / 2.0 # start at top
@export var segments := 64

@export_range(0.0, 1.0, 0.001) var progress := 1.0:
	set(v):
		progress = clamp(v, 0.0, 1.0)
		queue_redraw()

func _draw() -> void:
	var center := size * 0.5
	var sweep := TAU * progress
	if sweep <= 0.0001:
		return

	if thickness <= 0.0:
		# Filled pie
		var pts: PackedVector2Array = []
		pts.append(center)
		for i in range(segments + 1):
			var t := float(i) / float(segments)
			var a := start_angle + sweep * t
			pts.append(center + Vector2(cos(a), sin(a)) * radius)
		draw_colored_polygon(pts, Color(1, 1, 1, 0.8))
	else:
		# Ring sector
		var r_outer := radius
		var r_inner : float = max(0.0, radius - thickness)

		for i in range(segments):
			var t0 := float(i) / float(segments)
			var t1 := float(i + 1) / float(segments)
			var a0 := start_angle + sweep * t0
			var a1 := start_angle + sweep * t1

			var p0o := center + Vector2(cos(a0), sin(a0)) * r_outer
			var p1o := center + Vector2(cos(a1), sin(a1)) * r_outer
			var p1i = center + Vector2(cos(a1), sin(a1)) * r_inner
			var p0i = center + Vector2(cos(a0), sin(a0)) * r_inner

			draw_colored_polygon(PackedVector2Array([p0o, p1o, p1i, p0i]), Color(1, 1, 1, 0.8))
