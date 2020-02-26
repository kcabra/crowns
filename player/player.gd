extends KinematicBody2D

var input_array_script = "res://player/input_array.gd"
onready var input_array_node = create_input_array()
onready var animator = $AnimationPlayer

func create_input_array():
    var node = Node2D.new()
    node.set_script(load(input_array_script))
    add_child(node)
    return node

enum PlayerWeapons {KNIFE, SWORD}
export(PlayerWeapons) var weapon

func get_weapon():
    match weapon:
        PlayerWeapons.KNIFE:
            return load("res://player/weapons/knife.tscn")
        PlayerWeapons.SWORD:
            return load("res://player/weapons/sword.tscn")

var can_walk = true
export var speed = 300
var facing = Vector2.DOWN

func get_input_vec():
    if input_array_node:
        var iv = input_array_node.get_input_vec()
        if iv != facing && iv != Vector2.ZERO:
            facing = iv
        return iv
    else:
        return Vector2.ZERO

func walk(vec, delta):
    if vec.length() > 0:
        animator.walk(vec)
    else:
        animator.halt()
    move_and_collide(speed * vec * delta)

func attack():
    can_walk = false
    animator.attack(facing)
    yield(animator, "attack_finished")
    can_walk = true

func _physics_process(delta):
    if can_walk:
        var input_vec = get_input_vec()
        if Input.is_action_just_pressed("attack"):
            attack()
        else:
            walk(input_vec, delta)
        move_and_collide(input_vec * speed * delta)
