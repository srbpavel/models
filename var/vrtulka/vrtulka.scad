//PROPELLET

//$fn=50;

vnejsi_prumer = 110;
vnitrni_prumer = 30;

pocet_lopatek = 8;

vnejsi_sirka = 50;
vnitrni_sirka = 20;

wt_material = 2;

zakriveni = -30;

uhel = 45;


module lopatka() 
    {
        // 1
        vnitrni_vyska = cos(asin(vnitrni_sirka/(vnitrni_prumer)))*vnitrni_prumer;
        vyska_lopatky = vnejsi_prumer - vnitrni_vyska;

        /*translate([0, vnitrni_vyska, 0])
        rotate([-90, 0, 0])
        linear_extrude( 
            height = vyska_lopatky, 
            twist = zakriveni, 
            slices = 10, // 10 / 25 pocet trojuhelniku pro vyhlazeni
            convexity = 10
        ) 
        square([vnejsi_sirka, wt_material], center = true);*/
        
        // 2
        uhel = atan( 
                  ( ( vnejsi_sirka / 2 * cos( abs( zakriveni ) ) ) - 
                    ( vnitrni_sirka / 2 ) 
                  ) / vyska_lopatky 
            );    
        
        vyska = sin( abs( zakriveni ) ) * vnejsi_sirka / 2 + 
                 wt_material;
        
        sirka = vnejsi_sirka / 2 - vnitrni_sirka / 2;
        
        hloubka  = 
            sqrt( 
                pow( ( vnejsi_sirka / 2 * cos( abs( zakriveni ) ) ) - 
                     ( vnitrni_sirka / 2 ), 2 ) + 
                pow( vyska_lopatky, 2 )
            ) + wt_material;


        /*difference(){
            translate( [0, vnitrni_vyska, 0] )
            rotate( [-90, 0, 0] )
            linear_extrude( 
                height    = vyska_lopatky, 
                twist     = zakriveni, 
                slices    = 10 , 
                convexity = 10
            ) 
            square([vnejsi_sirka, wt_material], center = true );            
                                        
            for (i = [0 : 1])
            mirror( [i, 0, 0] )
            translate([
                vnitrni_sirka / 2,
                vnitrni_vyska,
                -vyska
            ])
            rotate( [0, 0, -uhel] )
            translate( [0, -hloubka / 2, 0] )
            cube( [sirka * 2, hloubka * 1.5, 2 * vyska] );

        }*/
        
        /*difference() {

            translate( [0, vnitrni_vyska, 0] )
            rotate( [-90, 0, 0] )
            linear_extrude( 
                height    = vyska_lopatky, 
                twist     = zakriveni, 
                slices    = 10 , 
                convexity = 10
            ) 
            translate([
                -vnejsi_sirka / 2,
                -wt_material / 2
            ])
            polygon( concat(
                [for (i = [0 : pocet_lopatek]) 
                    [i * vnejsi_sirka / pocet_lopatek, (i % 2) * 0.0001]
                ],
                [for (i = [pocet_lopatek : -1 : 0]) 
                    [i * vnejsi_sirka / pocet_lopatek, 
                     wt_material + (i % 2) * 0.0001]
                ]
            ));
        }*/
        
        
    }
    

lopatka();