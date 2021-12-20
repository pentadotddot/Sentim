extends Tree

onready var filetree = get_node("ServersChannelsTree/Tree")

func _ready():
	var root = filetree.create_item()
	root.set_text(0,"Server1")

