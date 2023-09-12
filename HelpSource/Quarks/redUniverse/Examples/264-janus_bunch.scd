//two-phase coupled oscillators connected in a ring
//from https://www.complexity-explorables.org/explorables/janus-bunch/


(
var width= 500, height= 500, w, world, n= 20;

//--world
w= RedWindow("janus bunch", Rect(0, 64, width, height)).front;
world= RedWorld3(RedVector2D[width, height], nil, inf, 0);	//dim,grav,maxvel,damp

//--init objects
n.do{|i|
	RedOscillator2(world, RedVector2D[width.rand, height.rand], nil, nil, 0, 10)
	.internalCoupling_(0.4/n)
	.coupling_(0.6/n)
	.freq_(0.01.rand+0.01)
	.freq2_(0.02.rand+0.05)
	.phase_(2pi.rand)
	.phase2_(2pi.rand)
	.amp_(0.85)
};

~showLinks= false;

//--loop
w.draw{
	Pen.strokeColor= Color.grey(0.5, 0.5);

	world.objects.do{|o, i|
		o.couple(world.objects.wrapAt(i-1), world.objects.wrapAt(i+1));
	};
	world.objects.do{|o|
		o.update;
		o.loc[0]= (o.phase.cos+o.phase2.cos)*o.amp/4+0.5*width;
		o.loc[1]= (o.phase.sin+o.phase2.sin)*o.amp/4+0.5*height;
		o.size= (o.delta-o.delta2).abs*40+4;
	};

	//--render
	world.objects.do{|o, i|

		Pen.fillColor= Color.grey(((o.delta+o.delta2).abs*5+0.25).min(1));
		Pen.fillOval(Rect.aboutRedObject2D(o));

		if(~showLinks, {
			Pen.moveTo(world.objects.wrapAt(i-1).loc.asPoint);
			Pen.lineTo(o.loc.asPoint);
			Pen.lineTo(world.objects.wrapAt(i+1).loc.asPoint);
			Pen.stroke;
		});
	};
};
w.play;
CmdPeriod.doOnce({w.close});
~world= world;
)


~showLinks= true;
~showLinks= false;


~world.objects.do{|o| o.internalCoupling= 0};  //turn off internal
~world.objects.do{|o| o.coupling= 0};  //turn off external coupling

~world.objects.do{|o| o.coupling= 0.05};  //some external
~world.objects.do{|o| o.internalCoupling= 0.01};  //some internal

~world.objects.do{|o| o.phase= 2pi.rand; o.phase2= 2pi.rand};  //randomize phases
~world.objects.do{|o, i| if(0.1.coin, {o.phase= 2pi.rand; o.phase2= 2pi.rand})};  //randomize some phases (10%)

~world.objects.do{|o| o.freq= 0.1.rand; o.freq2= 0.1.rand};  //randomize frequencies
~world.objects.do{|o| o.freq= 0.05; o.freq2= 0.1.rand2};
~world.objects.do{|o| o.freq= 0.1.rand2; o.freq2= 0.05};

~world.objects.do{|o| o.internalCoupling= 0.05};  //increase internal coupling
~world.objects.do{|o| o.coupling= 0.2};  //increase external coupling

~world.objects.do{|o| o.phase= 0; o.phase2= 0};  //sync phases

~world.objects.do{|o| o.freq= -0.05; o.freq2= 0.03};  //fixed frequencies

~world.objects.do{|o, i| o.phase= i/~world.objects.size*2pi};
~world.objects.do{|o, i| o.phase2= i/~world.objects.size*2pi};
~world.objects.do{|o, i| var t= i/~world.objects.size*2pi; o.phase= t; o.phase2= t};
~world.objects.do{|o| o.freq= -0.05.gauss(0.01); o.freq2= 0.03.gauss(0.01)};
~world.objects.do{|o| o.coupling= 0.005};  //relax external coupling
~world.objects.do{|o| o.internalCoupling= 0.04};
~world.objects.do{|o| o.freq= -0.02; o.freq2= 0.05};
~world.objects.do{|o| o.coupling= 0.05};  //increase external coupling
