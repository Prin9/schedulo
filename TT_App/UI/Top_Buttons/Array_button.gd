extends HBoxContainer

signal ArrayButtonPressed(buttonText)

func _ready():
	pass

func set_button(b_text:String):
	$Button.text=b_text

func _on_Button_pressed():
	emit_signal("ArrayButtonPressed",$Button.text)
