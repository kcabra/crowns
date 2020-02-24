extends Camera2D

var tween : Tween

func create_tween():
    var node = Tween.new()
    add_child(node)
    return node

func _ready():
    tween = create_tween()

func move_camera(to):
    if tween.is_active():
        tween.stop_all()
    tween.interpolate_property(self, "position",
            position, to, 1.0,
            Tween.TRANS_EXPO, Tween.EASE_OUT)
    tween.start()
