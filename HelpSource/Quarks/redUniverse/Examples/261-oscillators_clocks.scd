//Kuramoto model visualized as clocks

(
var width= 500, height= 500, w, world, n= 12;

//--world
w= RedWindow("phase coupled oscillators - clocks", Rect(0, 64, width, height)).front;
world= RedWorld3(RedVector2D[width, height], nil, inf, 0);	//dim,grav,maxvel,damp

//--init objects
n.do{|i|
	var x= (sin(i/n*2pi)*0.8).linlin(-1, 1, 0, width-1);
	var y= (cos(i/n*2pi)*0.8).linlin(-1, 1, 0, height-1);
	RedOscillator(world, RedVector2D[x, y], nil, nil, 0, 1/n*width)
	.coupling_(0.1/n)
	.freq_(0.1.rand)
	.phase_(2pi.rand)
};

//--loop
w.draw{

	world.objects.do{|o|
		world.objects.do{|p|
			if(p!=o, {
				o.couple(p);
			});
		};
	};
	world.objects.do{|o| o.update};

	//--render
	Pen.width= 5;
	Pen.strokeColor= Color.black;
	Pen.fillColor= Color.white;
	world.objects.do{|o|
		var p, x, y;

		p= o.loc.asPoint;
		Pen.addOval(Rect.aboutPoint(p, o.size, o.size));

		x= sin(o.phase)*o.size*0.9;
		y= cos(o.phase)*o.size*0.9;
		Pen.moveTo(p);
		Pen.lineTo(p+Point(x, y));
	};
	Pen.fillStroke;
};
w.play;
CmdPeriod.doOnce({w.close});
~world= world;
)

~world.objects.do{|o| o.freq= 0.2.rand};  //random frequencies
~world.objects.do{|o| o.coupling= 0.05};  //stronger coupling
~world.objects.do{|o| o.coupling= 0.01};  //relax coupling
~world.objects.do{|o| o.coupling= 0};  //turn off interaction
~world.objects.do{|o| o.coupling= 0.01};
~world.objects.do{|o| o.freq= 0.1.rand};  //random frequencies
~world.objects.do{|o| o.coupling= 0.005};
~world.objects.do{|o| o.phase= 0};  //sync phases
~world.objects.do{|o| o.freq= 0.2.rand2};  //random frequencies
