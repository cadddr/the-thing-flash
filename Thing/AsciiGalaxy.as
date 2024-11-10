package {
	
	// Thanks for awesome implementation: https://codepen.io/Tibixx/pen/rNaxGNG

	public class AsciiGalaxy {
		var width, height, stars, trails: int;
		public var fieldRows = []
		var field = [];
		var ds = " ";

		public function AsciiGalaxy(width = 140, height = 60, stars = 40, trails = 20) {
			this.width = width;
			this.height = height;
			this.stars = stars;
			this.trails = trails;

			init();
		}

		public function init() {
			createField();
			generateGalaxy();
			render();
		}

		function createField() {
			for (var y = 0; y < height; y++) {
				field[y] = [];
				for (var x = 0; x < width; x++) {
					field[y][x] = ds;
				}
			}
		}

		function generateGalaxy() {
			for (var i = 0; i < trails; i++) {
				buildTrail();
			}

			for (var i = 0; i < stars; i++) {
				buildStar();
			}
		}

		function buildTrail() {
			var symbols = [
				".",
				"_",
				"-",
				"~",
				"°",
				"+"
			];
			var ys = Math.floor(Math.random() * height);
			var xs = Math.floor(Math.random() * width);
			var len = Math.floor(Math.random() * ((width - xs) - 1) + 1);
			var yc = 0;
			for (var i = 0; i < len; i++) {
				var rndSym = Math.floor(Math.random() * symbols.length);
				var rndY = Math.floor(Math.random() * (3 - 1 + 1)) + 1;
				if (rndY == 1) {
					yc += 1;
				} else if (rndY == 2) {
					yc -= 1;
				} else {
					yc = yc;
				}

				if (ys + yc > height || ys - yc < 0)
					return;
				try {
					//trace(ys,yc);
					field[ys + yc][xs + i] = symbols[rndSym];
				} catch (e) {
					//trace(e);
				}
			}
		}

		function buildStar() {
			var rndStar = Math.floor(Math.random() * 6);
			var ys = Math.floor(Math.random() * height);
			var xs = Math.floor(Math.random() * width);

			if (
				ys + 1 > height - 1 ||
				ys - 1 < 0 ||
				xs + 1 > width - 1 ||
				xs - 1 < 0
			) {
				field[ys][xs] = ds;
			} else {
				switch (rndStar) {
					case 0:
						//  |
						// -o-
						//  |
						field[ys][xs] = "o";
						field[ys + 1][xs] = "|";
						field[ys - 1][xs] = "|";
						field[ys][xs + 1] = "-";
						field[ys][xs - 1] = "-";
						break;
					case 1:
						field[ys][xs] = ".";
						break;
					case 2:
						field[ys][xs] = "`";
						break;
					case 3:
						field[ys][xs] = "~";
						field[ys][xs + 1] = "°";
						break;
					case 4:
						field[ys][xs] = ",";
						break;
					case 5:
						field[ys][xs] = "+";
						break;
					default:
						field[ys][xs] = "*";
						break;
				}
			}
		}

		public function render() {
			for (var y = 0; y < height; y++) {
				var row = "";
				for (var x = 0; x < width; x++) {
					row += field[y][x];
				}
				fieldRows.push(row)
			}
		}
	}
}