//manual waves - no wave system

(
	var width= 600, height= 300, w, wgrav, world, n= 80,
		angularVel= 0.02, nWaves= 2, amps, dx, theta= 0;
	
	amps= {0.1.rrand(5)}.dup(nWaves);	//amplitudes
	dx= {							//delta x:s
		var p= 10.0.rrand(30);		//period - how many pixels before repeat
		2pi/p*(width/n);
	}.dup(nWaves);
	
	//--world
	w= GUI.redWindow.new("wave phase test2", Rect(128, 64, width, height)).front;
	w.background_(Color.white);
	wgrav= RedVector2D[0, 0.4];
	world= RedWorld(RedVector2D[width, height], wgrav, 20, 0.8); //dim,grav,maxvel,damp
	
	//--objects
	{|i|
		var loc= RedVector2D[width/n*i, height/2];
		RedObject(world, loc, nil, nil, 1.5, 10) //world,loc,vel,acc,mass,size
	}.dup(n);
	
	//--loop
	w.draw{
		theta= theta+angularVel;
		if(0.005.coin, {world.gravity= RedVector2D[0, -0.7.rrand(0.7)]; world.gravity.postln});
		nWaves.do{|i|
			var x= theta;
			world.objects.do{|o, j|
				o.addForce(RedVector[0, sin(x)*amps[i]]);
				x= x+dx[i];
			};
		};
		world.objects.do{|o, i| o.addForce(world.gravity); o.update; world.contain(o)};
		
		//--render
		GUI.pen.fillColor_(Color.blue(1, 0.5));
		GUI.pen.width_(3);
		world.objects.do{|o, i|
			GUI.pen.fillOval(Rect.aboutRedVector2D(o.loc, i.linexp(0, n, 1, n)+5));
		};
	}.play;
)