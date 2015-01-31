/*
Filename: Lab 4.scad
Name: Brandon Hill
Date: 10/28/14
		I worked on this assignment alone, but I referred to http://blog.cubehero.com/2013/11/19/know-only-10-things-to-be-dangerous-in-openscad/ for inspiration and instructions ("bishop" module is based heavily off of the code from this site).
		This is a program used to model chess pieces in OpenSCAD. There are two sections. If the section titled "Section 1" is uncommented and "Section 2" is commented out, it will produce all chess pieces of opposing colors in proper configuration. Otherwise, one of each piece will be produced for faster rendering.
*/

$fn = 100;

// Zoom out to see image!

module conical_body(body_height,base_radius,top_radius){
	cylinder(body_height,base_radius,top_radius);
}

module king_head(){
	translate([0,0,120])
		cylinder(20,12,20);
	translate([0,0,140])
		intersection(){
			sphere(20);
				translate([0,0,50])
					cube(100,true);
		}
	translate([0,0,168])
		cube([4,4,20],true);
	translate([0,0,170])
			cube([4,16,4],true);
}

module king_base(){
	intersection(){
		sphere(30);
		translate([0,0,50])
		cube(100,true);
	}
}

module king_collar(){
	translate([0, 0, 110])
    		intersection() {
      			cylinder(20,20,0);
     	 	translate([0, 0, 7])
        		mirror([0, 0, 1])
          		cylinder(20,20,0);
    		}
}

module king(col){
	rotate(90)
	color(col)union(){
		king_head();
		conical_body(120,18,12);
  		king_base();
		king_collar();
  	}
}

module queen_head(){
	translate([0,0,122])
		intersection(){
			sphere(20);
				translate([0,0,57])
					cube(100,true);
		}
	translate([0,0,120])
		difference(){
			difference(){
				cylinder(20,12,30);
				translate([0,0,8])
					cylinder(20,12,30);
			}
			for(i=[1:3])
				translate([0,0,35])
					rotate(i*360/3)
						cube([100,8,50],true);
		}
		translate([0,0,145])
			sphere(5);
}

module queen_base(){
	intersection(){
		sphere(30);
		translate([0,0,50])
			cube(100,true);
	}
}

module queen_collar(){
	translate([0, 0, 110])
    		intersection() {
    			cylinder(20,20,0);
     	 	translate([0, 0, 7])
    		    		mirror([0, 0, 1])
          			cylinder(20,20,0);
    		}
}

module queen(col){
	color(col)union(){
		queen_head();
		conical_body(120,18,12);
		queen_base();
		queen_collar();
	}
}

module rook_head(){
	translate([0,0,120])
		difference(){
			union(){
				cylinder(25,40,40);
				translate([0,0,-10])
					cylinder(10,30,40);
			}
			union(){
				translate([0,0,1])
					cylinder(30,30,30);
				for(i=[1:3])
					translate([0,0,35])
						rotate(i*360/3)
							cube([100,15,50],true);
			}

		}
}

module rook_body(){
	cylinder(120,30,30);
}

module rook_base(){
	intersection(){
		sphere(40);
		translate([0,0,50])
			cube(100,true);
	}	
}

module rook_collar(){
	translate([0,0,95])
		intersection(){
			cylinder(30,40,0);
			translate([0,0,7])
				mirror([0,0,1])
					cylinder(30,40,0);
		}
}

module rook(col){
	color(col)union(){
		rook_head();
		rook_body();	
		rook_base();
		rook_collar();
	}
}

module bishop_head(){
	translate([0, 0, 120])
		difference() {
   			union() {
   				sphere(r = 20);
   	    			translate([0, 0, 10])
   	    				cylinder(h = 30, r1 = 20 * cos(30), r2 = 0);
    				translate([0, 0, 40])
   	    				sphere(r = 6);
   	   		}
   	   		rotate([45, 0, 0])
   	    			translate([-20, 0, 0])
   	       			cube([40, 5, 40]);
   	 	}
}

module bishop_base(){
	intersection(){
		sphere(30);
		translate([0,0,50])
			cube(100,true);
	}
}

module bishop_collar(){
	translate([0, 0, 90])
    	intersection() {
      	cylinder(20,20,0);
      	translate([0, 0, 7])
        		mirror([0, 0, 1])
          		cylinder(20,20,0);
    	}
}

module bishop(col){
	color(col)union() {
		bishop_head();	
		conical_body(120,18,12);	
		bishop_base();  	
		bishop_collar();
	}
}

module knight_head(){
	translate([0,0,70])
		difference(){
			intersection(){
				sphere(75/2);
				cube([75,30,75],true);
			}
			translate([-15,0,-10])
				rotate([0,-45,0])
					cube([50,50,15],true);
		}
}

module knight_body(){
	translate([0,0,20])
			cube([30,30,40],true);
}

module knight_base(){
	intersection(){
		sphere(30);
		translate([0,0,50])
			cube(100,true);
	}
}

module knight(col){
	rotate(90)
	color(col)union(){
		knight_head();	
		knight_body();
		knight_base();  		
	}
}

module pawn_head(){
	translate([0,0,95])
		sphere(20);
}

module pawn_base(){
	intersection(){
		sphere(30);
		translate([0,0,50])
			cube(100,true);
	}
}

module pawn_collar(){
	translate([0,0,78])
		cylinder(4,25,25);
}

module pawn(col){
	color(col)union(){
		pawn_head();
		conical_body(80,18,12);
		pawn_base();
		pawn_collar();
	}
}

// Section 1 - All pieces, in proper configuration

/*
// White Side
for(i=[-4:3])
	translate([100*i,-100,0])
		rotate(180)
			pawn("white");
translate([0,-200,0])
	rotate(180)
		king("white");
translate([-100,-200,0])
	rotate(180)
		queen("white");
translate([-400,-200,0])
	rotate(180)
		rook("white");
translate([300,-200,0])
	rotate(180)
		rook("white");
translate([-300,-200,0])
	rotate(180)
		knight("white");
translate([200,-200,0])
	rotate(180)
		knight("white");
translate([-200,-200,0])
	rotate(180)
		bishop("white");
translate([100,-200,0])
	rotate(180)
		bishop("white");

// Black Side
for(i=[-4:3])
	translate([100*i,100,0])
		pawn("black");
translate([-100,200,0])
	king("black");
translate([0,200,0])
	queen("black");
translate([-400,200,0])
	rook("black");
translate([300,200,0])
	rook("black");
translate([-300,200,0])
	knight("black");
translate([200,200,0])
	knight("black");
translate([-200,200,0])
	bishop("black");
translate([100,200,0])
	bishop("black");
*/

//Section 2 - One of each piece


translate([100,100,0])
	rook("white");
translate([100,0,0])
	bishop("white");
translate([-100,100,0])
	pawn("white");
translate([-100,0,0])
	queen("white");
translate([-100,-100,0])
	king("white");
translate([100,-100,0])
	knight("white");
