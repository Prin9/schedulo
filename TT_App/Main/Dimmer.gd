extends ColorRect

var currentManu:="QuickEdit"



func _ready():
	pass

func enable_menu(menuName, add=[]):
	match menuName:
		"QuickEdit":
			print(add)
			$QuickEdit.day=add[0]
			$QuickEdit.hour=add[1]
		"PeriodSlotEdit":
			$PeriodSlotEdit.prd=add[0]
			$PeriodSlotEdit.timeSlot=add[1]
	if currentManu!=menuName:
		get_node(currentManu).closeDown()
	currentManu=menuName
	get_node(currentManu).startUp()


func startUp():
	show()

func closeDown():
	hide()
