extends Label

var flag1 = false
var flag2 = false

func _process(delta):
	if get_parent().name == "Heres":
		if get_parent().DP <= 0 and !flag1:
			show()
			$no_points_timer.start()
			flag1 = true
	else:
		if get_parent().CP <= 0 and !flag2:
			show()
			$no_points_timer.start()
			flag2 = true

func _on_no_points_timer_timeout():
	hide()
	$no_points_timer.stop()
	flag1 = false
	flag2 = false
