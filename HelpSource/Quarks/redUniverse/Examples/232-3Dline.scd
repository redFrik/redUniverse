//spinning line

(
var width= 640, height= 480, w,
theta= 0, speed= 0.01, line;

w= RedWindow("3Dline", Rect(128, 64, width, height)).front;
line= Red3DLine(length: 1.75);

//--loop
w.draw{

	theta= theta+speed;
	line.rotation= RedVector3D[theta, theta*3, theta*2];
	line.update;

	//--render
	line.render(1, 100);  //1= exaggerate, 2= standard
	Pen.translate(width*0.5, height*0.5);
	Pen.strokeColor= Color.white;
	line.drawOutlines;
	Pen.fillColor= Color.white;
	line.draw(10);  //dotSize
};
w.animate= true;
CmdPeriod.doOnce({w.close});
)
