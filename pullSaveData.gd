
class_name save
# A function to save the player's score.
static func save_game(deaths: int):
	# 1. Define the path and open the file in write mode.
	#    This will create the file if it doesn't exist.
	var file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	
	# Check if the file opened successfully.
	if FileAccess.get_open_error() != OK:
		print("Error: Could not open file for writing.")
		return

	# 2. Write your data to the file.
	#    store_var() can save almost any Godot type (dictionaries, arrays, numbers, etc.).
	file.store_var(deaths)
	
	# 3. Close the file to save the changes. THIS IS VERY IMPORTANT!
	file.close()
	print("Game saved successfully!")
# A function to load the player's score.
static func load_game():
	var save_path = "user://savegame.dat"
	
	# First, check if the save file actually exists.
	if not FileAccess.file_exists(save_path):
		print("No save file found.")
		return 0 # Return a default value

	# 1. Open the file in read mode.
	var file = FileAccess.open(save_path, FileAccess.READ)

	if FileAccess.get_open_error() != OK:
		print("Error: Could not open file for reading.")
		return 0

	# 2. Read the data from the file.
	#    Make sure to read it in the same order you wrote it.
	var deaths = file.get_var()
	
	# 3. Close the file.
	file.close()
	print("Game loaded! Score: ", deaths)
	return deaths
func delete_save_file():
	var save_path = "user://savegame.dat"
	
	# 1. First, always check if the file exists.
	if FileAccess.file_exists(save_path):
		# 2. If it exists, call remove_absolute to delete it.
		var error = DirAccess.remove_absolute(save_path)
		
		# 3. Check if the deletion was successful.
		if error == OK:
			print("File deleted successfully!")
		else:
			print("An error occurred while trying to delete the file.")
	else:
		print("No save file found to delete.")
