"""
Example of using Discord OAuth to allow someone to
log in to your site. The scope of 'email+identify' only
lets you see their email address and basic user id.
"""
from requests_oauthlib import OAuth2Session
import getpass
from flask import Flask, request, redirect, session
import os,sys,time
import webbrowser, pyautogui
import json

save_user_data_path = "C:/Users/Zsetszko21/Documents/Sentim-GUI/python/DiscordLogin/"

# Disable SSL requirement
os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'

# Settings for your app
base_discord_api_url = 'https://discordapp.com/api/v8'
client_id = r'919888876703744030' # Get from https://discordapp.com/developers/applications
client_secret = "LHlWFz0zpxEyImfxk5xHTKvnswVDthEq"
redirect_uri='http://localhost:5000/oauth_callback'
local_uri = "http://localhost:5000/"
scope = ['identify', 'guilds']
token_url = 'https://discordapp.com/api/oauth2/token'
authorize_url = 'https://discordapp.com/api/oauth2/authorize'

app = Flask(__name__)
app.secret_key = os.urandom(24)
webbrowser.open(local_uri)

@app.route("/")
def home():
	"""
	Presents the 'Login with Discord' link
	"""
	oauth = OAuth2Session(client_id, redirect_uri=redirect_uri, scope=scope)
	login_url, state = oauth.authorization_url(authorize_url)
	session['state'] = state
	#print("Login url: %s" % login_url)
	#return '<a href="' + login_url + '">Login with Discord</a>'
	return redirect(login_url)
@app.route("/oauth_callback")
def oauth_callback():
	"""
	The callback we specified in our app.
	Processes the code given to us by Discord and sends it back
	to Discord requesting a temporary access token so we can 
	make requests on behalf (as if we were) the user.
	e.g. https://discordapp.com/api/users/@me
	The token is stored in a session variable, so it can
	be reused across separate web requests.
	"""
	discord = OAuth2Session(client_id, redirect_uri=redirect_uri, state=session['state'], scope=scope)
	token = discord.fetch_token(
		token_url,
		client_secret=client_secret,
		authorization_response=request.url,
	)
	session['discord_token'] = token

	discord = OAuth2Session(client_id, token=session['discord_token'])
	response = discord.get(base_discord_api_url + '/users/@me')
	response_guilds = discord.get(base_discord_api_url + '/users/@me/guilds')
	# https://discordapp.com/developers/docs/resources/user#user-object-user-structure
	
	with open(save_user_data_path+"UserData.json", "w") as outfile:
		json.dump(response_guilds.json(), outfile)

	#return 'Thanks for granting us authorization! You can now close this windows: '
	return 'Thanks for granting us authorization. We are logging you in! You can now close this tab: <a href="/profile"><button type="close" onclick="window.close();">Close Tab</button></a>'
 
@app.route("/profile")
def profile():
	
	#
	#time.sleep(0.1)
	pyautogui.hotkey('ctrl', 'w')
	os._exit(1)
	sys.exit(1)
	


# Or run like this
# FLASK_APP=discord_oauth_login_server.py flask run -h 0.0.0.0 -p 8000
if __name__ == '__main__':
	app.run(host='localhost', port=5000)