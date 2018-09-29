extends Node

onready var CP = 10

func _on_Atom_pressed():
	CP -= 1

func _on_Molecule_pressed():
	CP -= 3

func _on_Compound_pressed():
	CP -= 5

func _on_Cell_pressed():
	CP -= 1

func _on_Tissue_pressed():
	CP -= 3

func _on_Organ_pressed():
	CP -= 5

func _on_Person_pressed():
	CP -= 1

func _on_Crowd_pressed():
	CP -= 3

func _on_Building_pressed():
	CP -= 5

func _on_Village_pressed():
	CP -= 1

func _on_City_pressed():
	CP -= 3

func _on_Country_pressed():
	CP -= 5

func _on_Planet_pressed():
	CP -= 1

func _on_System_pressed():
	CP -= 3

func _on_Galaxy_pressed():
	CP -= 5
