include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>
include <../BOSL2/walls.scad>

Select = 0; //[0:Preview,1:Boom,2:Gantry Plate]

module goProMount_fin() {
    difference() {
    cuboid([20.5,15,3], rounding=7.5, edges=[FRONT+RIGHT,BACK+RIGHT], anchor=BOTTOM, $fn=90);
        
        translate([20.5/2-7.5,0,0])
        screw_hole("M5", head="none", length=3, $fn=20, anchor=BOTTOM);
    }
}

module goProMount_nutFin() {
    difference() {
        cuboid([20.5,15,2.8], rounding=7.5, edges=[FRONT+RIGHT,BACK+RIGHT], anchor=BOTTOM, $fn=90)
                attach(TOP)
                    align(RIGHT, inside=true)
                        cylinder(d=15,h=2,$fn=90);

        translate([20.5/2-7.5,0,1.2])
            nut_trap_inline(2.8, "M5");
        
        translate([20.5/2-7.5,0,0])
        screw_hole("M5", head="none", length=2.8, $fn=20, anchor=BOTTOM);
    }
}

module goProMount_noBase() {
    translate([6.2+2.8/2,0,20.5/2])
    rotate([0,-90,0])
    union() {
        goProMount_fin();

        translate([0,0,6.2]) goProMount_fin();

        translate([0,0,12.4]) goProMount_nutFin();

        translate([-20.5/2,0,0])
            rotate([0,0,90])
                prismoid(size1=[15,15], size2=[0,15], h=4.4, orient=FRONT, anchor=BOTTOM+FRONT);
    }
}


module enderWireNocturneMnt_zipTieAnchor() {
    tube(h=2.4, od=10, wall=1.4, anchor=FRONT, $fn=20);
}

module enderWireNocturneMnt_goProMnt() {
    difference() {
        prismoid(size1=[25,15], size2=[15.2,15], h=50/2-20.5/2)
                attach(TOP)
                    goProMount_noBase();
        
        translate([0,4,7.5])
            enderWireNocturneMnt_zipTieAnchor();
    }
}

function enderWireNocturneMnt_boomShape() = [
    [0, 0], 
    [0, 20], 
    [124, 20], 
    [125.94, 17],
];

module enderWireNocturneMnt_boomBase() {
    cuboid([25,20,5], anchor=BOTTOM, chamfer=2,
    edges=[BACK+LEFT, BACK+RIGHT, FRONT+LEFT, FRONT+RIGHT]) children();
}

module enderWireNocturneMnt_boomArm() {
    diff()
        hex_panel(enderWireNocturneMnt_boomShape(), strut=2, spacing=9, h = 25, frame = 3, anchor=LEFT, orient=LEFT, shift=[0,0.8]) {
            edge_mask([BOTTOM+BACK,TOP+BACK])
                chamfer_edge_mask(l=145, chamfer=2);
            edge_mask([TOP+FRONT])
                rotate([0,-7.688,0])
                    chamfer_edge_mask(l=224, chamfer=2);
            edge_mask([BOTTOM+FRONT])
                rotate([0,7.688,0])
                    chamfer_edge_mask(l=224, chamfer=2);
        }
}

module enderWireNocturneMnt_boom() {
    difference() {
        enderWireNocturneMnt_boomBase()
            attach(TOP)
                enderWireNocturneMnt_boomArm();
        
        for(i=[-1:2:1]) {
            translate([-i*6,0,0])
                cylinder(h=5, d=4.6, $fn=20, anchor=BOTTOM);
        }
        
        for(i=[0:43:100]) {
            translate([0,7.4,20+i])
                enderWireNocturneMnt_zipTieAnchor();
        }
    }


    translate([0,6.0,123.5])
        rotate([90-7.65,0,0])
            enderWireNocturneMnt_goProMnt();
}

module enderWireNocturnMnt_gantryPlate() {
    difference() {
        translate([-25,0,0])
            diff()
                cuboid([110,20,15], rounding=10, edges=[FRONT+RIGHT,BACK+RIGHT], anchor=BOTTOM)
                    attach(TOP, BOTTOM, inside=true)
                        wedge([110, 20, 1.75], orient=DOWN, anchor=BOTTOM, spin=180, $fn=90);
                    
        translate([-50,-5,4])
            cuboid([75,20,20], rounding=5, anchor=BOTTOM, $fn=90);
        
        translate([25,0,4])
            cuboid([25,30,20], rounding=5, anchor=BOTTOM, $fn=90);
                
        
        for(i=[-1:2:3]) {
            translate([-i*20,0,0])
                screw_hole("M5", head="button", length=4, counterbore=11, $fn=20, anchor=BOTTOM);
        }

        for(i=[-1:2:1]) {
            translate([-i*6,-1,-2])
                rotate([-5,0,0])
                    screw_hole("M3", head="button", length=10, $fn=20, counterbore=7, orient=DOWN, anchor=TOP);
        }
        
        for (i=[-1:1:1]) {
            translate([-35-i*20,11,1.4])
                rotate([90,0,90])
                    enderWireNocturneMnt_zipTieAnchor();
        }
    }
}

if (Select == 0) {
    translate([0,0,14])
        rotate([-5,0,0])
            enderWireNocturneMnt_boom();
    enderWireNocturnMnt_gantryPlate();
}
else if (Select == 1) {
    translate([0,-60,9])
        rotate([-90,0,0])
            enderWireNocturneMnt_boom();
}
else if (Select == 2) {
    enderWireNocturnMnt_gantryPlate();
}


