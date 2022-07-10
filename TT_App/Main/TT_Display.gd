extends VBoxContainer

onready var buttonContainer = $Schedule/ScrollContainer/VBoxContainer
onready var topDayText = $TopScroller/Label
onready var dimmer=get_parent().get_node("Dimmer")

var hourlyButton=preload("res://UI/ScheduleSlot/ScheduleSlotButton.tscn")



func _ready():
	var date=OS.get_datetime()
	print(date)

	topDayText.text = "Day Order - " + Globals.current_day.split('_')[1] + "\n" + str(date["day"]) + " - " + str(date["month"]) + " - " + str(date["year"]) + "\n" + "---- " + Globals.dayDict[int(Globals.current_day.split('_')[1])] +" ----"
	render("Schedule")


func startUp():
	show()
	render("Schedule")


func closeDown():
	hide()


func render(submenu:String, additional=[0]):
	match submenu:
		"Settings":
			get_parent().render(submenu)
			closeDown()
		"Schedule":
			for i in buttonContainer.get_children():
				i.queue_free()
			for i in range(Globals.dict["hours"]):
				var btn= hourlyButton.instance()
				if Globals.dict[Globals.current_day][i]!=-1:
					btn.get_node("BaseHbox/HBoxContainer/Subject").text = Globals.dict["subjects"][Globals.dict[Globals.current_day][i]]
				else:
					btn.get_node("BaseHbox/HBoxContainer/Subject").text = "   -    "
				
				btn.get_node("BaseHbox/HBoxContainer/Time").text = Globals.dict["startStamps"][i]
				
				btn.get_node("BaseHbox/HBoxContainer/Hour").text = str(i+1)
				
				btn.hour=i+1
				
				if additional[0]==0:
					btn.day = int(Globals.current_day.split('_')[1])
				else:
					btn.day=additional[0]
					
				buttonContainer.add_child(btn)
		
		"Dimmer" :
			
			dimmer.startUp()
			match additional[0]:
				"QuickEdit":
					print(additional[0] , [ additional[1], additional[2] ])
					dimmer.enable_menu( additional[0] , [ additional[1], additional[2] ] )
					


func _on_Scroll_Day_Right_pressed():
	pass # Replace with function body.


func _on_Scroll_Day_Left_pressed():
	pass # Replace with function body.
