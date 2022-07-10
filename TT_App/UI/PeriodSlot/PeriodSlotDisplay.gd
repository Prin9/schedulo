extends MarginContainer

signal changePrdSlot(currPrd, out, t_slot)

onready var prd=$PrdButton/HBoxContainer/HBoxContainer/Prd
onready var timeSlot=$PrdButton/HBoxContainer/TimeSlot

func _on_PrdButton_pressed():
	emit_signal("changePrdSlot",int(prd.text), true, timeSlot.text)
