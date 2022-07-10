extends Position2D

signal screenStatic

onready var tween = $Pos/Tween
onready var pos = $Pos
onready var btn=$Pos/ToggleButton
onready var a = get_parent().get_node("Schedule_Display/Shader")




var leftPos:=0
var rightPos:=-50

func _ready():
	pass




func _on_ToggleButton_pressed():
	emit_signal("screenStatic")
	if !btn.pressed:
		tween.interpolate_property(pos, "position", Vector2(rightPos, 0),  Vector2(leftPos, 0) , 0.3, Tween.TRANS_CIRC)
		a.material.set_shader_param("scanline_alpha" , 0.9 )
	else:
		tween.interpolate_property(pos, "position",  Vector2(leftPos, 0),  Vector2(rightPos, 0), 0.3, Tween.TRANS_CIRC)
		a.set( "shader_param/scanline_alpha" , 0.9 )
		
	tween.start()
		
		
func _on_Tween_tween_completed(object, key):
	print(object)
	print(key)
