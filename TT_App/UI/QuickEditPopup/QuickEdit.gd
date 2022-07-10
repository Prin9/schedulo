extends MarginContainer


onready var dh_label=$ColorRect/VBoxContainer/Day_Hour
onready var subjectSelector=$ColorRect/VBoxContainer/MarginContainer/Subj_Select

var day:=1
var hour:=1

func _ready():
	
	dh_label.text="Day - " + str(day) + " | Hour - " + str(hour)
	

	
func startUp():
	#Adding Subjects
	subjectSelector.clear()
	subjectSelector.add_item("Blank")
	for i in Globals.dict["subjects"]:
		subjectSelector.add_item(i)
	
	dh_label.text = "Hour - "+ str(hour) +" | Day - " + str(day)
	
	print("Current Hour - ", hour," | Day - ", day)
	print("STARTED")
	var a = Globals.dict["Day_" + str(day) ][ hour-1 ]  
	if a!=-1:
		subjectSelector.selected=a+1 #Globals.dict["subjects"][a]
	else:
		subjectSelector.selected=0
	show()


func closeDown():
	get_parent().closeDown()
	hide()

func _on_Save_pressed():
	Globals.dict["Day_"+str(day)][hour-1] = subjectSelector.selected -1
	Globals.save_config()
	get_parent().get_parent().render("TT_Display")
	closeDown()


func _on_Cancel_pressed():
	closeDown()
	

