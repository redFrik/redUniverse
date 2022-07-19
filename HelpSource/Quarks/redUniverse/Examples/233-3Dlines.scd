//spinning lines

(
var width= 640, height= 480, w, wgrav, world,
n= 50, thetas= 0.dup(n), speeds= {|i| 1/100}.dup(n);
var lines;

//--world
w= RedWindow("3Dlines", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0];
world= RedWorld3(RedVector2D[width, height], wgrav, 20, 0.01);

//--objects
{|i|
	var loc= RedVector2D[i.linlin(0, n-1, 0, width), height*0.5];
	var vel= RedVector2D[0, 0];
	var acc= RedVector2D[0, 0];
	var obj= RedObject(world, loc, vel, acc, speeds[i]*100, 50);
}.dup(n);	//world,loc,vel,acc,mass,size

lines= {|i| Red3DLine(RedVector3D[0, i+1/n-0.5, 0], 1.75)}.dup(n);

//--loop
w.draw{
	Pen.strokeColor= Color.white;

	world.objects.do{|o, i|
		thetas[i]= thetas[i]+speeds[i];
		lines[i].rotation= RedVector3D[thetas[i], thetas[i]/2+1, thetas[i]/3+2];
		lines[i].update;

		o.addForce(world.gravity);
		o.update;
		world.contain(o);

		//--render
		lines[i].render(1.25, 250);  //1= exaggerate, 2= standard
		Pen.use{
			Pen.translate(o.loc[0], o.loc[1]);
			lines[i].drawOutlines;
		};
	};
};
w.animate= true;
CmdPeriod.doOnce({w.close});
)
