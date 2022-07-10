extends HBoxContainer

export (Array, String) var Buttons

var button=preload("res://UI/Top_Buttons/Array_button.tscn")

var aa = 0.1

func _ready():
	for i in Buttons:
		var a = button.instance()
		a.set_button(i)
		a.connect("ArrayButtonPressed", get_parent(), "render")
		add_child(a)
		a.modulate.r=aa
		aa+=0.05
