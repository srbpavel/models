include <config.scad>;

module hranol_na_lano_s_dirama_2d()
difference()
{
p00=[0, 0];
p01=[0, hranol_vyska];
p02=[hranol_sirka-54.5, hranol_vyska];
p03=[hranol_sirka, 0];
points=[p00, p01, p02, p03];
polygon(points);
translate([
    5+prumer_dira_patka/2,
    5+prumer_dira_patka/2+hranol_vyska/2, 
    0])    
# circle(d=prumer_dira_patka);
translate([
    5+prumer_dira_patka/2,
    -5-prumer_dira_patka/2+hranol_vyska/2, 
    0])    
# circle(d=prumer_dira_patka);
}

module hranol_na_lano_s_dirama_3d()
{
linear_extrude(height=material_wt)
     hranol_na_lano_s_dirama_2d();
}


//hranol_na_lano_s_dirama_2d();
//hranol_na_lano_s_dirama_3d();
