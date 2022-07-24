//spinning point

(
var width= 640, height= 480, w,
theta= 0, speed= 0.01, point;

w= RedWindow("3Dpoint", Rect(128, 64, width, height)).front;
point= Red3DPoint(RedVector3D[0, 0, 0.5]);

//--loop
w.draw{
	theta= theta+speed;
	point.rotation= RedVector3D[theta, theta*2, theta*3];
	point.update;

	//--render
	point.render(1, 300);  //1= exaggerate, 2= standard
	Pen.translate(width*0.5, height*0.5);
	Pen.fillColor= Color.white;
	point.draw(12);  //dotSize
};
w.play;
CmdPeriod.doOnce({w.close});
)
