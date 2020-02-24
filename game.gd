extends Node2D
#             tile size * tile per screen
const SCREEN_HEIGHT = 32 * 11
const SCREEN_WIDTH = 32 * 16

var player : Node2D
var camera : Camera2D
var map : TileMap

func get_player():
    var ar = get_tree().get_nodes_in_group("player")
    match ar.size():
        0:
            return null
        1:
            return ar[0]
        _:
            print_debug("Multiple players detected!!")
            return null

func _ready():
    map = $Map
    camera = $Camera
    player = get_player()
    
func get_screen(pos):
        var tile = map.world_to_map(pos)
        var screen : Vector2
        screen.x = floor(tile.x / 32)
        screen.y = floor(tile.y / 22)
        return screen

func _process(delta):
    if player:
        var player_screen = get_screen(player.position)
        var camera_screen = get_screen(camera.position)
        if player_screen != camera_screen:
            var camera_position = Vector2()
            camera_position.x = player_screen.x * SCREEN_WIDTH
            camera_position.y = player_screen.y * SCREEN_HEIGHT
            camera.move_camera(camera_position)
            
