//linked pendulums

(
var width= 300, height= 300, w, wgrav, world, n= 5,
ploc;

//--world
w= RedWindow("linked pendulums", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.98];
world= RedWorld(RedVector2D[width, height], wgrav, 20, 0.0025);	//dim,grav,maxvel,damp

//--objects
n.do{
	RedPendulum(world, RedVector2D[width/2, height/3], nil, nil, 1, height/(n*2))	//world,loc,vel,acc,mass,size
		.angularVel_(0.2.rand2);
};

//--loop
w.draw{
	Pen.strokeColor= Color.white;
	Pen.width= 1;
	world.objects.do{|o, i|
		if(i>0, {
			o.loc= world.objects[i-1].pendulumLoc2D;
		});
	};
	world.objects.do{|o|
		o.addForceAngular2D(world.gravity);
		o.update;

		//--render
		ploc= o.pendulumLoc2D.asPoint;
		Pen.line(o.loc.asPoint, ploc);
		Pen.addOval(Rect.aboutPoint(ploc, o.size/5, o.size/5));
	};
	Pen.stroke;
	a= world.objects;
};
w.play;
CmdPeriod.doOnce({w.close});
)

/*
//manual control
a[0].addForceAngular2D(-10)
a[1].addForceAngular2D(10)
a[2].addForceAngular2D(-10)
a.last.addForceAngular2D(10)
*/