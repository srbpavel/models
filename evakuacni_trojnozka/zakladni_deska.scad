include <config.scad>;
/////2d trojnozka pro vykres

module kotvici_deska_3d()
{
linear_extrude(height=material_wt)
    deska_s_dirama_2d();
}

module kotvici_deska_2d()
{
p00=[-zd_sirka/2, 0];
p01=[-zd_sirka/2, zd_vyska/2-15];
p02=[-10, zd_vyska/2];
p03=[+10, zd_vyska/2];
p04=[+zd_sirka/2, zd_vyska/2-15];
p05=[+zd_sirka/2, 0];
//11.5
p06=[+zd_sirka/2, -zd_vyska/2+12.5];
//+18
p07=[+5, -zd_vyska/2];
//-18
p08=[-5, -zd_vyska/2];
//+11.5
p09=[-zd_sirka/2, -zd_vyska/2+12.5];
points=[p00, p01, p02, p03, p04, p05, p06, p07, p08, p09];
polygon(points);
}

module dira(
prumer,
x=0,
y=0)
translate([x,
           y])
# circle(d=prumer);

//2d_na_3d
//linear_extrude(height=material_wt)

module deska_s_dirama_2d()
{
difference()
{
kotvici_deska_2d();
//horni centralni dira
dira(prumer=30,
     x=0,
     y=zd_vyska/2-mezera_diry_od_kraje-15);
//horni diry krajni
dira(prumer=25,
     x=+35,
     y=zd_vyska/2-mezera_diry_od_kraje-12.5-10);
dira(prumer=25,
     x=-35,
     y=zd_vyska/2-mezera_diry_od_kraje-12.5-10);
//spodni centralni dira
dira(prumer=20,
     x=0,
     y=-zd_vyska/2+mezera_diry_od_kraje+10);
///
//    dira(prumer=20,
//     x=0,
//     y=-zd_vyska/2+mezera_diry_od_kraje+10-20);
//spodni diry mezi
dira(prumer=20,
     x=+30,
     y=-zd_vyska/2+mezera_diry_od_kraje+10+5);
dira(prumer=20,
     x=-30,
     y=-zd_vyska/2+mezera_diry_od_kraje+10+5);
////
//dira(prumer=20,
//     x=+30,
//     y=-zd_vyska/2+mezera_diry_od_kraje+10+5-20);
//dira(prumer=20,
//     x=-30,
//     y=-zd_vyska/2+mezera_diry_od_kraje+10+5-20);
//spodni diry krajni
dira(prumer=20,
     x=+30+30,
     y=-zd_vyska/2+mezera_diry_od_kraje+10+5+5);
dira(prumer=20,
     x=-30-30,
     y=-zd_vyska/2+mezera_diry_od_kraje+10+5+5);
//dira(prumer=20,
//     x=+30+30,
//     y=-zd_vyska/2+mezera_diry_od_kraje+10+5+5-20);
//dira(prumer=20,
//     x=-30-30,
//     y=-zd_vyska/2+mezera_diry_od_kraje+10+5+5-20);
}
}

deska_s_dirama_2d();
//kotvici_deska_2d();
//kotvici_deska_3d();

//______________________________
//scale(-1.0) to prehodi naproti
/*
scale(+1.0)
{
square(10);
}
*/
