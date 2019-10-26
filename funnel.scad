length = 110;
width = 80;
height = 60;
wall = 0.5;

module funnel(l, w, h, out = false) {
    ls = l/5; // length shrink
    ws = 5*(w/11); // width shrink
    CubePoints = [
    [  0,  0,  0 ],  //0
    [ l,  0,  0 ],  //1
    [ l,  w,  0 ],  //2
    [  0,  w,  0 ],  //3
    [  0 + ls,  0 + ws,  h ],  //4
    [  l - ls,  0 + ws,  h ],  //5
    [  l - ls,  w - ws,  h ],  //6
    [  0 + ls,  w - ws,  h ]]; //7
  
    CubeFaces = [
    [0,1,2,3],  // bottom
    [4,5,1,0],  // front
    [7,6,5,4],  // top
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3]]; // left
    if(out){
        union(){
            polyhedron( CubePoints, CubeFaces );
            translate([l/2,w/2,h+1.5])
            cube([3/5*l, w/11, 3],true);
        }
    } else {
        polyhedron( CubePoints, CubeFaces );
    }
}

module pilar(){
    difference(){
        difference(){
            cube([2,width+5,height+80],false);
            translate([wall, wall, 2])cube([1,width+4,height+80],false);
        }
       translate([-wall, width/2 + 1.75, height + 80 - 29.5]) cube([10, 1.5, 30], false);
    }  
}

module sidewall(){
    cube([length + 3 ,wall,40], false);
}

// Create top
union(){
    difference(){
        union(){
            // Funnel edge
            cube([length+5, width+5, 2], false);
            // Create funnel and translate
            translate([2,2,2])
            difference() {
                funnel(length + 2*wall, width + 2*wall, height, out = true);
                translate([wall, wall, 0])
                    funnel(length, width, height);
            }
        }
        union(){
            // Funnel mouth
            translate([2.5,2.5,-.5])
            cube([length-.5, width-.5, 2.6], false);
            // Lower outlet
            translate([1*length/5 + 2*wall +2, width/2, height/2 + wall])
            cube([3/5*length- 2*wall, width/15, 100]);
        }
    }
// Pilar with slot for reed relay
    difference(){
        pilar();
        translate([-wall, width/2 + 1.75, height])
        union(){
            cube([10, 1.5, 15], false);
            translate([0, 0.55, -5]) cube([2, 0.5, 25], false);
        }
    }
    translate([length + 3,0,0]) pilar();
    sidewall();
    translate([0,width + 4.5,0]) sidewall();
}