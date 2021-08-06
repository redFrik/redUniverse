// this file is part of redUniverse /redFrik

RedMandelbrot {
	var <>width, <>height, <>thresh, <>maxIterations, <>colorFunc;
	*new {|width= 320, height= 240, thresh= 1, maxIterations= 500, colorFunc|
		^super.newCopyArgs(width, height, thresh, maxIterations, colorFunc);
	}
	at {|x, y, zoom|
		var x0= x.linlin(0, width-1, zoom.left, zoom.right);
		var y0= y.linlin(0, height-1, zoom.top, zoom.bottom);
		var x1= 0;
		var y1= 0;
		var x2, y2;
		var iterations= 0;
		while({(x2= x1*x1)+(y2= y1*y1)<=4 and:{iterations<maxIterations}}, {
			y1= 2*x1*y1+y0;
			x1= x2-y2+x0;
			iterations= iterations+1;
		});
		^iterations;
	}
	plot {|zoom, bounds, background, interpolation= \smooth|
		var z= zoom ?? {Rect(-2.5, -1, 3.5, 2)};
		var b= bounds ?? {Rect(100, 200, width, height)};
		var win= Window(this.class.name, b);
		var img= Image.color(width, height, background ?? {Color.black});
		img.interpolation= interpolation;
		colorFunc= colorFunc ? {|iterations, maxIterations|
			var val= iterations/maxIterations**0.5;
			Color.hsv(val, 1, 1-val);
		};
		width.do{|x|
			height.do{|y|
				var iterations= this.at(x, y, z);
				if(iterations>=thresh, {
					img.setColor(colorFunc.value(iterations, maxIterations), x, y);
				});
			};
		};
		win.drawFunc= {
			Pen.drawImage(Rect(0, 0, win.bounds.width, win.bounds.height), img);
		};
		win.onClose= {img.free};
		win.front;
		^win;
	}
}
