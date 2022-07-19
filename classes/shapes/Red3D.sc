// this file is part of redUniverse /redFrik


Red3D {  //abstract class
	var <points, <outlines, <surfaces;
	var <rotation, <rotationMatrices;
	var <>position, <vectors, <renderedPoints;

	initRed3D {|argPosition|
		position= argPosition??{RedVector3D[0, 0, 0]};
		rotationMatrices= Array.fill(3, {
			#[
				[1, 0, 0],
				[0, 1, 0],
				[0, 0, 1]
			]
		});
		this.rotation_(RedVector3D[0, 0, 0]);
		this.update;
	}

	rotation_ {|redVec|
		rotation= redVec;
		this.rotationX_(rotation[0]);
		this.rotationY_(rotation[1]);
		this.rotationZ_(rotation[2]);
	}
	rotationX_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[0]= [
			#[1, 0, 0],
			[0, c, 0-s],
			[0, s, c]
		];
	}
	rotationY_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[1]= [
			[c, 0, 0-s],
			#[0, 1, 0],
			[s, 0, c]
		];
	}
	rotationZ_ {|theta|
		var c= cos(theta);
		var s= sin(theta);
		rotationMatrices[2]= [
			[c, 0-s, 0],
			[s, c, 0],
			#[0, 0, 1]
		];
	}

	update {
		vectors= points.collect{|v|
			v= v+position;
			rotationMatrices.do{|m| v= v.matrixMul(m)};
			v;
		};
	}

	render {|dist= 2, size= 100|
		renderedPoints= vectors.collect{|v|
			v= v.project(dist);
			Point(v[0], v[1])*size;
		};
	}

	draw {|dotSize= 5|
		renderedPoints.do{|p, i|
			Pen.fillOval(Rect.aboutPoint(p, vectors[i][2]+1*dotSize, vectors[i][2]+1*dotSize));
		};
	}
	drawOutlines {
		outlines.do{|o|
			Pen.line(renderedPoints[o[0]], renderedPoints[o[1]]);
		};
		Pen.stroke;
	}
	drawSurfaces {
		surfaces.do{|s|
			Pen.moveTo(renderedPoints[s[0]]);
			Pen.lineTo(renderedPoints[s[1]]);
			Pen.lineTo(renderedPoints[s[2]]);
			Pen.lineTo(renderedPoints[s[3]]);
			Pen.fill;
		};
	}
}
