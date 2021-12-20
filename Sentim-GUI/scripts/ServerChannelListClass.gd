extends Node

var checked
var label 		setget set_label, get_label

func _ready():
	pass
	

func constructor(params = {}):
	label = ("Unknown item" if !params.has("label") else params["label"])
	checked = (false if !params.has("checked") else params["checked"]) 

func set_label(l):
	label = l
	
func get_label():
	return label
