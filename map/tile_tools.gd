tool
extends EditorScript

func _run():
    var ts : TileSet = load("res://map/tileset.tres")
    var nd = get_tile_names(ts)
    for i in nd.keys():
        nd[i] = change_name_suffix(nd[i])
        print(nd[i])
        ts.tile_set_name(i, nd[i])

func get_tile_names(ts : TileSet):
    var ids = ts.get_tiles_ids()
    var names = Dictionary()
    for id in ids:
        var name = ts.tile_get_name(id)
        names[id] = name
#        print(String(id)+": "+name)
    return names

func change_name_suffix(name : String):
    var digit
    for i in range(10):
        var d = String(i)
        if (name == "0_0"+d):
            return name.substr(0, 3)+String(int(d)+3)
    return name
