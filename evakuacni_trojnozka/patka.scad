include <config.scad>;

module patka_s_dirou()
difference()
{
translate([patka_sirka/4,
    patka_sirka/4,
    0])
square(patka_sirka/2,
       center=true);

 translate([
    patka_sirka/2-prumer_dira_patka, 
    patka_sirka/2-prumer_dira_patka, 
    0])    
# circle(d=prumer_dira_patka);
} //konec difference


module patka_s_dirama_2d()
{    
patka_s_dirou();
    mirror([+1, 0, 0])
    patka_s_dirou();
    mirror([+1, 1, 0])
    patka_s_dirou();
    mirror([+0, 1, 0])
    patka_s_dirou();
}

module patka_s_dirama_3d()
 {
linear_extrude(height=material_wt)
    patka_s_dirama_2d();
}

//patka_s_dirama_2d();
//patka_s_dirama_3d();
