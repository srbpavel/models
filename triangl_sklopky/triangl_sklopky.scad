//CONFIG
$fn=50;

wt_material = 5.0; // tloustka plechu [mm]
a = 150; // delka_hrany [mm]
d = 30; // prumer diry [mm]

a_pul = 150 / 2;
pow_a = pow(a, 2);
pow_a_pul = pow(a_pul, 2);
h = sqrt(pow_a - pow_a_pul); //vyska
stred = tan(30) * 75; //stred soumernosti 
//CONFIG_


module dira(prumer_diry)
    {
    circle(d = prumer_diry);
    }


module triangl(hrana) 
    {
    p00 = [+hrana/2, 0];
    p01 = [-hrana/2, 0];
    p02 = [0, +h];
        
    points=[p00, p01, p02];
        
    polygon(points);
    }


module triangl_s_dirou_2d()
    difference()
    { 
        translate([0, 0]) //posun trianglu
            {
            triangl(hrana = a);
            }
    
            translate([0, +stred]) //posun diry
            {
            #dira(
            prumer_diry = d);    
            }
    }


module triangl_s_dirou_3d()  
    {
    linear_extrude(height = wt_material)
        triangl_s_dirou_2d();
    }

//echo("stred: ", stred);

///* 
triangl_s_dirou_2d();
//*/ 
    
/*
triangl_s_dirou_3d();   
*/
