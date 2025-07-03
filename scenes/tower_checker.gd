extends Area2D

@export var collision_shape: CollisionShape2D

var WRONG_COLOR =  Color(1, 0, 0, 0.3)
var OK_COLOR = Color(0,1,0,0.3)

var collision_color
var tiles_collide = []
# Called when the node enters the scene tree for the first time.
func _ready():
	#queue_redraw()
	collision_color = OK_COLOR
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _draw():
	if not collision_shape or not collision_shape.shape:
		return
	var shape = collision_shape.shape
	$CollisionVisualizer.position = collision_shape.position
	match shape:
		RectangleShape2D:
			print(shape.extents)
			var rect = Rect2(-shape.extents, shape.extents * 2)
			draw_rect(rect, collision_color, true)
			draw_rect(rect, Color.RED, false)
		_:
			var position = Vector2($CollisionVisualizer.position.x-shape.size.x / 2, $CollisionVisualizer.position.y - shape.size.y / 2)
			var rect = Rect2(position, shape.extents * 2)
			draw_rect(rect, collision_color, true)

#func _on_area_entered(area):
	#print_debug('Hit tile', area)
#
#
#func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#print_debug('Hit tile', area)
#
#
#func _on_body_entered(body):
	#print_debug('Hit tile', body)
	
func can_build() -> bool:
	return true if collision_color == OK_COLOR else false

func _update_collision_color() -> void:
	collision_color = WRONG_COLOR if tiles_collide.size() > 0 else OK_COLOR
	queue_redraw()


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#print_debug('Hit tile')
	tiles_collide.append(body)
	_update_collision_color()


func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	#print('Exit tile')
	tiles_collide.pop_back()
	_update_collision_color()
