// this file is part of redUniverse /redFrik


Red4DTesseract : Red4D {
	*new {|position, width= 1, height= 1, depth= 1, fourth= 1|
		^super.new.initRed4DTesseract(position, width, height, depth, fourth);
	}
	initRed4DTesseract {|position, width, height, depth, fourth|
		points= (
			#[
				[-1, -1, -1, 1],
				[1, -1, -1, 1],
				[1, 1, -1, 1],
				[-1, 1, -1, 1],
				[-1, -1, 1, 1],
				[1, -1, 1, 1],
				[1, 1, 1, 1],
				[-1, 1, 1, 1],
				[-1, -1, -1, -1],
				[1, -1, -1, -1],
				[1, 1, -1, -1],
				[-1, 1, -1, -1],
				[-1, -1, 1, -1],
				[1, -1, 1, -1],
				[1, 1, 1, -1],
				[-1, 1, 1, -1]
			]
		).collect{|a| RedVector4D.newFrom(a*[width, height, depth, fourth]/2)};
		outlines= #[  //pairs of indices
			[0, 1], [1, 2], [2, 3], [3, 0],
			[4, 5], [5, 6], [6, 7], [7, 4],
			[8, 9], [9, 10], [10, 11], [11, 8],
			[12, 13], [13, 14], [14, 15], [15, 12],
			[0, 4], [1, 5], [2, 6], [3, 7],
			[8, 12], [9, 13], [10, 14], [11, 15],
			[0, 8], [1, 9], [2, 10], [3, 11],
			[4, 12], [5, 13], [6, 14], [7, 15]
		];
		surfaces= #[
			[0, 1, 2, 3],
			[4, 5, 6, 7],
			[0, 4, 5, 1],
			[1, 5, 6, 2],
			[2, 6, 7, 3],
			[3, 7, 4, 0],

			[8, 9, 10, 11],
			[4, 8, 9, 5],
			[5, 9, 10, 6],
			[6, 10, 11, 7],
			[7, 11, 8, 4],
			[12, 13, 14, 15],

			[0, 8, 9, 1],
			[1, 9, 10, 2],
			[2, 10, 11, 3],
			[3, 11, 8, 0],
			[4, 5, 13, 12],
			[5, 6, 14, 13],
			[6, 7, 15, 14],
			[7, 4, 12, 15],

			[0, 8, 12, 4],
			[1, 9, 13, 5],
			[2, 10, 14, 6],
			[3, 11, 15, 7]
		];
		super.initRed4D(position);
	}
}