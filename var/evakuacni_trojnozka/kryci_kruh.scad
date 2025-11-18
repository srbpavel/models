include <config.scad>;

module kryci_kruh_2d()
difference()
{
circle(d=d_kruh);
square(size=[zd_sirka+2, 
             material_wt+2],
        center=true);
}

module kryci_kruh_3d()
 {
linear_extrude(height=material_wt)
    kryci_kruh_2d();
}

//kryci_kruh_2d();
//kryci_kruh_3d();

/*
//kontrola mereni diry na spasovani a svar
color("lime", 1.0)
 square(size=[zd_sirka,
	     material_wt],
	center=true);
*/
