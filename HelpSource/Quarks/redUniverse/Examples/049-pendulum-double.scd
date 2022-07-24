//double pendulum

//https://www.myphysicslab.com/pendulum/double-pendulum-en.html

(
var width= 300, height= 300, w, wgrav, world,
ploc, angularAccel1, angularAccel2;

//--world
w= RedWindow("double pendulum", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.98];
world= RedWorld(RedVector2D[width, height], wgrav, 0.75, 0.01);	//dim,grav,maxvel,damp

//--objects
RedPendulum(world, RedVector2D[width/2, height/2], nil, nil, 5, 60)	//world,loc,vel,acc,mass,size
	.angularVel_(0.1);
RedPendulum(world, RedVector2D[width/2, height/2], nil, nil, 3, 60)	//world,loc,vel,acc,mass,size
	.angularVel_(-0.03);

//--math
angularAccel1= {|g, v1, v2, a1, a2, m1, m2, l1, l2|
	g.neg*(2*m1+m2)*sin(a1)-(m2*g*sin(a1-(2*a2)))-(2*sin(a1-a2)*m2*(v2.squared*l2+(v1.squared*l1*cos(a1-a2))))
	/
	(l1*(2*m1+m2-(m2*cos(2*a1-(2*a2)))));
};
angularAccel2= {|g, v1, v2, a1, a2, m1, m2, l1, l2|
	(2*sin(a1-a2)*((v1.squared*l1*(m1+m2))+(g*(m1+m2)*cos(a1))+(v2.squared*l2*m2*cos(a1-a2))))
	/
	(l2*(2*m1+m2-(m2*cos(2*a1-(2*a2)))));
};

//--loop
w.draw{
	var o0, o1, a0, a1;
	o0= world.objects[0];
	o1= world.objects[1];

	a0= angularAccel1.value(wgrav[1], o0.angularVel, o1.angularVel, o0.theta, o1.theta, o0.mass, o1.mass, o0.size, o1.size);
	a1= angularAccel2.value(wgrav[1], o0.angularVel, o1.angularVel, o0.theta, o1.theta, o0.mass, o1.mass, o0.size, o1.size);

	o0.angularVel= (o0.angularVel+a0).clip2(world.maxVel)*(1-world.damping);
	o1.angularVel= (o1.angularVel+a1).clip2(world.maxVel)*(1-world.damping);
	o0.theta= o0.theta+o0.angularVel;
	o1.theta= o1.theta+o1.angularVel;
	o1.loc= o0.pendulumLoc2D;

	Pen.strokeColor= Color.white;
	Pen.width= 1;
	world.objects.do{|o|

		//--render
		ploc= o.pendulumLoc2D.asPoint;
		Pen.line(o.loc.asPoint, ploc);
		Pen.addOval(Rect.aboutPoint(ploc, o.size/5, o.size/5));
	};
	Pen.stroke;
	o= world.objects;
};
w.play;
CmdPeriod.doOnce({w.close});
)

/*
//manual control
o[0].angularVel= 0.1;
o[1].angularVel= -0.1;
o[0].angularVel= -0.2;
o[1].angularVel= 0.2;
o[0].theta= pi*0.9;
o[1].angularVel= 0; o[0].angularVel= 0;
*/
