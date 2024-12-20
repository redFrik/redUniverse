// this file is part of redUniverse toolkit /redFrik

RedWindow : SCViewHolder {
	var <>mouse, <isPlaying= false, updateMouseFunc, playFrame, frameDur;
	*new {|name= "redWindow", bounds|
		^super.new.initRedWindow(name, bounds)
	}
	initRedWindow {|name, bounds|
		mouse= RedVector2D[0, 0];
		updateMouseFunc= {|v, x, y| mouse= RedVector2D[x, y]};
		view= UserView(nil, bounds)
		.name_(name)
		.background_(Color.black)
		.mouseDownAction_(updateMouseFunc)
		.mouseMoveAction_(updateMouseFunc);
	}
	draw {|func| view.drawFunc= func}
	play {|fps= 60|
		isPlaying= true;
		playFrame= 0;
		{
			var nextTime;
			while({isPlaying and:{view.isClosed.not}}, {
				nextTime= Main.elapsedTime+(1/fps);
				view.refresh;
				playFrame= playFrame+1;
				frameDur= (nextTime-Main.elapsedTime).max(0.001);
				frameDur.wait;
			});
		}.fork(AppClock);
	}
	frame {^playFrame?view.frame}
	frameRate {^if(frameDur.notNil, {1/frameDur}, {view.frameRate})}
	stop {isPlaying= false}
	resize {|redVec|
		view.bounds= Rect(view.bounds.left, view.bounds.top, redVec[0], redVec[1]);
	}
	isOpen {^view.isClosed.not}
	clear {view.clearDrawing}
	mouseDownAction_ {|func|
		view.mouseDownAction_(func);
		view.mouseDownAction= view.mouseDownAction.addFunc(updateMouseFunc);
	}
	mouseMoveAction_ {|func|
		view.mouseMoveAction_(func);
		view.mouseMoveAction= view.mouseMoveAction.addFunc(updateMouseFunc);
	}

	userView {
		this.deprecated(thisMethod);
		^view;
	}
}
