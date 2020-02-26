extends AnimationPlayer

signal attack_finished

onready var sprite = $"../Sprite"
onready var weapon = $"../Weapon"
export(PackedScene) var sword_scene
onready var sw = get_parent().get_weapon().instance()

func _ready():
    assigned_animation = "walk_down"

func walk(dir):
    match(dir):
        Vector2.UP:
            play("walk_up")
            sprite.flip_h = false
        Vector2.LEFT:
            play("walk_side")
            sprite.flip_h = true
        Vector2.RIGHT:
            play("walk_side")
            sprite.flip_h = false
        Vector2.DOWN:
            play("walk_down")
            sprite.flip_h = false

func attack(dir):
    match dir:
        Vector2.UP:
            play("act_up")
            sprite.flip_h = false
        Vector2.LEFT:
            play("act_left")
            sprite.flip_h = true
        Vector2.RIGHT:
            play("act_right")
            sprite.flip_h = false
        Vector2.DOWN:
            play("act_down")
            sprite.flip_h = false
    
    weapon.add_child(sw)
    yield(self, "animation_finished")
    weapon.remove_child(sw)
    emit_signal("attack_finished")

func halt():
    if is_playing():
        stop()
