//spinning box / cube
//after Shiffman https://codingtrain.github.io/website-archive/CodingChallenges/112-3d-rendering.html

(
var width= 640, height= 480, w,
theta= 0, speed= 0.01, box;

w= RedWindow("3Dbox", Rect(128, 64, width, height)).front;
box= Red3DBox();

//--loop
w.draw{
	theta= theta+speed;
	box.rotation= RedVector3D[theta, theta, theta];
	box.update;

	//--render
	box.render(1, 100);  //1= exaggerate, 2= standard
	Pen.translate(width*0.5, height*0.5);
	Pen.strokeColor= Color.white;
	box.drawOutlines;
	Pen.fillColor= Color.white;
	box.draw;
};
w.animate= true;
CmdPeriod.doOnce({w.close});
)
