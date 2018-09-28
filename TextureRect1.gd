extends TextureRect

func get_drag_data(pos):
	var icon = TextureRect.new()
	icon.position = self.position
	icon.rect_size = Vector2(100,100)
	set_drag_preview(icon)
	
func can_drop_data(pos, data):
	return typeof(data) == TYPE_VECTOR2
	
func drop_data(pos, data):
	pos=data