// =====================================================
// Common Connector Library
// =====================================================
// Reusable connector patterns for modular 3D printed parts
// Part of SCAD Toolkit

// =====================================================
// PIN AND SOCKET CONNECTORS
// =====================================================

// Creates a cylindrical pin connector (male)
// Parameters:
//   length: How far the pin extends
//   diameter: Pin diameter
//   tolerance: Adjustment for printer (subtract from diameter)
module connector_pin(length=10, diameter=4, tolerance=0.2) {
    cylinder(
        h = length,
        d = diameter - tolerance,
        $fn = 30
    );
}

// Creates a socket for a pin connector (female)
// Parameters:
//   depth: How deep the socket goes
//   diameter: Socket inner diameter
//   tolerance: Adjustment for printer (add to diameter)
module connector_socket(depth=11, diameter=4, tolerance=0.2) {
    cylinder(
        h = depth,
        d = diameter + tolerance,
        $fn = 30
    );
}

// =====================================================
// DOVETAIL CONNECTORS
// =====================================================

// Male dovetail connector
// Parameters:
//   width: Base width
//   height: Connector height
//   depth: How far it extends
//   angle: Dovetail angle (degrees)
module dovetail_male(width=10, height=5, depth=10, angle=10) {
    top_width = width + 2 * height * tan(angle);

    linear_extrude(depth)
    polygon([
        [0, 0],
        [width, 0],
        [width - height * tan(angle), height],
        [height * tan(angle), height]
    ]);
}

// Female dovetail connector
module dovetail_female(width=10, height=5, depth=11, angle=10, tolerance=0.2) {
    top_width = width + 2 * height * tan(angle);

    translate([0, 0, -0.1])
    linear_extrude(depth + 0.1)
    offset(delta=tolerance)
    polygon([
        [0, 0],
        [width, 0],
        [width - height * tan(angle), height],
        [height * tan(angle), height]
    ]);
}

// =====================================================
// SNAP-FIT CONNECTORS
// =====================================================

// Simple cantilever snap-fit hook
// Parameters:
//   length: Hook length
//   width: Hook width
//   thickness: Base thickness
//   hook_depth: Depth of the hook catch
module snap_hook(length=10, width=5, thickness=2, hook_depth=1) {
    difference() {
        union() {
            // Base beam
            cube([length, width, thickness]);

            // Hook at end
            translate([length - hook_depth, 0, 0])
            cube([hook_depth, width, thickness + hook_depth]);
        }

        // Chamfer for easier insertion
        translate([length - hook_depth, 0, thickness])
        rotate([0, 45, 0])
        cube([hook_depth, width, hook_depth]);
    }
}

// Snap-fit catch (female)
module snap_catch(length=11, width=5.2, thickness=2.2, hook_depth=1.2) {
    difference() {
        cube([length, width, thickness + hook_depth]);

        // Slot for hook
        translate([-0.1, width/2 - (width-0.4)/2, -0.1])
        cube([length - hook_depth + 0.1, width - 0.4, thickness + 0.1]);
    }
}

// =====================================================
// T-SLOT CONNECTORS
// =====================================================

// T-slot profile (male)
module t_slot_male(length=20, slot_width=6, neck_width=4, head_height=3, neck_height=5) {
    translate([0, 0, 0])
    union() {
        // Neck
        translate([0, (slot_width - neck_width) / 2, 0])
        cube([length, neck_width, neck_height]);

        // Head
        cube([length, slot_width, head_height]);
    }
}

// T-slot channel (female)
module t_slot_female(length=21, slot_width=6.2, neck_width=4.2, head_height=3.2, depth=10, tolerance=0.2) {
    translate([0, 0, -0.1])
    linear_extrude(depth + 0.1)
    offset(delta=tolerance/2)
    polygon([
        [0, 0],
        [length, 0],
        [length, head_height],
        [length - (slot_width - neck_width) / 2, head_height],
        [length - (slot_width - neck_width) / 2, depth],
        [(slot_width - neck_width) / 2, depth],
        [(slot_width - neck_width) / 2, head_height],
        [0, head_height]
    ]);
}

// =====================================================
// BALL AND SOCKET
// =====================================================

// Spherical ball connector
module ball_connector(diameter=8, stem_diameter=4, stem_length=5, tolerance=0) {
    sphere(d=diameter - tolerance, $fn=50);
    cylinder(d=stem_diameter - tolerance, h=stem_length, $fn=30);
}

// Socket for ball connector
module ball_socket(diameter=8, depth=5, opening=6, tolerance=0.3) {
    difference() {
        // Outer shell
        cylinder(d=diameter + 4, h=depth + diameter/2, $fn=50);

        // Ball cavity
        translate([0, 0, depth])
        sphere(d=diameter + tolerance, $fn=50);

        // Opening
        translate([0, 0, -0.1])
        cylinder(d=opening, h=depth + 0.2, $fn=30);
    }
}

// =====================================================
// CLIP CONNECTORS
// =====================================================

// Spring clip (living hinge style)
module spring_clip(length=20, width=10, thickness=2, gap=5, clip_depth=2) {
    difference() {
        cube([length, width, thickness]);

        // Gap for flexibility
        translate([length/2 - gap/2, -0.1, -0.1])
        cube([gap, width/2, thickness + 0.2]);
    }

    // Clip hook
    translate([length/2 - gap/2 - 1, 0, 0])
    cube([1, width, thickness + clip_depth]);
}

// =====================================================
// USAGE EXAMPLES (commented out)
// =====================================================

// Example: Pin and socket pair
/*
connector_pin(length=10, diameter=4);
translate([20, 0, 0])
    connector_socket(depth=11, diameter=4);
*/

// Example: Dovetail pair
/*
dovetail_male(width=10, height=5, depth=10);
translate([20, 0, 0])
    dovetail_female(width=10, height=5, depth=11);
*/

// Example: Snap-fit pair
/*
snap_hook(length=10, width=5);
translate([0, 10, 0])
    snap_catch(length=11, width=5.2);
*/
