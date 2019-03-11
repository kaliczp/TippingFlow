use<triangles.scad>

$fn = 30;

module bucket(length, width, height,thick)
{
	difference() {
		union() {
            // bottom plate
			translate([-width/2, -length/2, -thick]) cube([width,length,thick]);
            // triangle sensor arm
			translate([width/2-thick, 0, 0])  rotate(a=90, v=[0,1 ,0 ]) rotate(a=90, v=[0,0 ,1 ]) Isosceles_Triangle(b=length, H=height, height=thick);
            // opposit triangle
			translate([-width/2, 0, 0])  rotate(a=90, v=[0,1 ,0 ]) rotate(a=90, v=[0,0 ,1 ]) Isosceles_Triangle(b=length, H=height, height=thick);

			// vertical schot
			color("blue") translate([0, 0, (5.162*height)/10+2*thick]) rotate(a=90,v=[1,0,0]) cube([width-2*thick,height-5.5,thick],center = true);

			// inside angles
			color("green") translate([0, -2.5-thick, 2.5]) rotate(a=45,v=[1,0,0]) cube([width-2*thick,9,thick],center = true);
			color("green") translate([0, 2.5+thick, 2.5]) rotate(a=-45,v=[1,0,0]) cube([width-2*thick,9,thick],center = true);

			// sensor arm need some slot for magnet
            difference() {
                color("green") translate([width/2-thick/2, 0, height]) rotate(a=90,v=[0,1,0]) cube([30,7,thick],center = true);
                translate([width/2-thick/2, 0, 6*height/5]) rotate(a=90,v=[0,1,0]) cube([6,3,2*thick],center = true);
                }
            // weight arm
            color("green") translate([-width/2+thick/2, 0, height]) rotate(a=90,v=[0,1,0]) cube([30,7,thick],center = true);
			//color("blue") translate([0, 0, 0]) rotate(a=90, v=[0,1 ,0 ]) cylinder(h=width, r=3, center=true);

		}
	// remove bottom parts
	color("red") translate([0, 0, -thick-5]) cube([width+2,length+2,10], center = true);
	// whole for shaft
	color("red") translate([0, 0, 1.02]) rotate(a=90, v=[0,1 ,0 ]) cylinder(h=width+2, r=1.05, center=true);
	}
}

bucket(100,100,50,.5);
