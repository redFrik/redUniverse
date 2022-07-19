// this file is part of redUniverse /redFrik


Red3DPlane : Red3D {
	*new {|position, width= 1, height= 1|
		^super.new.initRed3DPlane(position, width, height);
	}
	initRed3DPlane {|position, width, height|
		points= (
			#[
				[-1, -1],
				[1, -1],
				[1, 1],
				[-1, 1]
			]
		).collect{|a| RedVector3D.newFrom(a*[width, height, 0]/2)};
		outlines= #[  //pairs of indices
			[0, 1], [1, 2], [2, 3], [3, 0]
		];
		surfaces= #[
			[0, 1, 2, 3]
		];
		super.initRed3D(position);
	}
}
