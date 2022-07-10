extends Button

var hour
var day

var parent

func _ready():
	parent=get_parent().get_parent().get_parent().get_parent()


func _on_EditBtn_pressed():
	parent.render("Dimmer", ["QuickEdit", day, hour])


func _on_ReminderBtn_pressed():
	pass # Replace with function body.
