//CONFIG
$fn=50;

// tloustka plechu [mm]
wt_material = 5.0;

// delka_hrany [mm]
a = 150;

// prumer diry [mm]
d = 30;

a_pul = 150 / 2;
pow_a = pow(a, 2);
pow_a_pul = pow(a_pul, 2);

//vyska
h = sqrt(pow_a - pow_a_pul);

//stred soumernosti 
stred = tan(30) * a_pul;
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
        //posun trianglu
        translate([0, 0])
            {
            //TRIANGL
            triangl(hrana = a);
            }
            
            //posun diry
            translate([0, +stred])
            {
            //DIRA
            #dira(prumer_diry = d);    
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
