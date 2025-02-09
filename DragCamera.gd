extends Camera3D

@export var drag_speed: float = 0.05

var dragging: bool = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
	elif event is InputEventMouseMotion and dragging:
		# Use the mouse's relative motion to translate the camera.
		# This example moves the camera in world XZ.
		# Adjust if your camera is rotated differently.
		var delta = event.relative
		# Update the camera's position:
		# Note: The negative sign on delta.x ensures that moving the mouse right
		# moves the camera to the right, etc.
		position.x -= delta.x * drag_speed
		position.z += delta.y * drag_speed
