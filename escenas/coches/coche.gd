 extends KinematicBody2D

var velocitat := 0 setget canvi_velocitat
var acceleracio := 0
var direccio := Vector2.RIGHT
var velocitat_max := 120
var velocitat_zero = 0
var num_voltes = 0
var velocitat_gir_min = 200
var angle = 0
var timer = true
var checkpoint = 0
var temps_inicial = 1000000
var temps_final = 0
var millor_temps = 29.042

signal velocitat_canviada(nova_velocitat)

func canvi_velocitat(nova_velocitat):
	velocitat = nova_velocitat
	emit_signal('velocitat_canviada',nova_velocitat)
	
func _physics_process(delta) :
	$"Velocimetro/tempos/Label2".text = str(clamp((OS.get_ticks_msec() - temps_inicial)/1000.0, 0, 1000000))
	if Input.is_action_pressed("W") and timer == false:
		acceleracio = 75
	else:
		acceleracio = -10
		self.velocitat = lerp(velocitat, 0, 2/(velocitat + 1))
	if Input.is_action_pressed("S") and timer == false:
		acceleracio = -15
	if velocitat > 5 :
		if Input.is_action_pressed("A") and timer == false:
			direccio = direccio.rotated(-deg2rad(-1.09*velocitat + velocitat_gir_min) * delta)
		if Input.is_action_pressed("D") and timer == false:
			direccio = direccio.rotated(deg2rad(-1.09*velocitat + velocitat_gir_min) * delta)
	if velocitat == 0 and Input.is_action_pressed("S") and timer == false:
		acceleracio = -15
		
	if velocitat > 90 and Input.is_action_just_released("W"):
		$"foc dreta".play("frena")
		$"foc esquerre".play("frena")
	if velocitat > 40 and Input.is_action_pressed("S"):
		$"fum1 darrera".play("frena")
		$"fum2 darrera".play("frena")
		$"fum3 davant".play("frena")
		$"fum4 davant".play("frena")
	if velocitat > 65 and Input.is_action_pressed("W"):
		$"foc blau dreta".play("frena")
		$"foc blau esquerre".play("frena")

	self.velocitat += acceleracio * delta
	if velocitat > velocitat_max :
		self.velocitat = velocitat_max
	var moviment =  move_and_slide(velocitat * direccio)
	self.velocitat = moviment.length()
	if not moviment.is_equal_approx(Vector2.ZERO) :
		direccio = moviment.normalized()
	rotation = direccio.angle()
	

func _on_boxes_body_exited(body):
	velocitat_max = 120
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
func _on_foc_blau_dreta_animation_finished():
	$"foc blau esquerre".play("default")
	$"foc blau dreta".play("default")
func _on_checkpoint_body_entered(body):
	if body.name == 'Coche':
		checkpoint = 1
func _on_meta_body_entered(body):
	if body.name == 'Coche':
		if checkpoint == 1:
			num_voltes = num_voltes + 1
			temps_final = ((OS.get_ticks_msec() - temps_inicial)/1000.0)
			temps_inicial = OS.get_ticks_msec()
			$"Velocimetro/tempos/Label2".text = str(temps_inicial)
			$"Velocimetro/tempos/Label3".text = str(temps_final)
			if temps_final < millor_temps :
				$"Velocimetro/tempos/Label4".text = str(temps_final)
			else :
				$"Velocimetro/tempos/Label4".text = str(millor_temps)
		checkpoint = 0
		print ("portes ",num_voltes," voltes acabades")
func _on_Timer_timeout():
	timer = false
	temps_inicial = OS.get_ticks_msec()
	
