extends Node


var Window_Multi: int = 3
var screen_size = OS.get_screen_size()

var HighScore:int = 0
var CurrentScore:int = 0

var Settings = {
	"Audio": {
		"Master": 0
	}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_size = Vector2(256 * Window_Multi, 224 * Window_Multi)
	OS.set_window_position(screen_size*0.5 - OS.window_size*0.5)
	load_setting()
	load_highscore()



func save_highscore():
	var f = File.new()
	f.open("user://highscore.txt", f.WRITE)
	f.store_line(str(HighScore))
	f.close()


func load_highscore():
	var f = File.new()
	f.open("user://highscore.txt", f.READ)
	HighScore = int(f.get_as_text())
	f.close()


func save_setting():

	var c = ConfigFile.new()
	for section in Settings.keys():
		for key in Settings[section]:
			c.set_value(section, key, Settings[section][key])
	c.save("user://Settings.ini")


func load_setting():
	var f = File.new()
	if f.file_exists("user://Settings.ini"):
		var c = ConfigFile.new()
		var error = c.load("user://Settings.ini")
		if error != OK:
			print("Fail loading ssettings Error Code: %s" %error)

		for section in Settings.keys():
			for key in Settings[section]:
				Settings[section][key] = c.get_value(section, key, null)
