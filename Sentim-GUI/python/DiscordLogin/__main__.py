from flask import Flask, request, render_template, redirect, session
from oAuth import Oauth
import webbrowser


webbrowser.open(Oauth.LOCAL_URI)
app = Flask(__name__,template_folder="template")
#app.url_map.strict_slashes = False


@app.route("/",methods=["get","post"])

def index():
	print("redirecting")	
	#return render_template('index.html')
	return redirect(Oauth.DISCORD_LOGIN_URL)
	
	@app.route("/login", methods = ['GET', 'POST'])
	def login():
		
		
		print("GET?")
		code = request.args.get("code",type=str)
		print("CODE: ",code)
		access_token = Oauth.get_access_token(code)
		user_json = Oauth.get_user_json(access_token)
		username = user_json.get("username")
		app.logger.info("USER_JSON: ",user_json.get("username"))
		with open("test.txt", "w") as fo:
			fo.write(username)
		return username

if(__name__=="__main__"):
	app.run(host = "localhost",port = 5000, debug = True)

	