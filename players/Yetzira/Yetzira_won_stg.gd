extends Label


func start_timer():
	show()
	$Y_won_timer.start()


func _on_Y_won_timer_timeout():
	hide()
	$Y_won_timer.stop()
	

