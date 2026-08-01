include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

function ender3Bed_mountPoints() = [
    [0,2],
    [8,0],
    [20,20],
    [50,20],
    [62,0],
    [70,2],
    [66,27.5],
    [3.5,27.5],
];

module ender3Bed_holePattern() {
    translate([5,5,0]) {
        children();
    }
    
    translate([65,5,0]) {
        children();
    }
}

module ender3Bed_mountOutline() {
    difference() {
        union() {
            polygon(ender3Bed_mountPoints());
            
            ender3Bed_holePattern()
                circle(d=12.5, $fn=50);
        }
        
        ender3Bed_holePattern()
            circle(d=5, $fn=50);
    }
}

module ender3Bed_mount() {
    linear_extrude(4)
        ender3Bed_mountOutline();
}

module ender3AdxlMount_holePattern() {
    translate([2.5,2.5])
        children();
    
    translate([2.5+15.5,2.5])
        children();
}

module ender3AdxlMount_holeBoss() {
    linear_extrude(2)
        difference() {
            circle(d=6, $fn=20);
            circle(d=3, $fn=20);
        }
}

module ender3AdxlMount_pcbBaseOutline() {
    difference() {
        translate([-3,-3])
            rect([59.5+3, 16+3], rounding=[0,0,3,3], anchor=LEFT+FRONT, $fn=15);
        
        ender3AdxlMount_holePattern()
            circle(d=3, $fn=15);
        
        translate([25, -3])
            trapezoid(h=3, w1=20, w2=10, anchor=LEFT+FRONT);
    }
}

module ender3AdxlMount_nutTrap() {
    union() {
        cube([3,5.7,3.2], anchor=BOTTOM);
        cube([3,3,3.4], anchor=BOTTOM);
        nut_trap_inline(3, "M3", $slop=.1);
    }
}

module ender3AdxlMount_zipTieAnchor() {    
    rotate([0,90,0])
        tube(h=2, od=10, wall=1, anchor=FRONT, $fn=20);
}

module ender3AdxlMount_pcbBase() {
    difference() {
        linear_extrude(4)
            ender3AdxlMount_pcbBaseOutline();
        
        ender3AdxlMount_holePattern()
            ender3AdxlMount_nutTrap();
        
        translate([55,4,5.6])
            ender3AdxlMount_zipTieAnchor();
    }
    
    translate([0,0,4])
        ender3AdxlMount_holePattern()
            ender3AdxlMount_holeBoss();

    translate([20.4,7.6,4]) {
        cylinder(h=6, d=5.6, $fn=15);
        cylinder(h=2, d=8, $fn=15);
    }
}




difference() {
    union() {
        translate([0,0,4]) ender3Bed_mount();
        
        translate([3.5,27.5,0])
            cube([59.5+3, 3, 10]);

        translate([63,43.5+3,0])
            rotate([0,0,180])
                ender3AdxlMount_pcbBase();
    }

    translate([10,19.6,9.6])
        ender3AdxlMount_zipTieAnchor();

    translate([60,19.6,9.6])
        ender3AdxlMount_zipTieAnchor();
}