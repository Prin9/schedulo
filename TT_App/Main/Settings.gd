extends VBoxContainer

var curr_subjects:=0

var curr_hours:=0

onready var dimmer=get_parent().get_node("Dimmer")

# General Setting Variables
onready var subjectCount=$"General Settings/VBoxContainer/ScrollContainer/SettingContainer/Subjects/HBoxContainer/SubjectCount"
onready var subjectInput=$"General Settings/VBoxContainer/ScrollContainer/SettingContainer/Subjects/SubjectInputs"
onready var hourCount=$"General Settings/VBoxContainer/ScrollContainer/SettingContainer/Hours/HBoxContainer/HourCount"
onready var saveButtonGeneral=$"General Settings/VBoxContainer/HBoxContainer/General_Save"
onready var prdSlotDisplay=preload("res://UI/PeriodSlot/PeriodSlotDisplay.tscn")
onready var PeriodList=$"General Settings/VBoxContainer/ScrollContainer/SettingContainer/Hours/PeriodList"



# Schedule Settings variables





func _ready():
#	startUp()
	closeDown()
	
	
func startUp():
	show()
	render("General")

func closeDown():
	hide()
	
	

func render(submenu:String, additional=[]):
	match submenu:
		"General":
			get_node("General Settings").show()
			print("2 ",Globals.dict["subjects"])
			subjectCount.currentVal=Globals.dict["subjectCount"]
			_on_SubjectCount_value_changed( subjectCount.currentVal , true , true)
			var a = 0
			for i in subjectInput.get_children():
				i.text = Globals.dict["subjects"][a]
				a+=1
				
			hourCount.currentVal=Globals.dict["hours"]
			_on_HourCount_value_changed(hourCount.currentVal , true, true)

			a = 0
			for i in PeriodList.get_children():
				i.timeSlot.text = Globals.dict["startStamps"][a]
				a+=1
			
			a=0
			for i in $"General Settings/VBoxContainer/ScrollContainer/SettingContainer/Days/Days_Toggle".get_children():
				i.pressed = Globals.dict["days"]["Day_"+ str(a)]
				a+=1
			
			
			saveButtonGeneral.disabled=true
			print("3 ",Globals.dict["subjects"])
		"Schedule":
			get_node("General Settings").hide()
			
		"Dimmer" :
			
			dimmer.startUp()
			match additional[0]:
				"QuickEdit":
					dimmer.enable_menu( additional[0] , [ additional[1], additional[2] ] )
				
				"PeriodSlotEdit":
					dimmer.enable_menu( additional[0] ,[ additional[1], additional[2]] )


############  GENERAL MENU     ###########


func _on_SubjectCount_value_changed(val, incr, init = false):
	if incr:
		for _i in range(val-curr_subjects):
			var line=LineEdit.new()
			line.expand_to_text_length = true
			line.clear_button_enabled = true
			line.focus_mode = Control.FOCUS_CLICK
			line.text = "Subject"
			if !init:
				Globals.dict["subjects"].push_back("Subject")
				Globals.dict["subjectCount"]+=1
			line.connect("text_changed", self, "_change_made")
			subjectInput.add_child(line)
		curr_subjects=val
	else:
		for _i in range(curr_subjects-val):
			subjectInput.get_child(subjectInput.get_child_count()-1).queue_free()
			if !init:
				Globals.dict["subjects"].pop_back()
				Globals.dict["subjectCount"]-=1
				Globals.del_sub_from_tt(Globals.dict["subjectCount"])
				
		curr_subjects=val


func _change_made(new_text=""):       #Enable Save Button
	saveButtonGeneral.disabled=false



func _on_General_Save_pressed():
	var subArr=[]
	
	
	# --------------- Saving Subjects -----------------
	
	for i in subjectInput.get_children():
		subArr.append(i.text)
	Globals.dict["subjects"]=subArr
	Globals.dict["subjectCount"]=curr_subjects
	
	print("1 ",Globals.dict["subjects"])
	
	subArr=[]
	
	#-------------- Saving Periods -------------------
	
	for i in PeriodList.get_children():
		subArr.append(i.timeSlot.text)
		
	Globals.dict["startStamps"]=subArr
	Globals.dict["hours"]=curr_hours
	
	
	#------------- Saving workdays ---------------------
	

	
	
	
	#------------- Save & Refresh --------------------
	print("1.1 ",Globals.dict["subjects"])
	Globals.save_config()
	print("1.2 ",Globals.dict["subjects"])
	render("General")
	print("1.3 ",Globals.dict["subjects"])


func _on_General_Cancel_pressed():
	get_parent().render("TT_Display")
	closeDown()


func _on_Monday_toggled(button_pressed):
	_change_made()
	Globals.dict["days"]["Day_1"] = button_pressed
	


func _on_Tuesday_toggled(button_pressed):
	_change_made()
	Globals.dict["days"]["Day_2"] = button_pressed


func _on_Wednesday_toggled(button_pressed):
	_change_made()
	Globals.dict["days"]["Day_3"] = button_pressed


func _on_Thursday_toggled(button_pressed):
	_change_made()
	Globals.dict["days"]["Day_4"] = button_pressed


func _on_Friday_toggled(button_pressed):
	_change_made()
	Globals.dict["days"]["Day_5"] = button_pressed


func _on_Saturday_toggled(button_pressed):
	_change_made()
	Globals.dict["days"]["Day_6"] = button_pressed


func _on_Sunday_toggled(button_pressed):
	_change_made()
	Globals.dict["days"]["Day_7"] = button_pressed





func _on_HourCount_value_changed(val, incr, init=false):
	if incr:
		_change_made()
		for i in range(val - curr_hours):
			var a = prdSlotDisplay.instance()
			PeriodList.add_child(a)
			if !init:
				Globals.push_hour()
			a.prd.text= str(curr_hours + i+1)
			a.connect("changePrdSlot",self,"_on_PeriodSlotEdit_changePrdSlot")
		curr_hours=val
		Globals.save_config()
			
	else:
		for _i in range(curr_hours - val):
			PeriodList.get_child(PeriodList.get_child_count()-1).queue_free()
			if !init:
				Globals.pop_hour()
		curr_hours=val
		Globals.save_config()


func _on_PeriodSlotEdit_changePrdSlot(currPrd, out, t_slot="00:00-00:00"):
	if out:
		render("Dimmer", ["PeriodSlotEdit" , currPrd, t_slot])
	else:
		PeriodList.get_child(currPrd-1).timeSlot.text = t_slot
		_change_made()
