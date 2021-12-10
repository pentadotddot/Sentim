extends ColorRect

enum TYPES {close,maximize,minimize}
export(TYPES) var types = TYPES.close
export(StreamTexture) var icon = preload("res://icons/exit.png")


func _ready():
	$"Exit".texture = icon
	
func _on_sys_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == 1:
			if types == TYPES.close:
				get_tree().quit()
			elif types == TYPES.minimize:
				OS.set_window_minimized(true)
			else:
				OS.set_window_maximized(!OS.is_window_maximized())


func _on_sys_button_mouse_entered():
	if types == TYPES.close:
		$".".color = "#ff0000"
	else:
		$".".color = "#1e1f7a"
	
func _on_sys_button_mouse_exited():
	
	$".".color = "#1e1f59"
	
