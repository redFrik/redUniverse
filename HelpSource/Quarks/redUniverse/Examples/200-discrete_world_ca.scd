//discrete world - 2d ca

(
var width= 640, height= 480, w, wgrav, world, n= 15,
wx= width/n, hy= height/n;

//--world
w= RedWindow("discrete world - 2d ca", Rect(128, 64, width, height)).front;
world= RedWorld3(RedVector[n, n]);	//dim,grav,maxvel,damp

//--objects
{|x|
	{|y|
		var loc= RedVector[x, y];
		RedAgent(world, loc).state_(0.25.coin.binaryValue);	//world,loc,vel,acc,mass,size
	}.dup(n);
}.dup(n);

//--loop
w.draw{
	var counts= world.objects.collect{|o|
		world.neighbours(o).sum{|oo| oo.state}
	};
	world.objects.do{|o, i|
		if(o.state==1, {
			Pen.addRect(Rect(o.loc[0]*wx, o.loc[1]*hy, wx, hy));
		});
		if(counts[i]==3, {
			o.state= 1;
		}, {
			if(counts[i]!=2, {
				o.state= 0;
			});
		});
	};

	Pen.smoothing_(false);
	Pen.strokeColor_(Color.white);
	Pen.stroke;
};
w.play;
CmdPeriod.doOnce({w.close});
~world= world;
)


~world.objects.do{|o| o.state= 0};  //clear

(
var glider= #[[2, 0], [0, 1], [2, 1], [1, 2], [2, 2]]+1;
~world.objects.do{|o|
	if(glider.any{|g| g[0]==o.loc[0] and:{g[1]==o.loc[1]}}, {o.state= 1});
};
)
