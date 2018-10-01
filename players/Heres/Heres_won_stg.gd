extends Label

func start_timer():
	show()
	$H_won_timer.start()


func _on_H_won_timer_timeout():
	hide()
	$H_won_timer.stop()



