showconsole()
clearconsole()

mi_seteditmode("group")

rotor_poles = 8
stator_slots = 12
electrical_per_mech = rotor_poles/2
target_electrical_deg = 180
elec_step_deg = 2
step = target_electrical_deg / elec_step_deg
rotation = elec_step_deg / electrical_per_mech

mi_selectgroup(1)
mi_moverotate(0,0,360/rotor_poles/2 - 360/stator_slots/2, 4)

for n=0,step do
	rotor_angle = n*rotation
	rotor_axis_electrical_angle = rotor_angle * electrical_per_mech

	I_d = 0
	I_q = 20

	rr = rotor_axis_electrical_angle*3.141592654/180
	i_alpha = I_d * cos(rr) - I_q*sin(rr)
	i_beta =  I_d * sin(rr) + I_q*cos(rr)

	i_a = i_alpha
	i_b = -0.5*i_alpha + 0.8660*i_beta
	i_c = -0.5*i_alpha - 0.8660*i_beta	
	
	mi_modifycircprop("A",1,i_a)
	mi_modifycircprop("B",1,i_b)
	mi_modifycircprop("C",1,i_c)

	mi_analyze(1)
	mi_loadsolution()
	
	mo_resize(1200,1000)
	mo_zoom(-35,-35,35,35)
	
	mo_showcontourplot(-1)
	mo_showdensityplot(1,0,2,0,"bmag")
	
	mo_hidedensityplot()
	mo_hidecontourplot()
	
	mo_groupselectblock(1)
	torque=mo_blockintegral(22)
	print(rotor_angle,torque)
	
	mi_selectgroup(1)
	mi_moverotate(0,0,rotation)
end
mo_close()
mi_close()



showconsole()
clearconsole()
mi_seteditmode("group")

rotor_poles = 8
stator_slots = 12
electrical_per_mech = rotor_poles/2
step_mech = 2.5

mi_selectgroup(1)
mi_moverotate(0,0,360/rotor_poles/2 - 360/stator_slots/2, 4)

for rotor_angle = 0, 90, step_mech do
	rotor_axis_electrical_angle = rotor_angle * electrical_per_mech

	I_d = 0
	I_q = 20

	rr = rotor_axis_electrical_angle * 3.141592654 / 180
	i_alpha = I_d * cos(rr) - I_q * sin(rr)
	i_beta  = I_d * sin(rr) + I_q * cos(rr)

	i_a = i_alpha
	i_b = -0.5 * i_alpha + 0.8660 * i_beta
	i_c = -0.5 * i_alpha - 0.8660 * i_beta

	mi_modifycircprop("A",1,i_a)
	mi_modifycircprop("B",1,i_b)
	mi_modifycircprop("C",1,i_c)

	mi_analyze(1)
	mi_loadsolution()

	mo_resize(1200,1000)
	mo_zoom(-35,-35,35,35)

	mo_showcontourplot(-1)
	mo_showdensityplot(1,0,2,0,"bmag")
	mo_hidedensityplot()
	mo_hidecontourplot()

	mo_groupselectblock(1)
	torque = mo_blockintegral(22)
	print(rotor_angle, torque)

	mi_selectgroup(1)
	mi_moverotate(0,0,step_mech)
end

mo_close()
mi_close()
