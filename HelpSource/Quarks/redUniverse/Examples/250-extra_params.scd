//attaching extra parameters to particles (like rotation) and displaying them.
//example showing an alternative to subclassing

(
var width= 500, height= 500, w, world, n= 50,
particles,
attractor,
font= Font(Font.defaultMonoFace);

//--world
w= RedWindow("", Rect(128, 64, width, height)).front;
world= RedWorld3(RedVector2D[width, height], RedVector2D[1, 1], 100, 0.5);	//dim,grav,maxvel,damp

//--particles (an Array with Dictionaries)
particles= {|i|
	var loc= RedVector2D[width/2+0.0.gauss(width/10), height/2+0.0.gauss(height/10)];
	var mass= 0.5.rrand(1.0);
	(
		obj: RedParticle(world, loc, nil, nil, mass, mass*10).age_(500.rrand(5000)),
		name: "obj_"++i,
		rotation: i/n*2pi,  //initial
		color: nil,
	)
}.dup(n);

attractor= RedObject(nil, nil, RedVector2D[0, 0], RedVector2D[0, 0], 2, 60);

//--loop
w.draw{
	var theta= w.frame*0.01;

	particles.do{|dict|
		var o= dict.obj;
		var force= o.gravityForce(attractor);
		var nl= o.age/5000;  //lifetime normalized

		dict.color= Color.hsv(force.abs.sum.min(1), nl, (o.vel.abs.sum/world.maxVel*50).min(1));
		dict.rotation= dict.rotation+0.07;

		o.size= nl*15;
		o.addForce(force);
		o.update;
		world.contain(o);

		//--render
		Pen.fillColor= dict.color;
		Pen.fillOval(Rect.aboutRedObject2D(o));
		Pen.stringAtPoint(dict.name, o.loc.asPoint+Point(-10, 10), font.size_(o.size));
		Pen.strokeColor= Color.white;
		Pen.line(o.loc.asPoint, o.loc.asPoint+(Point(sin(dict.rotation), cos(dict.rotation))*o.size));
		Pen.stroke;
	};

	//--remove when lifetime reach 0
	particles= particles.reject{|dict|
		if(dict.obj.alive, {false}, {world.remove(o); true});
	};

	//--attractor (white circle)
	attractor.loc= RedVector2D[sin(theta)/8+0.5*width, cos(theta)/8+0.5*height];
	Pen.strokeColor= Color.white;
	Pen.strokeOval(Rect.aboutRedObject2D(attractor));

};
w.play;
CmdPeriod.doOnce({w.close});
)
