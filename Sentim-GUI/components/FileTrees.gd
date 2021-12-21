extends Control

onready var filetree = get_node("WindowsControl/Tree")
var item_data
signal viewSignal(dictionary)

func _on_Tree_cell_selected():
	var viewTreeDict = {"data" : []}

	
	if filetree.get_selected_column() == 0:
		
		if filetree.get_selected().is_checked(1) == true:

			
			filetree.get_selected().set_checked(1,false)
			
		else:
		
			filetree.get_selected().set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
			filetree.get_selected().set_checked(1,true)
		
	
	if filetree.get_root() != null:
		var child = filetree.get_root().get_children()
		var counter = 0
		while child != null:
			if child.is_checked(1) == true:
				var serverDictname = child.get_text(0)
				
				var serverdetails = {}
				serverdetails["name"] = serverDictname
				if !serverdetails in viewTreeDict:
					viewTreeDict["data"].append(serverdetails)
				

			var childchild = child.get_children()
			var channels = []
			while childchild!=null:	
				if childchild.is_checked(1) == true:
					
					var channelDictname = childchild.get_text(0)
					channels.append(channelDictname)
				childchild = childchild.get_next()
			
			if child.is_checked(1) == true:
				
				viewTreeDict["data"][counter]["channels"] = channels
				counter+=1

			child = child.get_next()
	
	emit_signal("viewSignal",viewTreeDict)
	return viewTreeDict
	

			

func _ready():	
	# load servers and channels the user is eligable to inspect with the bot
	var itemdata_file = File.new()
	if itemdata_file.file_exists("res://python/DiscordLogin/ServersChannels.json") == false:
		itemdata_file.open("res://python/DiscordLogin/ServersChannels.json", File.WRITE)
		itemdata_file.store_line('[{"name": "First load the data or even sign in with Discord!"}]')
		var itemdata_json = JSON.parse(itemdata_file.get_as_text())
		item_data = itemdata_json.result
		var root = filetree.create_item()
		root.set_text(0,"root")
		var servernode_name = item_data[0]["item"]
		var servernode = filetree.create_item(root)
		servernode.set_text(0,servernode_name)

	else:
		itemdata_file.open("res://python/DiscordLogin/ServersChannels.json",File.READ)

		var itemdata_json = JSON.parse(itemdata_file.get_as_text())
		itemdata_file.close()
		item_data = itemdata_json.result
		
	
		
		var root = filetree.create_item()
		root.set_text(0,"root")
		
		if len(item_data) == 1:
			var servernode_name = item_data[0]["name"]
			var servernode = filetree.create_item(root)
			servernode.set_text(0,servernode_name)
			
		else:
	


			for server in item_data:
		
				var servernode_name = item_data[server]["name"]
				var servernode = filetree.create_item(root)
				servernode.set_text(0,servernode_name)
			
				
				var checkedChannelArr = []
				for channel in item_data[server]["channels"]:
					var channelnode_name = channel
					var channelnode = filetree.create_item(servernode)
					channelnode.set_text(0,channelnode_name)
					
					if channelnode.is_checked(1) == true:
						checkedChannelArr.append(str(channelnode_name))		
				
			
				#viewTreeDict["serverData"][str(servernode_name)]["channels"].append(checkedChannelArr)				

	filetree.set_hide_root(true)










