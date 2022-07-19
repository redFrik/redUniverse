//spinning boxes / cubes

(
var width= 640, height= 480, w, wgrav, world,
n= 20, thetas= 0.dup(n), speeds= {0.05.linrand*#[-1, 1].choose}.dup(n);
var boxes;

//--world
w= RedWindow("3Dboxes", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.01];
world= RedWorld3(RedVector2D[width, height], wgrav, 20, 0.01);

//--objects
{|i|
	var loc= RedVector2D[i.linlin(0, n-1, 0, width), height*0.5];
	var vel= RedVector2D[0, 0];
	var acc= RedVector2D[0, 0];
	var obj= RedObject(world, loc, vel, acc, speeds[i]*100, 50);
}.dup(n);	//world,loc,vel,acc,mass,size

boxes= {Red3DBox()}.dup(n);

//--loop
w.draw{
	Pen.strokeColor= Color.white;
	Pen.fillColor= Color.green(1, 0.25);

	world.objects.do{|o, i|
		thetas[i]= thetas[i]+speeds[i];
		boxes[i].rotation= RedVector3D[thetas[i], thetas[i], thetas[i]];
		boxes[i].update;

		o.addForce(world.gravity);
		o.update;
		world.contain(o);

		//--render
		boxes[i].render(2, 50);  //1= exaggerate, 2= standard
		Pen.use{
			Pen.translate(o.loc[0], o.loc[1]);
			boxes[i].drawSurfaces;
			boxes[i].drawOutlines;
		};
	};
};
w.animate= true;
CmdPeriod.doOnce({w.close});
)
