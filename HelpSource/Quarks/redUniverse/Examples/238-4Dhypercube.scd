//spinning hypercube / tesseract
//after Shiffman https://codingtrain.github.io/website-archive/CodingChallenges/113-hypercube.html


(
var width= 640, height= 480, w,
theta= 0, speed= 0.005, hypercube;

w= RedWindow("3Dhypercube", Rect(128, 64, width, height)).front;
hypercube= Red4DTesseract();

//--loop
w.draw{
	theta= theta+speed;
	hypercube.rotation= RedVector[theta, 0, 0, 0, 0, theta];
	hypercube.update;

	//--render
	hypercube.render(2, 500);  //1= exaggerate, 2= standard
	Pen.translate(width*0.5, height*0.5);
	Pen.fillColor= Color.white;
	hypercube.draw;
	Pen.strokeColor= Color.white;
	hypercube.drawOutlines;
};
w.animate= true;
CmdPeriod.doOnce({w.close});
)
