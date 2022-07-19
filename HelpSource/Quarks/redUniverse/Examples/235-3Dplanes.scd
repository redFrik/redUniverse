//spinning planes / rectangles

(
var width= 640, height= 480, w, wgrav, world,
n= 100, thetas= 0.dup(n), speeds= {|i| i+1/10000}.dup(n);
var planes;

//--world
w= RedWindow("3Dplanes", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.01];
world= RedWorld3(RedVector2D[width, height], wgrav, 20, 0.01);

//--objects
{|i|
	var loc= RedVector2D[i.linlin(0, n-1, 0, width), height*0.5];
	var vel= RedVector2D[0, 0];
	var acc= RedVector2D[0, 0];
	var obj= RedObject(world, loc, vel, acc, speeds[i]*5000, 50);
}.dup(n);	//world,loc,vel,acc,mass,size

planes= {|i| Red3DPlane(RedVector3D[0, i+1/n-0.5, 0])}.dup(n);

//--loop
w.draw{
	Pen.strokeColor= Color.grey(1, 0.5);
	Pen.translate(0, -50);

	world.objects.do{|o, i|
		thetas[i]= thetas[i]+speeds[i];
		planes[i].rotation= RedVector3D[thetas[i], thetas[i], thetas[i]];
		planes[i].update;

		o.addForce(world.gravity);
		o.update;
		world.contain(o);

		//--render
		planes[i].render(1.25, 250);  //1= exaggerate, 2= standard
		Pen.use{
			Pen.translate(o.loc[0], o.loc[1]);
			planes[i].drawOutlines;
		};
	};
};
w.animate= true;
CmdPeriod.doOnce({w.close});
)
