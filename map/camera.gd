extends Camera2D

const SCREEN_HEIGHT = 32 * 11
const SCREEN_WIDTH = 32 * 16

var player : Node2D
var tween : Tween

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

func create_tween():
    var node = Tween.new()
    add_child(node)
    return node

func _ready():
    player = get_player()
    tween = create_tween()

func move_camera(dir : Vector2):
    var target = position + Vector2(
            dir.x * SCREEN_WIDTH,
            dir.y * SCREEN_HEIGHT)
    tween.interpolate_property(self, "position",
            position, target, 1.0,
            Tween.TRANS_EXPO, Tween.EASE_OUT)
    if tween.is_active():
        yield(tween, "tween_all_completed")
    tween.start()

func get_input_dir():
    var dir = Vector2.ZERO
    if Input.is_action_just_pressed("up"):
        dir.y -= 1
    elif Input.is_action_just_pressed("down"):
        dir.y += 1
    elif Input.is_action_just_pressed("left"):
        dir.x -= 1
    elif Input.is_action_just_pressed("right"):
        dir.x += 1
    return dir

func not_player_process():
    var dir = get_input_dir()
    if dir.length() > 0:
        move_camera(dir)

func _process(delta):
    if (!player):
        not_player_process()
