extends Sprite

export var animator_path : NodePath = "./AnimationPlayer"
var animator : AnimationPlayer

func _ready():
    animator = get_node(animator_path)
    animator.assigned_animation = "walk_down"

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

func halt():
    if animator.is_playing():
        animator.stop()
