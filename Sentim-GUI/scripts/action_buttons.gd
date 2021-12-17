extends Control

export var loggedin = false
export var bot = false
export var active = false
export var label = "Action"

func _ready():
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
	
	if active == true and loggedin == false:
		$actionBG.color = "#1e1f99"
		if $Label.text == "Login":
			OS.execute("python",['C:/Users/Zsetszko21/Documents/Sentim-GUI/python/DiscordLogin/Discord_Login.py'],true)
			loggedin = true
	if active == true and bot == true:
		if $Label.text == "List Servers":
			OS.execute("python",['C:/Users/Zsetszko21/Documents/Sentim-GUI/python/DiscordLogin/Sentim_BOT.py'],true)
			bot = false

	else:
		$actionBG.color = "#272143"
		
	


func _on_Login_action_button_mouse_entered():
	$actionBG.color = "#384fb0"
func _on_Login_action_button_mouse_exited():
	update_elements()
	
func _on_Login_action_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == 1:
			if $Label.text == "List Servers":
				bot = true
			var homeitems = get_tree().get_nodes_in_group("Homeitems")
			for item in homeitems:
				item.deactive()
				
			set_active()

