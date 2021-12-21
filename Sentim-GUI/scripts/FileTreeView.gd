extends Control
onready var filetree = get_node("WindowsControl/Tree")

func _on_ServersChannelsTree_viewSignal(dictionary):
	
	print("VIEW WINDOW: ",dictionary)
	var item_data = dictionary
	
	print(item_data)
	
	filetree.clear()

	var root = filetree.create_item()
	root.set_text(0,"root")
	

	for server in range(len(item_data["data"])):
		print("serverindex: ",server)
		var servernode_name = item_data["data"][server]["name"]
		var servernode = filetree.create_item(root)
		servernode.set_text(0,servernode_name)
	
		var checkedChannelArr = []
		for channel in item_data["data"][server]["channels"]:
			print("channelindex: ",channel)
			var channelnode_name = channel
			var channelnode = filetree.create_item(servernode)
			channelnode.set_text(0,channelnode_name)
			
			if channelnode.is_checked(1) == true:
				checkedChannelArr.append(str(channelnode_name))		
					

	filetree.set_hide_root(true)


	
