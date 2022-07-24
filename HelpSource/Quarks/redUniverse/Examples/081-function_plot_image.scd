//much improved plotting of functions using the Image class

(
var width= 200, height= 200, w, img,
x, y, dx, dy, widthCartPlane, heightCartPlane, rad, theta, func, cnt= 0;

w= RedWindow("func plot image", Rect(128, 64, width, height)).front;
img= Image(width, height);

widthCartPlane= 16;
heightCartPlane= 16;

//--loop
w.draw{
	cnt= cnt+0.05%width;
	dx= widthCartPlane/width;
	dy= heightCartPlane/height;
	x= widthCartPlane.neg/2;
	width.do{|i|
		y= heightCartPlane.neg/2;
		height.do{|j|
			rad= x.sumsqr(y).sqrt;
			theta= atan2(y, x);

			//func= cos(cnt+rad);
			//func= sin(theta);
			//func= sin(rad);
			//func= cos(theta);
			func= sin(cnt*rad.cos+(5*theta));
			y= y+dy;

			//--render
			img.setPixel(Image.colorToPixel(Color.grey(func+1)), i, j);
		};
		x= x+dx;
	};
	Pen.drawImage(Point(0, 0), img);
};
img.interpolation= \fast;
w.play;
CmdPeriod.doOnce({img.free; w.close});
)
