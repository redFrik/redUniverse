//spinning plane / rectangle

(
var width= 640, height= 480, w,
theta= 0, speed= 0.01, plane;

w= RedWindow("3Dplane", Rect(128, 64, width, height)).front;
plane= Red3DPlane(width: 0.5, height: 0.8);

//--loop
w.draw{
	theta= theta+speed;
	plane.rotation= RedVector3D[theta, theta/5, theta/12];
	plane.update;

	//--render
	plane.render(1, 300);  //1= exaggerate, 2= standard
	Pen.translate(width*0.5, height*0.5);
	Pen.strokeColor= Color.white;
	plane.drawOutlines;
	Pen.fillColor= Color.white;
	plane.draw(10);  //dotSize
};
w.animate= true;
CmdPeriod.doOnce({w.close});
)
