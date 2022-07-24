//spinning hypercubes / tesseracts


(
var width= 640, height= 480, w, wgrav, world,
n= 15, thetas= 0.dup(n), speeds= {|i| i+1/1000}.dup(n);
var hypercubes;

//--world
w= RedWindow("3Dhypercubes", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.01];
world= RedWorld3(RedVector2D[width, height], wgrav, 20, 0.01);

//--objects
{|i|
	var loc= RedVector2D[i.linlin(0, n-1, 0, width), height*0.5];
	var vel= RedVector2D[0, 0];
	var acc= RedVector2D[0, 0];
	var obj= RedObject(world, loc, vel, acc, speeds[i]*5000, 50);
}.dup(n);	//world,loc,vel,acc,mass,size

hypercubes= {|i| Red4DTesseract()}.dup(n);

//--loop
w.draw{
	Pen.strokeColor= Color.white;
	Pen.fillColor= Color.green(1, 0.25);

	world.objects.do{|o, i|
		thetas[i]= thetas[i]+speeds[i];
		hypercubes[i].rotation= RedVector.newFrom(thetas[i]!6);
		hypercubes[i].update;

		o.addForce(world.gravity);
		o.update;
		world.contain(o);

		//--render
		hypercubes[i].render(2, 150);  //1= exaggerate, 2= standard
		Pen.use{
			Pen.translate(o.loc[0], o.loc[1]);
			hypercubes[i].drawOutlines;
			hypercubes[i].drawSurfaces;
		};
	};
};
w.play;
CmdPeriod.doOnce({w.close});
)
