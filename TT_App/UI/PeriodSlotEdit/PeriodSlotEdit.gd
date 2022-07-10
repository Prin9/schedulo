extends MarginContainer


signal changePrdSlot(currPrd, out, t_slot)


var prd:=1
var timeSlot:="8:00-9:10"


onready var startHr=$MarginContainer/VBoxContainer/PeriodTimeSlot/start_hr
onready var startMin=$MarginContainer/VBoxContainer/PeriodTimeSlot/start_min
onready var endHr=$MarginContainer/VBoxContainer/PeriodTimeSlot/end_hr
onready var endMin=$MarginContainer/VBoxContainer/PeriodTimeSlot/end_min


func _ready():
	closeDown()




func startUp():
	$MarginContainer/VBoxContainer/PeriodNo.text = "Period - " + str(prd)
	startHr.currentVal = int(timeSlot.split('-')[0].split(':')[0])
	startMin.currentVal = int(timeSlot.split('-')[0].split(':')[1])
	endHr.currentVal = int(timeSlot.split('-')[1].split(':')[0])
	endMin.currentVal = int(timeSlot.split('-')[1].split(':')[1])
	show()


func closeDown():
	get_parent().closeDown()
	hide()


func _on_Save_pressed():
#	print(Globals.dict["startStamps"][int(prd)])
	Globals.dict["startStamps"][prd-1] = str(startMin.currentVal) + ":" +str(endHr.currentVal) + "-" + str(endHr.currentVal) + ":" +str(startHr.currentVal)
	Globals.save_config()
#	get_parent().get_parent().render("TT_Display")
	closeDown()
	timeSlot=""
	
	if startHr.currentVal<10:
		print("startHr.currentVal : ", startHr.currentVal)
		timeSlot+="0"
		print("Added zero : ",timeSlot)
	
	timeSlot+= str(startHr.currentVal) + ":"
	
	if startMin.currentVal<10:
		print("startMin.currentVal : ", startMin.currentVal)
		timeSlot+="0"
		print("Added zero : ",timeSlot)
		
	timeSlot+= str(startMin.currentVal) + "-"
		
	if endHr.currentVal<10:
		print("endHr.currentVal : ", endHr.currentVal)
		timeSlot+="0"
		print("Added zero : ",timeSlot)
		
	timeSlot+=str(endHr.currentVal) + ":"
	
	if endMin.currentVal<10:
		print("endMin.currentVal : ", endMin.currentVal)
		timeSlot+="0"
		print("Added zero : ",timeSlot)
		
	timeSlot+=str(endMin.currentVal)
	
	print(timeSlot)

	
	emit_signal("changePrdSlot", prd, false, timeSlot)

