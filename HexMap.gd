extends Node3D

# Load the HexTile scene
const HexTileScene = preload("res://HexTile.tscn")

# Grid size (width and height in hex tiles)
@export var map_width: int = 10
@export var map_height: int = 10

# Hex tile size (radius of each hexagon)
@export var tile_radius: float = 1.0

# Converts axial (q, r) coordinates to world position for pointy-topped hexes
func axial_to_world(q: int, r: int) -> Vector3:
	var x = tile_radius * sqrt(3) * (q + r / 2.0)
	var z = tile_radius * 3/2.0 * r
	return Vector3(x, 0, z)  # Tiles are flat on Y-axis

func setup_environment():
	var env = Environment.new()
	env.ssao_enabled = true
	env.ssao_intensity = 1.5
	env.ssao_radius = 1.2
	
	var world_env = WorldEnvironment.new()
	world_env.environment = env
	add_child(world_env)

func setup_camera():
	var camera = Camera3D.new()
	camera.current = true
	camera.set_script(preload("res://DragCamera.gd"))

	var map_center = axial_to_world(map_width / 2, map_height / 2)
	camera.position = map_center + Vector3(0, 7, -5)
	#camera.look_at(map_center, Vector3.UP)
	camera.rotation_degrees = Vector3(-85, 0, 0)
	
	add_child(camera)


# Generates the hex map
func _ready() -> void:
	setup_camera()
	setup_environment()
	
	randomize()  # Ensures different results on each run

	for r in range(map_height):
		for q in range(map_width):
			var hex_tile = HexTileScene.instantiate()
		
			hex_tile.position = axial_to_world(q, r)

			# Randomize tile type and yields
			var food_yield = randi() % 3 + 1  # 1 to 3 food
			var production_yield = randi() % 2 + 1  # 1 to 2 production

			# Assign tile type based on yield (modify as needed)
			if food_yield >= 3:
				hex_tile.tile_type = "grassland"
			elif production_yield >= 2:
				hex_tile.tile_type = "hill"
				hex_tile.position += Vector3(0, 0.2, 0);
			else:
				hex_tile.tile_type = "desert"

			# Apply changes to material color
			hex_tile.update_tile_material()
			
			# Add tile to the map
			add_child(hex_tile)
