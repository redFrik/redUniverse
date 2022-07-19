// this file is part of redUniverse /redFrik


Red3DBox : Red3D {
	*new {|position, width= 1, height= 1, depth= 1|
		^super.new.initRed3DBox(position, width, height, depth);
	}
	initRed3DBox {|position, width, height, depth|
		points= (
			#[
				[-1, -1, -1],
				[1, -1, -1],
				[1, 1, -1],
				[-1, 1, -1],
				[-1, -1, 1],
				[1, -1, 1],
				[1, 1, 1],
				[-1, 1, 1]
			]
		).collect{|a| RedVector3D.newFrom(a*[width, height, depth]/2)};
		outlines= #[  //pairs of indices
			[0, 1], [1, 2], [2, 3], [3, 0],
			[4, 5], [5, 6], [6, 7], [7, 4],
			[0, 4], [1, 5], [2, 6], [3, 7]
		];
		surfaces= #[
			[0, 1, 2, 3],
			[4, 5, 6, 7],
			[0, 4, 5, 1],
			[1, 5, 6, 2],
			[2, 6, 7, 3],
			[3, 7, 4, 0]
		];
		super.initRed3D(position);
	}
}
