include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

/**

    Nevermore V6 split mount for Enderwire 2020 mod.
    
    The original model definitely was sufficient, but I wanted to constrain the fan
    from rotating while the enclosure was off. This merely completes it in a size 
    that can be printed from a Voron Zero.
    
    @author socketwench
    @see https://www.printables.com/model/1445563-enderwire-nevermore-v6-micro-mount
    @see https://www.printables.com/model/1250018-ft-enderwire-mount-for-nevermore-micro-v6

*/

Select = 0; //[0:left, 1:right]

module nevermoreV6_mount_otherHalf() {
    diff()
    
        // The prismoid gives us the cutout for the fan.
        // Why a prismoid? We can control the effective chamfer angle of the cutout in a way
        // we couldn't with another cuboid. 
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
        
            // Matches the mount spacing from https://www.printables.com/model/1250018-ft-enderwire-mount-for-nevermore-micro-v6
            align(BOTTOM+BACK, inside=true, shiftout=0.01)
                translate([0,-66,0])
                    screw_hole("M5", head="button", length=2, counterbore=4, $fn=20, anchor=BOTTOM);
            
            // Purely decorative. It fits the aesthetic better than a curved end.
            align(FRONT, inside=true, shiftout=0.01)
                wedge([6, 20, 20], orient=RIGHT);
        }
}

module nevermoreV6_mount_otherHalfMirrored() {
    mirror([1,0,0])
        nevermoreV6_mount_otherHalf();
}


if (Select == 0) {
    nevermoreV6_mount_otherHalf();
}
else if (Select == 1) {
    nevermoreV6_mount_otherHalfMirrored();
}
