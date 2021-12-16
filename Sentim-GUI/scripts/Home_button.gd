extends Control

export(StreamTexture) var icon
export var label = "Home"
export var active = false
export(NodePath) var page

func _ready():
	$Home.texture = icon
	$Label.text = label
	update_elements()

func set_active():
	active = true
	update_elements()
	
func deactive():
	active = false
	update_elements()
	
func update_elements():
	$active.visible = active
	get_node(page).visible = active
	if active:
		$homeBG.color = "#1e1f99"
	else:
		$homeBG.color = "#272143"
		
func _on_Home_button_mouse_entered():
	$homeBG.color = "#384fb0"
func _on_Home_button_mouse_exited():
	update_elements()


func _on_Home_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == 1:
			var navitems = get_tree().get_nodes_in_group("navitem")
			for item in navitems:
				item.deactive()
			set_active()



