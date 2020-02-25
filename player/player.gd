extends KinematicBody2D

var input_array_node
var input_array_script = "res://player/input_array.gd"
export(NodePath) var sprite_path = "./Sprite"
var sprite_node : Sprite
export(NodePath) var sword_pos_path = "./sword_pos"
var sword_pos : Position2D
export(PackedScene) var sword_path

func _ready():
    input_array_node = create_input_array()
    sprite_node = get_node(sprite_path)
    
func create_input_array():
    var node = Node2D.new()
    node.set_script(load(input_array_script))
    add_child(node)
    return node
    
enum {ST_HALT, ST_WALK, ST_ATK}
var state = ST_WALK

var facing = Vector2.DOWN
export var speed = 300

func _physics_process(delta):
    match (state):
        ST_WALK:
            walk_process(delta)

func get_input_vec():
    if input_array_node:
        var iv = input_array_node.get_input_vec()
        if iv != facing && iv != Vector2.ZERO:
            facing = iv
        return iv
    else:
        return Vector2.ZERO


func get_sword_pos():
    if (!sword_pos):
        sword_pos = get_node(sword_pos_path)
    return sword_pos

func attack():
    state = ST_ATK
    sprite_node.attack(facing)
    var sw = sword_path.instance()
    get_sword_pos().add_child(sw)
    yield(sprite_node, "animation_finished")
    sw.queue_free()
    state = ST_WALK

func walk_process(delta):
    var input_vec = get_input_vec()
    
    if Input.is_action_just_pressed("attack"):
        attack()
        return
    
    if input_vec == Vector2.ZERO:
        sprite_node.halt()
    else:
        sprite_node.walk(input_vec)
    
    move_and_collide(input_vec * speed * delta)
