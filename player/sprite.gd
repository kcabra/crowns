extends Sprite

signal animation_finished
export var animator_path : NodePath = "./AnimationPlayer"
var animator : AnimationPlayer

func _on_animation_finished(name):
    emit_signal("animation_finished", name)

func _ready():
    animator = get_node(animator_path)
    animator.assigned_animation = "walk_down"
    animator.connect("animation_finished", self, "_on_animation_finished")

func walk(dir):
    match(dir):
        Vector2.UP:
            animator.play("walk_up")
            flip_h = false
        Vector2.LEFT:
            animator.play("walk_side")
            flip_h = true
        Vector2.RIGHT:
            animator.play("walk_side")
            flip_h = false
        Vector2.DOWN:
            animator.play("walk_down")
            flip_h = false

func attack(dir):
    match dir:
        Vector2.UP:
            animator.play("act_up")
            flip_h = false
        Vector2.LEFT: # FIXME: add flip_h track to anims
            animator.play("act_left")
            flip_h = true
        Vector2.RIGHT:
            animator.play("act_right")
            flip_h = false
        Vector2.DOWN:
            animator.play("act_down")
            flip_h = false
            

func halt():
    if animator.is_playing():
        animator.stop()
