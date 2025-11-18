include <config.scad>;

module bocni_kridlo_3d()
{
linear_extrude(height=material_wt)
    bocni_kridlo_2d();
}

module bocni_kridlo_2d()
{
p00=[-bk_sirka/2, -bk_vyska/2];
p01=[-bk_sirka/2, +bk_vyska/2];
p02=[+bk_sirka/2-52, +bk_vyska/2];
p03=[+bk_sirka/2, -bk_vyska/2];
points=[p00, p01, p02, p03];
polygon(points);
}

//bocni_kridlo_2d();
//bocni_kridlo_3d();
