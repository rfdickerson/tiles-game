extends MeshInstance3D

# Yields for a Civilization type game
@export var food_yield: int = 1
@export var production_yield: int = 1
@export var tile_type: String = "grassland"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_tile_material()
	
func update_tile_material():
	var mat = material_override as StandardMaterial3D
	if mat and mat is ShaderMaterial:
		match tile_type:
			"grassland":
				mat.albedo_color = Color(0.2, 0.8, 0.2)
			"hill":
				mat.albedo_color = Color(0.5, 0.4, 0.2)
			"desert":
				mat.albedo_color = Color(0.9, 0.8, 0.5)
			_:
				mat.set_shader_parameter("tile_color", Color(0.7, 0.7, 0.7))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
