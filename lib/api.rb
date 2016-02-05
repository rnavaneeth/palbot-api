require 'sinatra'
require 'yaml'
require 'json'
require 'firebase'

firebase_config = YAML.load_file('config/development.yml')
base_uri = "https://#{firebase_config['base_uri']}.firebaseio.com/"
firebase = Firebase::Client.new(base_uri, firebase_config['secret_key'])

get "/famous_quote" do 	
	quotes = firebase.get("quotes").body
	random_quote_id = quotes.keys.sample
	quote = quotes[random_quote_id]
	quote['id'] = random_quote_id
	quote.to_json
end