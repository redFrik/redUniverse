//spinning points

(
var width= 640, height= 480, w, wgrav, world,
n= 100, thetas= 0.dup(n), speeds= {|i| i+1/1000}.dup(n);
var points;

//--world
w= RedWindow("3Dpoints", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.01];
world= RedWorld3(RedVector2D[width, height], wgrav, 20, 0.01);

//--objects
{|i|
	var loc= RedVector2D[i.linlin(0, n-1, 0, width), height*0.5];
	var vel= RedVector2D[0, 0];
	var acc= RedVector2D[0, 0];
	var obj= RedObject(world, loc, vel, acc, speeds[i]*100, 50);
}.dup(n);	//world,loc,vel,acc,mass,size

points= {|i| Red3DPoint(RedVector3D[i+1/n-0.5, 0, 0])}.dup(n);

//--loop
w.draw{
	Pen.fillColor= Color.white;

	world.objects.do{|o, i|
		thetas[i]= thetas[i]+speeds[i];
		points[i].rotation= RedVector3D[thetas[i], thetas[i], thetas[i]];
		points[i].update;

		o.addForce(world.gravity);
		o.update;
		world.contain(o);

		//--render
		points[i].render(2, 150);  //1= exaggerate, 2= standard
		Pen.use{
			Pen.translate(o.loc[0], o.loc[1]);
			points[i].draw;
		};
	};
};
w.play;
CmdPeriod.doOnce({w.close});
)
