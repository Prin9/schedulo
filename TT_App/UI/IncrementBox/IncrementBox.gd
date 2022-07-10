extends HBoxContainer

export var _lower_limit:=0
export var _upper_imit:=23

var mouse:= false

signal value_changed(val, incr)

var currentVal:=0 setget newVal, getVal

func _ready():
	render()


func _input(event):
	if Input.is_action_just_pressed("scroll_up") and mouse:
		_on_Incr_pressed()
		get_tree().set_input_as_handled()
	elif Input.is_action_just_pressed("scroll_down") and mouse:
		_on_Decr_pressed()
		get_tree().set_input_as_handled()

func newVal(val):
	currentVal=val
	render()
	
func getVal():
	return currentVal

func _on_Incr_pressed():
	if currentVal>=_upper_imit:
		currentVal=_lower_limit
	else:
		currentVal+=1
	emit_signal("value_changed", currentVal, true)
	render()


func _on_Decr_pressed():
	if currentVal<=_lower_limit:
		currentVal=_upper_imit
	else:
		currentVal-=1
	emit_signal("value_changed", currentVal, false)
	render()

func render():
	$Label.text=str(currentVal)


func _on_ValIncr_mouse_entered():
	mouse = true


func _on_ValIncr_mouse_exited():
	mouse=false
