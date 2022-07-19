// this file is part of redUniverse /redFrik


Red3DLine : Red3D {
	*new {|position, length= 1|
		^super.new.initRed3DLine(position, length);
	}
	initRed3DLine {|position, length|
		points= (
			#[
				[-1],
				[1]
			]
		).collect{|a| RedVector3D.newFrom(a*[length, 0, 0]/2)};
		outlines= #[  //pairs of indices
			[0, 1]
		];
		surfaces= #[];
		super.initRed3D(position);
	}
}
