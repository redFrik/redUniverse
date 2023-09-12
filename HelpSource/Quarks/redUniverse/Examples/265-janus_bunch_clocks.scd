//two-phase coupled oscillators connected in a ring visualized as clocks
//from https://www.complexity-explorables.org/explorables/janus-bunch/

(
var width= 500, height= 500, w, world, n= 12;

//--world
w= RedWindow("janus bunch - clocks", Rect(0, 64, width, height)).front;
world= RedWorld3(RedVector2D[width, height], nil, inf, 0);	//dim,grav,maxvel,damp

//--init objects
n.do{|i|
	var x= (sin(i/n*2pi)*0.8).linlin(-1, 1, 0, width-1);
	var y= (cos(i/n*2pi)*0.8).linlin(-1, 1, 0, height-1);
	RedOscillator2(world, RedVector2D[x, y], nil, nil, 0, 1/n*width)
	.internalCoupling_(0.2/n).coupling_(0.3/n)
	.freq_(0.01.rand+0.01)
	.freq2_(0.1.rand+0.05)
	.phase_(2pi.rand)
	.phase2_(2pi.rand)
	.amp_(0.6)
	.amp2_(0.9)
};

//--loop
w.draw{

	world.objects.do{|o, i|
		o.couple(world.objects.wrapAt(i-1), world.objects.wrapAt(i+1));
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

		x= sin(o.phase)*o.size*o.amp;
		y= cos(o.phase)*o.size*o.amp;
		Pen.moveTo(p);
		Pen.lineTo(p+Point(x, y));

		x= sin(o.phase2)*o.size*o.amp2;
		y= cos(o.phase2)*o.size*o.amp2;
		Pen.moveTo(p);
		Pen.lineTo(p+Point(x, y));
	};
	Pen.fillStroke;
};
w.play;
CmdPeriod.doOnce({w.close});
~world= world;
)


~world.objects.do{|o| o.internalCoupling= 0.1; o.coupling= 0.2};  //tighter couplings

~world.objects.do{|o| o.internalCoupling= 0; o.coupling= 0};  //turn off interaction

~world.objects.do{|o| o.phase= 2pi.rand; o.phase2= 2pi.rand};  //randomize phases
~world.objects.do{|o| o.freq= 0.1.rand; o.freq2= 0.2.rand};  //randomize frequncies

~world.objects.do{|o| o.freq= 0.05; o.freq2= 0.1};  //same frequncies

~world.objects.do{|o| o.coupling= 0.04};  //apply some external coupling
~world.objects.do{|o| o.coupling= 0};  //turn off external coupling

~world.objects.do{|o| o.internalCoupling= 0.04};  //apply some internal coupling
~world.objects.do{|o| o.internalCoupling= 0};  //turn off internal coupling

~world.objects.do{|o| o.internalCoupling= 0.003; o.coupling= 0.03};  //tighter external

~world.objects.do{|o| o.freq= 0.01.gauss(0.001); o.freq2= 0.1.gauss(0.001)};  //freqs

~world.objects.do{|o| o.phase= 0; o.phase2= 0};  //sync phases

~world.objects.do{|o| if(0.1.coin, {o.phase= 2pi.rand; o.phase2= 2pi.rand})};  //randomize some phases (10%)
