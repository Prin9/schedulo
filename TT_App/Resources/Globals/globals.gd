extends Node

var configFile=ConfigFile.new()
var confPath="res://configFile.ini"

var current_day:="Day_1"

var dayDict = {1:"Monday", 2:"Tuesday", 3:"Wednesday", 4:"Thursday", 5:"Friday", 6:"Saturday", 0:"Sunday"}


var g_dict = {
	"weekly":false,
	"log_date" : { "day" : "10" , "month" : "7" , "year" : "2022" , "current_day" : "Day_1"}
}

var dict={
	"weekly":0,
	"hours":0,
	"startStamps":0,
	"subjectCount":0,
	"subjects":0,
	"days":0,
	"Day_1":[],
	"Day_2":[],
	"Day_3":[],
	"Day_4":[],
	"Day_5":[],
	"Day_6":[],
	"Day_0":[]
}


func _ready():
	current_day = "Day_" + str(OS.get_date()["weekday"])
	configFile.load(confPath)
	load_config()
	
#	for i in dict.keys():
#		print(i," = ",dict[i])


func load_config():
	for i in dict.keys():
		dict[i]=configFile.get_value("parameters", i)
		
func save_config():
	for i in dict.keys():
		configFile.set_value("parameters", i, dict[i])
	configFile.save(confPath)

func pop_hour():
	dict["hours"]-=1
	dict["startStamps"].pop_back()
	for i in range(0,7):
		dict["Day_" + str(i)].pop_back()
	
func push_hour():
	dict["hours"]+=1
	dict["startStamps"].push_back("00:00-00:00")
	for i in range(0,7):
		dict["Day_" + str(i)].push_back(-1)


func del_sub_from_tt(index):
	for i in range(0,7):
		for j in range(dict["hours"]):
			if dict["Day_" + str(i)][j] == index:
				dict["Day_" + str(i)][j] =-1
	save_config()

func date_difference(date):
#	OS.get_datetime_from_unix_time()
	var diff = 0
	var day_count := 0
	var year_count = int(date["year"]) - int(g_dict["log_date"]["year"])
	var month_count := 0
	if year_count == 1:
		month_count = 12 - int(date["month"]) + int(g_dict["log_date"]["month"])
	elif year_count ==0:
		month_count = int(date["month"]) - int(g_dict["log_date"]["month"])

func get_days_in_month(m):
	if int(m) in [1,3,5,7,8,10,12]:
		return 31
	elif int(m) in [4,6,9,11]:
		return 30
	elif int(m)==2:
		return 28
