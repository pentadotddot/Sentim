extends Control

onready var filetree = get_node("WindowsControl/Tree")
var item_data

func _on_Tree_cell_selected():
	
	print(filetree.get_selected().get_text(0)," ", filetree.get_selected_column())
	if filetree.get_selected_column() == 0:
		
		if filetree.get_selected().is_checked(1) == true:

			print("is_checked")
			filetree.get_selected().set_checked(1,false)
			
		else:
			print("is_not_checked")
			filetree.get_selected().set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
			filetree.get_selected().set_checked(1,true)
			

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
		
		print(len(item_data) )
		
		var root = filetree.create_item()
		root.set_text(0,"root")
		
		if len(item_data) == 1:
			var servernode_name = item_data[0]["name"]
			var servernode = filetree.create_item(root)
			servernode.set_text(0,servernode_name)
			
		else:
			for server in item_data:
				print(server)
				var servernode_name = item_data[server]["name"]
				var servernode = filetree.create_item(root)
				servernode.set_text(0,servernode_name)

				for channel in item_data[server]["channels"]:
					var channelnode_name = channel
					var channelnode = filetree.create_item(servernode)
					channelnode.set_text(0,channelnode_name)

				
		
	filetree.set_hide_root(true)










