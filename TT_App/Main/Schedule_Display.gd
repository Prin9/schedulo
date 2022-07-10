extends MarginContainer


func _ready():
	for i in get_children():
		i.rect_clip_content=true


func startUp():
#	show()
	render()
	get_child(get_child_count()-2).show()
	get_child(0).show()

func closeDown():
#	hide()
	for i in range(get_child_count() -1):
		if get_child(i).has_method("closeDown"):
			get_child(i).closeDown()
		else:
			get_child(i).hide()
#	get_child(get_child_count()-1).hide()


func render(submenu:="TT_Display"):
	get_node(submenu).startUp()
