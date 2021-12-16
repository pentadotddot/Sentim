import requests
import json

class Oauth(object):
	API_ENDPOINT = 'https://discord.com/api/v8'
	CLIENT_ID = '919888876703744030'
	CLIENT_SECRET = 'LHlWFz0zpxEyImfxk5xHTKvnswVDthEq'
	REDIRECT_URI = "http://localhost:5000/login"
	LOCAL_URI = "http://localhost:5000/"
	DISCORD_LOGIN_URL = "https://discord.com/api/oauth2/authorize?client_id=919888876703744030&redirect_uri=http%3A%2F%2Flocalhost%3A5000%2Flogin&response_type=code&scope=identify%20guilds"
	DISCORD_TOKEN_URL = "https://discord.com/api/oauth2/token"
	DISCORD_API_URL = "https://discord.com/api/"
	SCOPE = "identify%20guilds"

	@staticmethod

	def get_access_token(code):
		print("getting atoken")
		payload = {

			'client_id': Oauth.CLIENT_ID,
			'client_secret': Oauth.CLIENT_SECRET,
			'grant_type': 'authorization_code',
			'code': code,
			'redirect_uri': Oauth.REDIRECT_URI,
			'scope' : Oauth.SCOPE
		}	
		
		headers = {
		'Content-Type': 'application/x-www-form-urlencoded'
		}

		access_token = requests.post(url=Oauth.DISCORD_TOKEN_URL,data = payload, headers = headers)
		print("Atoken: ",access_token)

		json = access_token.json()

		return json.get("access_token")

	#get user data https://discord.com/developers/docs/resources/user#get-current-user
	@staticmethod
	def get_user_json():
		print("getting userinfo")
		url = Oauth.DISCORD_API_URL+"/user/@me"

		headers = {

		"Authorization": "Bearer {}".format(access_token)

		}

		user_object = requests.get(url=url,headers=headers)
		user_json = user_object.json()

		return user_json




