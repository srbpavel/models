radius = 10;
height = 20;
thickness = 1;
$fn = 24;

render() intersection() {
    difference() {
        cylinder(
            r1 = radius + thickness, 
            r2 = radius + thickness, 
            h = height, center = true);
        cylinder(
            r1 = radius, 
            r2 = radius, 
            h = height, center = true);
    }

    rotate([90, 0, 0]) linear_extrude(radius + thickness) 
        text("Sumci_Demon", size = height/10, valign = "center", halign = "center");
}