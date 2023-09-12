//Kuramoto model
//from from https://www.complexity-explorables.org/explorables/ride-my-kuramotocycle/

(
var width= 500, height= 500, w, world, n= 20;

//--world
w= RedWindow("phase coupled oscillators", Rect(0, 64, width, height)).front;
world= RedWorld3(RedVector2D[width, height], nil, inf, 0);	//dim,grav,maxvel,damp

//--init objects
n.do{
	RedOscillator(world, nil, nil, nil, 0, 10)
	.coupling_(0.01/n)
	.freq_(0.05.rand+0.01)
	.phase_(2pi.rand)
	.amp_(0.85)
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
	world.objects.do{|o, i|
		o.update;
		o.loc[0]= o.phase.sin*o.amp/2+0.5*width;
		o.loc[1]= o.phase.cos*o.amp/2+0.5*height;
		o.size= o.delta.abs*40+4;
	};

	//--render
	world.objects.do{|o|
		Pen.fillColor= Color.grey((o.delta.abs*10+0.25).min(1), 0.8);
		Pen.fillOval(Rect.aboutRedObject2D(o));
	};
};
w.play;
CmdPeriod.doOnce({w.close});
~world= world;
)


~world.objects.do{|o| o.coupling= 0.005};
~world.objects.do{|o| o.phase= 2pi.rand};  //random phases
~world.objects.do{|o| o.amp= 0.85+0.0.gauss(0.05)};  //vary amplitudes

~world.objects.do{|o| o.coupling= 0.001};  //relax coupling
~world.objects.do{|o| o.coupling= 0};  //turn off interaction
~world.objects.do{|o| o.coupling= 0.001};

~world.objects.do{|o| o.freq= 0.1.rand2};  //random frequencies
~world.objects.do{|o| o.freq= 0.04};  //all using a fixed frequency
~world.objects.do{|o| if(0.1.coin, {o.freq= 0.1.rand2})};  //randomize some frequencies (10%)
~world.objects.do{|o| o.phase= 0};  //sync all phases
~world.objects.do{|o| o.coupling= 0.01};
~world.objects.do{|o| o.freq= 0.01};
~world.objects.do{|o| o.freq= -0.01};
~world.objects.do{|o, i| o.phase= i/~world.objects.size*2pi};  //evenly spaced phases
~world.objects.do{|o| o.coupling= 0.001};
~world.objects.do{|o, i| o.freq= i+1/~world.objects.size*0.01};
~world.objects.do{|o| o.coupling= 0.0002};

~world.objects.do{|o| o.amp= 0.85};
~world.objects.do{|o, i| o.amp= i/~world.objects.size*0.8+0.1};

~world.objects.do{|o| o.coupling= 0.01.rand};  //random couplings
~world.objects.do{|o| o.freq= 0.1.rand2};  //random frequencies
