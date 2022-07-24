//more function plotting using the Image class

(
var width= 640, height= 480, w, img,
x, y, resolutionX, resolutionY, rad, theta, func, cnt= 0,
speed, magnitude;

w= RedWindow("more func plot image", Rect(128, 64, width, height)).front;

magnitude= 10;
speed= -0.02;
resolutionX= 160;
resolutionY= 120;

img= Image(resolutionX, resolutionY);

//--loop
w.draw{
	cnt= cnt+speed%width;
	resolutionX.do{|i|
		x= i/resolutionX*2-1;
		resolutionY.do{|j|
			y= j/resolutionY*2-1;

			rad= x.sumsqr(y).sqrt*sin(cnt)*magnitude;
			theta= atan2(y, x);

			func= cos(rad);
			//func= cos(cnt*2+rad);
			//func= cos(cnt*2+rad+theta);
			//func= cos(cnt*2+rad+theta+sin(y*pi));
			//func= cos(cnt*2+rad+theta+sin(y*pi)+cos(x+cnt*pi));

			//--render
			img.setPixel(Image.colorToPixel(Color.hsv(func+1/2, 1, 0.75)), i, j);
		};
	};
	Pen.drawImage(Rect(0, 0, width, height), img);
};
img.interpolation= \smooth;
w.play;
CmdPeriod.doOnce({img.free; w.close});
)
