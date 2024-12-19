//center of mass of many objects

(
var width= 300, height= 300, w, wgrav, world, n= 3;

//--world
w= RedWindow("barycenter - many objects", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.98];
world= RedWorld3(RedVector2D[width, height], wgrav, 5, 0.1);	//dim,grav,maxvel,damp

//--objects
{
	var loc= RedVector2D[width, height].rand;
	var mass= 2**1.0.rand;
	RedObject(world, loc, 0, 0, mass, mass*4);	//world,loc,vel,acc,mass,size
}.dup(n);

//--loop
w.draw{
	var bary= RedVector2D[0, 0], totalMass= 0;

	world.objects.do{|o, i|
		totalMass= totalMass+o.mass;

		world.objects.do{|oo, j|
			if(i!=j, {
				o.addForce(o.gravityForce(oo));
			});
		};
		o.update;
		world.contain(o);

		//--render
		Pen.strokeColor= Color.blue;
		Pen.strokeOval(Rect.aboutRedObject2D(o));
	};

	world.objects.do{|o, i|
		bary= bary+(o.loc*o.mass);
	};

	bary= bary/totalMass;
	Pen.fillColor= Color.white;
	Pen.fillRect(Rect.aboutRedVector2D(bary, 1));
};
w.play;
CmdPeriod.doOnce({w.close});
)
