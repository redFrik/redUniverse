// this file is part of redUniverse /redFrik


Red3DPoint : Red3D {
	*new {|position|
		^super.new.initRed3DPoint(position);
	}
	initRed3DPoint {|position|
		points= [RedVector3D[0, 0, 0]];
		outlines= #[];
		surfaces= #[];
		super.initRed3D(position);
	}
}