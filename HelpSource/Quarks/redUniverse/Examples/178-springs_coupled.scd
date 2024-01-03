//springs coupled

(
var width= 300, height= 300, w, world,
leftWall, rightWall, leftSpr, rightSpr,
list= List.new;

//--world
w= RedWindow("spring coupled", Rect(128, 64, width, height)).front;
world= RedWorld1(RedVector2D[width, height]);	//dim,grav,maxvel,damp

//--objects
~leftObj= RedObject(world, RedVector2D[width/3, height/2], RedVector2D[0, 0], RedVector2D[0, 0], 1, 5);
~rightObj= RedObject(world, RedVector2D[width/3*2, height/2], RedVector2D[0, 0], RedVector2D[0, 0], 1, 5);
leftWall= RedHiddenObject(world, RedVector2D[0, height/2]);
rightWall= RedHiddenObject(world, RedVector2D[width, height/2]);

leftSpr = RedSpring(~leftObj, leftWall, 0.06, 1);
rightSpr = RedSpring(~rightObj, rightWall, 0.07, 1);
~centerSpr= RedSpring(~leftObj, ~rightObj, 0.08, 0.99, 1);

//--loop
w.draw{

	leftSpr.update;
	rightSpr.update;
	~centerSpr.update2;

	~leftObj.update;
	~rightObj.update;

	if(list.size>height.div(2), {list.pop});
	list.addFirst([~leftObj.loc[0], ~rightObj.loc[0]]);  //store x positions

	//--render
	Pen.strokeColor= Color.red;
	Pen.line(~leftObj.loc.asPoint, leftWall.loc.asPoint);
	Pen.line(~rightObj.loc.asPoint, rightWall.loc.asPoint);
	Pen.stroke;
	Pen.strokeColor= Color.green;
	Pen.line(~leftObj.loc.asPoint, ~rightObj.loc.asPoint);
	Pen.stroke;
	Pen.fillColor= Color.white;
	Pen.fillOval(Rect.aboutRedObject2D(~leftObj));
	Pen.fillOval(Rect.aboutRedObject2D(~rightObj));
	list.do{|x, i|
		var y= height.div(2)-i;
		Pen.addRect(Rect(x[0], y, 1, 1));
		Pen.addRect(Rect(x[1], y, 1, 1));
	};
	Pen.fill;
};
w.play;
CmdPeriod.doOnce({w.close});
~world= world;
)


//move left object
~leftObj.loc= RedVector2D[10, 200];
//move right object
~rightObj.loc= RedVector2D[1000, 2000];

//sync
(
~leftObj.loc= RedVector2D[0, 150];
~rightObj.loc= RedVector2D[150, 150];
)

//out of phase
(
~leftObj.loc= RedVector2D[150, 150];
~rightObj.loc= RedVector2D[150, 150];
)

~centerSpr.damping= 0.93;
~centerSpr.damping= 1;
~centerSpr.stiffness= 0.1;
~centerSpr.stiffness= 1;
~centerSpr.length= 10;
~centerSpr.length= 100;
