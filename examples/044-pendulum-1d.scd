//simple pendulum in a world with gravity

(
	var width= 300, height= 100, w, wgrav, world, n= 1,
		ploc;
	
	//--world
	w= GUI.redWindow.new("pendulum test 1d", Rect(128, 64, width, height)).front;
	wgrav= RedVector[0.5];
	world= RedWorld(RedVector[width], wgrav, 20, 0.02); //dim,grav,maxvel,damp
	
	//--objects
	{
		var loc= RedVector[width/2];
		var vel= RedVector[0];
		var accel= RedVector[0];
		RedPendulum(world, loc, vel, accel, 1.5, 50) //world,loc,vel,acc,mass,size
			.theta_(-1).angularVel_(-0.5);
	}.dup(n);
	
	//--loop
	w.draw{
		GUI.pen.strokeColor_(Color.white);
		GUI.pen.width_(1);
		world.objects.do{|o|
			o.addForceAngular1D(world.gravity);
			//o.addForce(world.gravity);
			o.update;
			//world.contain(o);
			a= o;
			
			//--render
			GUI.pen.translate(0, height/2);
			ploc= o.pendulumLoc1D.asPoint;
			GUI.pen.line(o.loc.asPoint, ploc);
			GUI.pen.stroke;
			GUI.pen.strokeOval(Rect.aboutPoint(ploc, o.size/5, o.size/5));
		}
	}.play;
)

/*
//manual control
a.addForceAngular1D(30)
a.addForceAngular1D(5)
a.addForceAngular1D(-5)
a.pendulumOffset1D
a.pendulumLoc1D
*/