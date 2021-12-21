extends Control

var following = false
var start_pos = Vector2()

func _on_TitleBar_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1 and event.is_pressed():
			following = true
			start_pos = get_local_mouse_position()

		if event.get_button_index() == 1 and not event.is_pressed():
			following = false

	
	if following:
		OS.set_window_position(OS.window_position+get_local_mouse_position()-start_pos)
	
	
