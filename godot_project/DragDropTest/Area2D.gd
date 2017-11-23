extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var isDragging = false

var mouse_tile_pos_offset

var original_position

var tile_node
var tile_size

export var overValidTarget = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	tile_node = get_node("icon")
	tile_size = tile_node.get_texture().get_size()
	
	set_process(true)

func _process(delta):
	if(isDragging):
		self.position = get_global_mouse_position() + mouse_tile_pos_offset
	

func _input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		if(event.pressed):
			print("Clicked")
			isDragging = true
			#store original position
			original_position=position
			#save mouse offset
			print(self.position)
			print(get_global_mouse_position())
			mouse_tile_pos_offset = self.position - get_global_mouse_position()
		else:
			print("Released")
			print("overValidTarget: ",overValidTarget)
			if(overValidTarget):
				position.x = clamp(position.x, tile_size.x/2, get_viewport_rect().size.x - tile_size.x / 2)
				position.y = clamp(position.y, tile_size.y/2, get_viewport_rect().size.y - tile_size.y / 2)
			else:
				position = original_position
			isDragging = false
						
			