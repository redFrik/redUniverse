//plot a Lorenz attractor

(
var width= 640, height= 480, depth= 100, w, world, obj;
var lorenz;

//--world
w= RedWindow("lorenz attractor", Rect(128, 64, width, height)).front;
w.userView.clearOnRefresh= false;
w.background= Color.black;

world= RedWorld(RedVector3D[width, height, depth], maxVel:1);

obj= RedObject(world, RedVector3D[1, 1, 1], size: 1);

~order= [0, 1, 2];
~sigma= 10;
~rho= 28;
~beta= 8/3;

lorenz= {|vec, s= 10, r= 28, b= (8/3)|
	RedVector3D[
		s*(vec[1]-vec[0]),
		vec[0]*(r-vec[2])-vec[1],
		vec[0]*vec[1]-(b*vec[2])
	]
};

//--loop
w.draw{
	obj.vel= lorenz.value(obj.loc, ~sigma, ~rho, ~beta);
	obj.update;

	//--render
	Pen.fillColor= Color.grey((obj.loc[2]/(depth*0.5)).clip(0, 1));
	Pen.fillOval(Rect.aboutRedVector3D(
		(obj.loc*15+[width*0.5, height*0.5, depth*0.5]).at(~order),
		obj.size*(obj.loc[2]/(depth*0.25)), *[width, height, depth].at(~order)
	));
};
w.animate= true;
CmdPeriod.doOnce({w.close});
~win= w;
)


~win.clear; ~order= [1, 0, 2];
~win.clear; ~order= [1, 2, 0];
~win.clear; ~order= [0, 1, 2];

~sigma= 3;
~sigma= 10;
~sigma= 30;
~win.clear;
~rho= 40
~rho= 100
~rho= 28
~win.clear;
~beta= 2.23
~beta= 8/3
