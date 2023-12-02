extends Node2D

# Variables
var dragable: bool = false
var is_inside_dropable: bool = false
var body_ref
var offset: Vector2
var initialPos: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragable:
		
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			# Set the object position to mouse position
			global_position = get_global_mouse_position() 
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			# Create a tween for the animation
			var tween = get_tree().create_tween()
			# Snap the Object to staticBody if it touchs 
			if is_inside_dropable:
				
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			# Return the Object to its first position if not droped in staticBody with animation
			else:
				tween.tween_property(self, "position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body):
	# Change color of staticBody to darker if the body in it
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE,1)
		body_ref = body

func _on_area_2d_body_exited(body: StaticBody2D):
	# Change color of staticBody to lighter if the body not in it
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func _on_area_2d_mouse_entered():
	# When mouse touch the object make object bigger
	if not Global.is_dragging:
		dragable = true
		scale = Vector2(1.05,1.05)

func _on_area_2d_mouse_exited():
	# When mouse leave the object make object smaller
	if not Global.is_dragging:
		dragable = false
		scale = Vector2(1,1)
