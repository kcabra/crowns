extends Node2D

# FIXME: lacking controller implementation

var dirs = {
    "up": Vector2.UP,
    "down": Vector2.DOWN,
    "left": Vector2.LEFT,
    "right": Vector2.RIGHT
    }

var input_array = Array()
var input_vec setget ,_get_input_vec

func _get_input_vec():
    if input_array.empty():
        return Vector2.ZERO
    else:
        return dirs[input_array[0]]

func _input(event):
    if ( event is InputEventKey and
            event.is_pressed() and
            not event.is_echo()
        ):
        for dir in dirs:
            if event.is_action_pressed(dir):
                input_array.push_front(dir)
    elif ( event is InputEventKey and
            not event.is_pressed()
        ):
        for dir in dirs:
            if event.is_action_released(dir):
                var pos = input_array.find(dir)
                while (pos != -1):
                    input_array.remove(pos)
                    pos = input_array.find(dir)
