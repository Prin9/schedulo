extends Control


# ----------- Time Tracking --------------

var elapsed:=0


# ----------- Size Vars -------------

var current:="Floating_Button"
var deviceSize= OS.get_screen_size()
var glitch:=false
var pos_array_max:PoolVector2Array
var pos_array_min:PoolVector2Array
var test_arr:PoolVector2Array

# --------- Button Placement variables ------------
var bx = 460
var by = 35
var offset


# -------- Box Placement variables --------------

var box_x
var box_y
var box_offset

# ----------Button Work stuff ---------------

var menuShow:=true

onready var tween = $Tween





var curr_screen_size := Vector2.ZERO

var accept=false

onready var ShaderNode= $Schedule_Display/Shader
onready var RefRect = $Schedule_Display/ColorRect
onready var triggerBtn = $FloatingButton/Pos
onready var btn2=$Schedule_Display/BtnBox/THIS

#
#func _input(event):
#	if event is InputEventMouseMotion:
#		print(event.position)
#	if Input.is_action_just_pressed("ui_right"):
#		buildStatic()

func _ready():
	get_tree().get_root().set_transparent_background(true)
	print("EPOCH", OS.get_unix_time_from_datetime(OS.get_date()))
	
	OS.low_processor_usage_mode=true
	OS.keep_screen_on= true
#	deviceSize=Vector2(300, 800)      # Stress - testing for small device
	buildStatic(false)
	if deviceSize.x > 2* deviceSize.y/3 :     # if ScreenWidth > 2/3 of ScreenHeight, prioritize height
		curr_screen_size = Vector2( 2 * deviceSize.y / 3 , deviceSize.y )
		var a = deviceSize.y/1080
		offset = btn2.rect_size.y * a
		
		bx = curr_screen_size.x - (64 * a)
		by= 64 * a # ((btn2.rect_size.y + btn2.rect_position.y) * a)     
		
		box_offset =  RefRect.rect_size * a
		box_x = curr_screen_size.x - (RefRect.rect_size.x * a)
		box_y = curr_screen_size.y - ((RefRect.rect_size.y + RefRect.rect_global_position.y) * a) 
	else:                          # Else prioritize width
		curr_screen_size = Vector2(deviceSize.x , 3* deviceSize.x /2)
		var a = deviceSize.x/720
		offset =  btn2.rect_size.x * a
		bx = curr_screen_size.x - ( 64 * a)
		by = 64 * a

		box_offset =  RefRect.rect_size * a
		box_x = curr_screen_size.x - (RefRect.rect_size.x * a)
		box_y = curr_screen_size.y - ((RefRect.rect_size.y + RefRect.rect_global_position.y) * a) 
	
#	pos_array_max=[ 
#		Vector2( RefRect.rect_global_position.x , RefRect.rect_global_position.y ) , 
#		Vector2( RefRect.rect_global_position.x + RefRect.rect_size.x , RefRect.rect_global_position.y ) ,
#		Vector2( RefRect.rect_global_position.x + RefRect.rect_size.x , RefRect.rect_global_position.y + triggerBtn.global_position.y - 32 ) ,
#		Vector2( RefRect.rect_global_position.x + RefRect.rect_size.x + 32 , RefRect.rect_global_position.y + triggerBtn.global_position.y - 32 ) , #Corner Point
#		Vector2( RefRect.rect_global_position.x + RefRect.rect_size.x + 32 , RefRect.rect_global_position.y + triggerBtn.global_position.y + 32) ,
#		Vector2( RefRect.rect_global_position.x + RefRect.rect_size.x , RefRect.rect_global_position.y + triggerBtn.global_position.y + 32 ) ,
#		Vector2( RefRect.rect_global_position.x + RefRect.rect_size.x , RefRect.rect_global_position.y + RefRect.rect_size.y ) ,
#		Vector2( RefRect.rect_global_position.x , RefRect.rect_global_position.y + RefRect.rect_size.y )
#		]
#	pos_array_max=[ 
#		Vector2( RefRect.rect_position.x , RefRect.rect_global_position.y ) , 
#		Vector2( RefRect.rect_position.x + RefRect.rect_size.x , RefRect.rect_position.y ) ,
#		Vector2( RefRect.rect_position.x + RefRect.rect_size.x , RefRect.rect_position.y + triggerBtn.global_position.y - 32 ) ,
#		Vector2( RefRect.rect_position.x + RefRect.rect_size.x + 32 , RefRect.rect_position.y + triggerBtn.global_position.y - 32 ) , #Corner Point
#		Vector2( RefRect.rect_position.x + RefRect.rect_size.x + 32 , RefRect.rect_position.y + triggerBtn.global_position.y + 32) ,
#		Vector2( RefRect.rect_position.x + RefRect.rect_size.x , RefRect.rect_position.y + triggerBtn.global_position.y + 32 ) ,
#		Vector2( RefRect.rect_position.x + RefRect.rect_size.x , RefRect.rect_position.y + RefRect.rect_size.y ) ,
#		Vector2( RefRect.rect_position.x , RefRect.rect_position.y + RefRect.rect_size.y )
#		]
	pos_array_max = [
		Vector2( box_x , box_y),
		Vector2( box_x + box_offset.x , box_y),
		Vector2( box_x + box_offset.x , box_y + box_offset.y ),
		Vector2( box_x , box_y + box_offset.y )
	]

#	pos_array_min = [
#		Vector2( triggerBtn.get_parent().position.x -32 , triggerBtn.get_parent().position.y -32 ) ,
#		Vector2( triggerBtn.get_parent().position.x +32 , triggerBtn.get_parent().position.y -32 ) ,
#		Vector2( triggerBtn.get_parent().position.x +32 , triggerBtn.get_parent().position.y +32 ) ,
#		Vector2( triggerBtn.get_parent().position.x -32 , triggerBtn.get_parent().position.y +32 ) ,
#	]
	
#	pos_array_min = [
#		Vector2( triggerBtn.get_parent().global_position.x -32 , triggerBtn.get_parent().global_position.y -32 ) ,
#		Vector2( triggerBtn.get_parent().global_position.x +32 , triggerBtn.get_parent().global_position.y -32 ) ,
#		Vector2( triggerBtn.get_parent().global_position.x +32 , triggerBtn.get_parent().global_position.y +32 ) ,
#		Vector2( triggerBtn.get_parent().global_position.x -32 , triggerBtn.get_parent().global_position.y +32 ) ,
#	]
	
	print(" -> ",btn2.rect_position, btn2.rect_global_position , btn2.rect_size )
	
#	bx+= btn2.rect_size.x/2
	
	pos_array_min = [
		Vector2( bx + offset/2 , by ),
		Vector2(bx + offset, by ),
		Vector2(bx +offset , by + offset),
		Vector2( bx + offset/2 , by + offset)
	]
	

	$CollisionPolygon2D.polygon = pos_array_max
	

	OS.set_window_mouse_passthrough($CollisionPolygon2D.polygon)
	print($CollisionPolygon2D.polygon)
#	print(OS.get_window_mouse_passthrough())

	
	get_tree().get_root().set_transparent_background(true)
	OS.set_window_size(curr_screen_size)
	OS.window_position = Vector2(deviceSize.x , 0)
	

func _process(delta):
	
#	print(btn2.rect_size)
#	print(" -> ",btn2.rect_position, btn2.rect_global_position , btn2.rect_size )
#	print(get_global_transform().xform_inv(get_global_mouse_position()) == get_local_mouse_position())
#	print( get_local_mouse_position())
#	print(get_global_mouse_position())
#	print(get_global_mouse_position() - get_local_mouse_position())
#	print(btn2.get_parent().visible)
	pass

func render(submenu:="Floating_Button"):
	match submenu:
		"Floating_Button":
			pass
		_:
			pass

func change_menu(new:String):
	get_node(current).closeDown()
	get_node(new).startUp()
	current=new


func startUp():
	show()


func closeDown():
	hide()

func buildStatic( switchOn:= true ):
	if switchOn:
		$Timer.stop()
		ShaderNode.material.set_shader_param("BarrelPower", 1)
		ShaderNode.material.set_shader_param("color_bleeding", randf()*10)
		ShaderNode.material.set_shader_param("bleeding_range_x", randi()%20 -10)
		ShaderNode.material.set_shader_param("bleeding_range_y", randi()%20 -10)
		ShaderNode.material.set_shader_param("lines_distance", 1.5)
		ShaderNode.material.set_shader_param("scan_size" ,5)
		ShaderNode.material.set_shader_param("scanline_alpha" , 0 )
		ShaderNode.material.set_shader_param("lines_velocity" , 20)
		$Timer.start()
	else:
		ShaderNode.material.set_shader_param("BarrelPower", 1)
		ShaderNode.material.set_shader_param("color_bleeding", 1)
		ShaderNode.material.set_shader_param("bleeding_range_x", 1)
		ShaderNode.material.set_shader_param("bleeding_range_y", 0)
		ShaderNode.material.set_shader_param("lines_distance", 2)
		ShaderNode.material.set_shader_param("scan_size" , 5)
		ShaderNode.material.set_shader_param("scanline_alpha" , 0.95)
		ShaderNode.material.set_shader_param("lines_velocity" , 5)


func _on_Timer_timeout():
	buildStatic( false )
	if !menuShow:
		$Schedule_Display.closeDown()
		



func _on_GlitchTimer_timeout():
	glitch=!glitch
	if glitch:
		$GlitchTimer.start(0.05)
		ShaderNode.material.set_shader_param("color_bleeding", randf()*2)
		ShaderNode.material.set_shader_param("bleeding_range_x", randi()%10 -5)
		ShaderNode.material.set_shader_param("bleeding_range_y",  randi()%10 -5)
	else:
		$GlitchTimer.start(randf()*5)
		ShaderNode.material.set_shader_param("color_bleeding", 1)
		ShaderNode.material.set_shader_param("bleeding_range_x", 0)
		ShaderNode.material.set_shader_param("bleeding_range_y", 0)




func _on_THIS_toggled(button_pressed):
	if button_pressed:
		$Schedule_Display.startUp()
		tween.interpolate_property(btn2 , "rect_rotation" , 0 , 200, 0.3 ,Tween.TRANS_CIRC)
		tween.interpolate_property( $Schedule_Display , "rect_position", Vector2(32 , 0) , Vector2.ZERO , 0.3)
		tween.start()
		$CollisionPolygon2D.polygon = pos_array_max
	else:
		tween.interpolate_property(btn2 , "rect_rotation" , 200 , 0, 0.3 , Tween.TRANS_SINE)
		tween.interpolate_property( $Schedule_Display , "rect_position", Vector2(0,0) , Vector2(32 , 0), 0.3)
		tween.start()
		$CollisionPolygon2D.polygon = pos_array_min
	
	OS.set_window_mouse_passthrough($CollisionPolygon2D.polygon)
	buildStatic()
	menuShow = button_pressed


func _on_TimeCheck_timeout():
	var time = OS.get_time()
	print(time["hour"], ":",time["minute"], ":", time["second"])
	
	elapsed+=1
	if elapsed==10:  #Check for date
		var dt = OS.get_date()
		
