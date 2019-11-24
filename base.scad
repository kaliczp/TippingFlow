$fn = 30;

module base(length, width, height, thick)
{
	difference() {
		union() {
			translate([-width/2, -length/2, -thick]) cube([width,length, thick]);
			translate([width/2-thick, -length/4, 0]) cube([thick, length/2,height]);
            translate([-width/2, -length/4, 0]) cube([thick, length/2,height]);
            // Support
            difference(){
                color("green")
                translate([0,0,(height-height/4)/2])
                cube([width+2*thick,thick,height-height/4], true);
                translate([thick,0,(height-height/4)])
                cube([width - 7*thick, 2*thick,height/4], true);
            }
			// calibration posts
			color("blue") translate([0, length/2-10, 0]) cylinder(h=4.5, r=thick +1.5 , center=false);
			color("blue") translate([0, -length/2+10, 0]) cylinder(h=4.5, r=thick +1.5 , center=false);
		}
		// hole for the bucket rod
		color("red") translate([0, 0, height-7]) rotate(a=90, v=[0,1 ,0 ]) cylinder(h=width+5, r=1, center=true);
		// calibration posts holes
		color("red") translate([0, length/2-10, -3]) cylinder(h=9, r=1.5, center=false);
		color("red") translate([0, -length/2+10, -3]) cylinder(h=9, r=1.5, center=false);
		// mounting holes
		color("red") translate([width/2-7, length/2-5, -3]) cylinder(h=4, r=2, center=false);
		color("red") translate([width/2-7, -length/2+5, -3]) cylinder(h=4, r=2, center=false);
		color("red") translate([-width/2+7, length/2-5, -3]) cylinder(h=4, r=2, center=false);
		color("red") translate([-width/2+7, -length/2+5, -3]) cylinder(h=4, r=2, center=false);
		// cut to top off top
		color("red") translate([0, 0, height-3]) cube([width+2,10,8],center = true);
	}
}


base(80,110,30,.87);
