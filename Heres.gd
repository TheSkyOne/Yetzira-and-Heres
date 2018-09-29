extends Node

onready var DP = 10

func _on_Atom_pressed():
	DP -= 1

func _on_Molecule_pressed():
	DP -= 3

func _on_Compound_pressed():
	DP -= 5

func _on_Cell_pressed():
	DP -= 1

func _on_Tissue_pressed():
	DP -= 3

func _on_Organ_pressed():
	DP -= 5

func _on_People_pressed():
	DP -= 1

func _on_Crowd_pressed():
	DP -= 3

func _on_Building_pressed():
	DP -= 5

func _on_Village_pressed():
	DP -= 1

func _on_City_pressed():
	DP -= 3

func _on_Country_pressed():
	DP -= 5

func _on_Planet_pressed():
	DP -= 1

func _on_System_pressed():
	DP -= 3

func _on_Galaxy_pressed():
	DP -= 5