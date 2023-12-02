extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set The color of staticbody to half transparent when it is empty.
	modulate = Color(Color.MEDIUM_PURPLE,.7)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_dragging:
		visible = true
	else:
		visible = false
