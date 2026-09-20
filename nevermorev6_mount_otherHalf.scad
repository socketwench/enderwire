include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

diff()
cuboid([20,100,6], chamfer=1, edges=[BOTTOM+LEFT, BOTTOM+RIGHT], anchor=BOTTOM) {
        align(TOP, inside=true, shiftout=0.01)
            translate([-
    0.7,25,0])
            prismoid(size1=[20-2.4-0.8,50],size2=[20-2.2,50], height=1, anchor=BOTTOM);
    
        // Referencing the top of the parent, so we make this 1mm taller than is necessary.
        // We also need to subtract another 2mm given overlap from the other model.
        align(TOP+BACK, inside=true, shiftout=0.01)
            translate([-
            0.4,0,0])
                cuboid([5.6,40-2,2.2+1]);
    
        align(BOTTOM+BACK, inside=true, shiftout=0.01)
            translate([0,-66,0])
                screw_hole("M5", head="button", length=2, counterbore=4, $fn=20, anchor=BOTTOM);
    
    align(FRONT, inside=true, shiftout=0.01)
    wedge([6, 20, 20], orient=RIGHT);
    }
    