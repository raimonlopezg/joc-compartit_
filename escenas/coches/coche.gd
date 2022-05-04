 extends KinematicBody2D

var velocitat := 0 setget canvi_velocitat
var acceleracio := 0
var direccio := Vector2.RIGHT
var velocitat_max := 110
var velocitat_zero = 0
var num_voltes = -1
var velocitat_gir_min = 200
var angle = 0
#vel_min  velocitat_gir = 200
#vel_max  velocitat_gir = 80

func canvi_velocitat(nova_velocitat):
	velocitat = nova_velocitat
	$Label.text = str(velocitat)
	

func _physics_process(delta) :
	if Input.is_action_pressed("W") :
		acceleracio = 65
	else:
		acceleracio = -10
#		self.velocitat = lerp(velocitat, 0, 2/(velocitat + 1))
	if Input.is_action_pressed("S") :
		acceleracio = -5
	if not velocitat == 0 :
		if Input.is_action_pressed("A"):
			direccio = direccio.rotated(-deg2rad(-1.09*velocitat + velocitat_gir_min) * delta)
		if Input.is_action_pressed("D"):
			direccio = direccio.rotated(deg2rad(-1.09*velocitat + velocitat_gir_min) * delta)
	
	if velocitat > 90 and Input.is_action_just_released("W"):
		$"foc dreta".play("frena")
		$"foc esquerre".play("frena")
		
	if velocitat > 31 and Input.is_action_pressed("S"):
		$"fum1 darrera".play("frena")
		$"fum2 darrera".play("frena")
		$"fum3 davant".play("frena")
		$"fum4 davant".play("frena")

	self.velocitat += acceleracio * delta
	if velocitat > velocitat_max :
		self.velocitat = velocitat_max
	var moviment =  move_and_slide(velocitat * direccio)
	self.velocitat = moviment.length()
	if not moviment.is_equal_approx(Vector2.ZERO) :
		direccio = moviment.normalized()
	rotation = direccio.angle()
	
func _on_meta_body_entered(body):
	num_voltes = num_voltes + 1 
	print ("portes ",num_voltes," voltes acabades")
func _on_boxes_body_exited(body):
	velocitat_max = 110
func _on_boxes_body_entered(body):
	velocitat_max = 30

func _on_foc_esquerre_animation_finished():
	$"foc dreta".play('default')
	$"foc esquerre".play('default')

func _on_fum1_darrera_animation_finished():
	$"fum1 darrera".play("default")
	$"fum2 darrera".play("default")
	$"fum3 davant".play("default")
	$"fum4 davant".play("default")
