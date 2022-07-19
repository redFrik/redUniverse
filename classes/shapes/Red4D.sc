// this file is part of redUniverse /redFrik


Red4D : Red3D {

	initRed4D {|argPosition|
		position= argPosition??{RedVector4D[0, 0, 0, 0]};
		rotationMatrices= Array.fill(6, {
			#[
				[1, 0, 0, 0],
				[0, 1, 0, 0],
				[0, 0, 1, 0],
				[0, 0, 0, 1]
			]
		});
		this.rotation_(RedVector[0, 0, 0, 0, 0, 0]);
		this.update;
	}

	rotation_ {|redVec|
		rotation= redVec;
		this.rotationXZ_(rotation[0]);
		this.rotationYZ_(rotation[1]);
		this.rotationZW_(rotation[2]);
		this.rotationXW_(rotation[3]);
		this.rotationYW_(rotation[4]);
		this.rotationXY_(rotation[5]);
	}
	rotationXZ_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[1]= [
			#[1, 0, 0, 0],
			[0, c, 0, s],
			#[0, 0, 1, 0],
			[0, 0-s, 0, c]
		];
	}
	rotationYZ_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[0]= [
			[c, 0, 0, 0-s],
			#[0, 1, 0, 0],
			#[0, 0, 1, 0],
			[s, 0, 0, c]
		];
	}
	rotationZW_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[5]= [
			[c, 0-s, 0, 0],
			[s, c, 0, 0],
			#[0, 0, 1, 0],
			#[0, 0, 0, 1]
		];
	}
	rotationXW_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[3]= [
			#[1, 0, 0, 0],
			[0, c, 0-s, 0],
			[0, s, c, 0],
			#[0, 0, 0, 1]
		];
	}
	rotationYW_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[4]= [
			[c, 0, 0-s, 0],
			#[0, 1, 0, 0],
			[s, 0, c, 0],
			#[0, 0, 0, 1]
		];
	}
	rotationXY_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[2]= [
			#[1, 0, 0, 0],
			#[0, 1, 0, 0],
			[0, 0, c, 0-s],
			[0, 0, s, c]
		];
	}

	render {|dist= 2, size= 100|
		renderedPoints= vectors.collect{|v|
			v= v.project(dist);
			v= v.project(dist);
			Point(v[0], v[1])*size;
		};
	}

	draw {|dotSize= 5|
		renderedPoints.do{|p, i|
			Pen.fillOval(Rect.aboutPoint(p, dotSize, dotSize));
		};
	}
}
