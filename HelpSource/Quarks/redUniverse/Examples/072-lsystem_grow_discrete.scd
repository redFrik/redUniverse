//discrete growing lsystem
//note: not using RedLTurtle

(
var w, lsys, lplot, stream, matrix, stack= List.new, commands, command, cnt= 0;

//--settings
var width= 512, height= 512;
var num= 12;  //number of commands per frame
var fps= 25;  //framerate
var startGeneration= 3;
var numFramesPause= 20;  //wait between each new generation

//--example systems
lsys= RedLSystem("F", ($F: "F[+F--F]+F"));
lplot= (length: 20, theta: 10, scale: 0.9, noise: 0.1, initAngle: 0, initTranslate: Point(0.5, 0.5));

//lsys= RedLSystem("F", ($F: "|[-F]|[+F]F"));  //weed 2
//lplot= (length: 80, theta: 25, scale: 0.8, noise: 0.2, initAngle: 0, initTranslate: Point(0.5, 2/3));

//lsys= RedLSystem("F", ($F: "[-G+++F][-G+F][GG--F]", $G: "GG"));  //sierpinski arrowhead
//lplot= (length: 5, theta: 60, scale: 1, noise: 0, initAngle: 0.5pi, initTranslate: Point(1/3, 2/3));

//--world
w= RedWindow("lsystem grow discrete test", Rect(128, 64, width, height)).front;
(startGeneration-1).do{lsys.next};

commands= (
	$F: {|length, theta, noise|
		Pen.line(Point(0, 0), Point(0, length));
		Pen.stroke;
		Pen.translate(0, length);
		{Pen.translate(0, 0-length)};
	},
	$G: {|length, theta, noise|
		Pen.translate(0, length);
		{Pen.translate(0, 0-length)};
	},
	$+: {|length, theta, noise|
		var t= theta/360*2pi+noise.rand2;
		Pen.rotate(t);
		{Pen.rotate(0-t)};
	},
	$-: {|length, theta, noise|
		var t= theta/360* -2pi+noise.rand2;
		Pen.rotate(t);
		{Pen.rotate(0-t)};
	},
	$[: {|length, theta, noise|
		stack.add(List.new);
		nil;
	},
	$]: {|length, theta, noise|
		stack.pop.reverseDo{|revert|
			revert.value;
		};
		nil;
	},
	$|: {|length, theta, noise|
		Pen.line(Point(0, 0), Point(0, length));
		Pen.stroke;
		Pen.translate(0, length);
		{Pen.translate(0, 0-length)};
	}
);

//--loop
w.draw{
	if(command.isNil, {
		if(cnt>0, {
			cnt= cnt-1;
		}, {
			w.clearDrawing;  //clear each generation
			Pen.translate(lplot.initTranslate.x*width, lplot.initTranslate.y*height);
			Pen.rotate(lplot.initAngle);
			matrix= Pen.matrix.as(Array);
			lsys.next;
			("generation:"+lsys.generation).postln;  //debug
			stream= lsys.asString.iter;
			command= stream.next;
			cnt= numFramesPause;
		});
	}, {
		Pen.strokeColor= Color.white;
		Pen.matrix= matrix;
		num.do{
			var revert;
			//command.postln;  //debug - post each single commands
			revert= commands[command].value(
				lplot.scale**lsys.generation*lplot.length.neg,
				lplot.theta,
				lplot.noise
			);
			stack.last.add(revert);
			command= stream.next;
		};
		matrix= Pen.matrix.as(Array);
	});
};
w.clearOnRefresh= false;
w.play(fps);
CmdPeriod.doOnce({w.close});
)
