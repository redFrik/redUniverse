// this file is part of redUniverse toolkit /redFrik

//todo:
//mouseDownAction etc.  now mouse is lost if setting userView.mouseDownAction

RedWindow : Window {
	var <>mouse, <isPlaying= false, <userView;
	*new {|name= "redWindow", bounds, resizable= false, border= true, server, scroll= false|
		^super.new.initRedWindow(name, bounds, resizable, border, scroll)
	}
	initRedWindow { arg name, bounds, resize, border, scroll;
		if( scroll, {"RedWindow: can't scroll".warn});
		view = TopView.new(this,name,bounds??{Rect(128, 64, 300, 300)},resize,border);

		// set some necessary object vars
		resizable = resize == true;

		// allWindows array management
		Window.addWindow( this );
		view.connectFunction( 'destroyed()', { Window.removeWindow(this); }, false );

		// action to call whenever a window is created
		Window.initAction.value( this );

		this.background= Color.black;
		mouse= RedVector2D[0, 0];
		userView= UserView(this, Rect(0, 0, view.bounds.width, view.bounds.height))
		.mouseDownAction_{|view, x, y| mouse= RedVector2D[x, y]}
		.mouseMoveAction_{|view, x, y| mouse= RedVector2D[x, y]};
	}
	draw {|func| userView.drawFunc= func}
	play {|fps= 40|
		isPlaying= true;
		{while{this.isOpen&&isPlaying} {userView.refresh; fps.reciprocal.wait}}.fork(AppClock);
	}
	stop {isPlaying= false}
	resize {|redVec|
		this.bounds= Rect(this.bounds.left, this.bounds.top, redVec[0], redVec[1]);
		userView.bounds= Rect(0, 0, redVec[0], redVec[1]);
	}
	background_ {|color| view.background= color}
	isOpen {^this.isClosed.not}

	animate_ {|bool|
		userView.animate= bool;
	}
	frame {
		^userView.frame;
	}
	frameRate {
		^userView.frameRate;
	}
	clear {
		userView.clearDrawing;
	}
}
