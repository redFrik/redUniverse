//discrete world - explosions
//with mouse controlling repulsive object location

(
var width= 640, height= 480, w, wgrav, world, n= 50,
rep, pixelSize= 4, wn= width/n, hn= height/n;

//--world
w= RedWindow("discrete world - explosions", Rect(128, 64, width, height)).front;
world= RedWorld3(RedVector2D[n, n], RedVector2D[0, 0.98], 3, 0.5);	//dim,grav,maxvel,damp

//--objects
rep= RedObject(nil, RedVector2D[width/2, 100], nil, nil, 0.5, pixelSize);
n.do{|x|
	n.do{|y|
		var loc= RedVector2D[0.gauss(2), 0.gauss(2)]+(n/2);
		RedObject(world, loc, RedVector2D[1.0.rand2, -2.0.rand], nil, 15, pixelSize);	//world,loc,vel,acc,mass,size
	};
};

//--loop
w.draw{
	Pen.smoothing_(false);
	Pen.strokeColor= Color.green;
	rep.loc= w.mouse/[wn, hn];
	Pen.strokeRect(Rect.aboutPoint(rep.loc.round.asPoint*[wn, hn], pixelSize, pixelSize));

	world.objects.do{|o|
		o.addForce(o.gravityForce(rep).neg);  //repel
		o.addForce(o.world.gravity);	//add gravity
		o.update;
		world.contain(o);	//keep within world borders

		//--render
		Pen.fillColor= Color.hsv(o.mass/25%1, 1, 1, (o.vel.mag*0.5).min(1));
		Pen.fillRect(Rect.aboutPoint(o.loc.round.asPoint*[wn, hn], pixelSize, pixelSize));
	};
};
w.play;
CmdPeriod.doOnce({w.close});
~world= world;
)


~world.objects.do{|o, i| o.loc= RedVector2D[i, ~world.objects.size.rand]};
~world.objects.do{|o, i| o.loc= RedVector2D[i, 5.rrand(7)]};
~world.objects.do{|o, i| o.loc= RedVector2D[i, 15.rrand(17)]; o.vel= RedVector2D[0, -1.0.rand]};
~world.objects.do{|o, i| o.loc= RedVector2D[i, 15.rrand(17)]; o.vel= RedVector2D[0, -1.0.rand]; o.mass= 5.rrand(25)};
