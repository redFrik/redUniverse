//center of mass of two objects
//cyan (objB) has more mass initially

(
var width= 300, height= 300, w, wgrav, world;

//--world
w= RedWindow("barycenter - 2 objects", Rect(128, 64, width, height)).front;
wgrav= RedVector2D[0, 0.98];
world= RedWorld3(RedVector2D[width, height], wgrav, 5, 0);	//dim,grav,maxvel,damp

//--objects
~objA= RedObject(world, RedVector2D[width, height].rand, RedVector2D[0, 0], RedVector2D[0, 0], 5, 5);	//world,loc,vel,acc,mass,size
~objB= RedObject(world, RedVector2D[width, height].rand, RedVector2D[0, 0], RedVector2D[0, 0], 8, 8);	//world,loc,vel,acc,mass,size

//--loop
w.draw{
	var bary;
	~objA.addForce(~objA.gravityForce(~objB));
	~objB.addForce(~objB.gravityForce(~objA));
	//~objA.addForce(world.gravity);
	//~objB.addForce(world.gravity);
	~objA.update;
	~objB.update;
	world.contain(~objA);
	world.contain(~objB);
	bary= ~objA.barycenter(~objB);

	//--render
	Pen.strokeColor= Color.magenta;
	Pen.strokeOval(Rect.aboutRedObject2D(~objA));
	Pen.strokeColor= Color.cyan;
	Pen.strokeOval(Rect.aboutRedObject2D(~objB));
	Pen.fillColor= Color.white;
	Pen.fillRect(Rect.aboutRedVector2D(bary, 1));
};
w.play;
CmdPeriod.doOnce({w.close});
)


~objA.mass= 8; ~objA.size= 8;
~objA.mass= 5; ~objA.size= 5;
~objB.mass= 2; ~objB.size= 2;
~objB.mass= 12; ~objB.size= 12;

(
~objA.loc= RedVector2D[300.rand, 300.rand];
~objB.loc= RedVector2D[300.rand, 300.rand];
)
