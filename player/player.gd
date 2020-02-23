extends KinematicBody2D

var input_array_node
var input_array_script = "res://player/input_array.gd"
export var sprite_path : NodePath = "./Sprite"
var sprite_node : Sprite

func _ready():
    input_array_node = create_input_array()
    sprite_node = get_node(sprite_path)
    
func create_input_array():
    var node = Node2D.new()
    node.set_script(load(input_array_script))
    add_child(node)
    return node
    
func get_input_vec():
    if input_array_node:
        return input_array_node.get_input_vec()
    else:
        return Vector2.ZERO

func _process(_delta):
    var input_vec = get_input_vec()
    if input_vec == Vector2.ZERO:
        sprite_node.halt()
    else:
        sprite_node.walk(input_vec)

export var speed = 300

func _physics_process(delta):
    var dir = get_input_vec()
    move_and_collide(dir * speed * delta)
