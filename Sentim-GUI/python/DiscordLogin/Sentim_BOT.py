import os,sys
import discord
from discord.ext import commands
import requests
import pandas as pd
import numpy as np
import time
import asyncio
import datetime
from dateutil import parser
import math
import requests
import numpy as np
import json

save_user_data_path = "C:/Users/Zsetszko21/Documents/Sentim-GUI/python/DiscordLogin/"

TOKEN = "OTE5ODg4ODc2NzAzNzQ0MDMw.YbcXRg.Sp8ZbH1VprFOqSQuqjhxHzgzFqw"

intents = discord.Intents.default()
intents.members = True
#client = discord.Client(intents=intents)
client = commands.Bot(command_prefix=['!'],intents=intents)

@client.event
async def on_ready():

	# Opening JSON file
	f = open(save_user_data_path +'UserGuildsData.json')

	ServersJSON = json.load(f)
	ServerBotisIn = {}
	newitem = 0

	f.close()
	
	for server in client.guilds:
		#print(server.name)
		channel_append_to_index = None
		for index in range(len(ServersJSON)):
			if int(ServersJSON[index]["id"]) == int(server.id):
				
				channel_append_to_index = index
				
				ServerBotisIn[newitem] = ServersJSON[index]
				
				break
		

		if channel_append_to_index is not None:
		
			server_channels = []
			for channel in server.text_channels:
				
				server_channels.append(str(channel.name) )
				
			#ServersJSON[channel_append_to_index]["channels"] = server_channels 
			ServerBotisIn[newitem]["channels"] = server_channels
			newitem+=1	
		else:

			continue


	with open(save_user_data_path+"ServersChannels.json", "w") as outfile:
		json.dump(ServerBotisIn, outfile)

	sys.exit(1)

client.run(TOKEN)

