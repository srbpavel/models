$fn=50;

pruhlednost=0.6;
//pruhlednost=1.0;

vyska = 8;

hloubka_horni = 3;

prumer_horni_vnejsi = 8;
prumer_horni_vnitrni = 4;

polomer_horni_vnitrni = prumer_horni_vnitrni / 2;

wt_horni = (prumer_horni_vnejsi- prumer_horni_vnitrni) / 2;

prumer_spodni_vnejsi = 9; 
prumer_spodni_stred = 6; 
prumer_spodni_vnitrni = 4; 

polomer_spodni_stred = prumer_spodni_stred / 2;
polomer_spodni_vnitrni = prumer_spodni_vnitrni / 2;


hloubka_spodni = 4;

wt_spodni = (prumer_spodni_vnejsi - prumer_spodni_stred) / 2;

module zaslepka_obrys() 
    {
    p00 = [0, 0];
    p01 = [polomer_spodni_vnitrni, 0];
    p02 = [polomer_spodni_vnitrni, hloubka_spodni];
    p03 = [polomer_spodni_stred, hloubka_spodni];
    p04 = [polomer_spodni_stred, 0];
    p05 = [prumer_spodni_vnejsi / 2, 0];
    p06 = [prumer_horni_vnejsi / 2, vyska];
    p07 = [polomer_horni_vnitrni, vyska];
    p08 = [polomer_horni_vnitrni, vyska - hloubka_horni];
    p09 = [0, vyska - hloubka_horni];
        
    points=[
        p00, 
        p01, 
        p02,
        p03, 
        p04, 
        p05,
        p06, 
        p07, 
        p08,
        p09,
        ];
        
    polygon(points);
    }
    
module zaslepka_3d()
    color("crimson", pruhlednost)
    translate([0, 0, 0])
    rotate([0, 0, 0])
    rotate_extrude(angle=360)
    zaslepka_obrys();    
    
//zaslepka_obrys();
    
zaslepka_3d(); 
   