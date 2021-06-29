//https://eribuijs.blogspot.com/2017/03/creating-complex-shapes-openscad.html

function circle(radius) = 
        [for (phi = [1 : 1 : 720]) 
            [radius * cos(phi/2), radius * sin(phi)]
        ];

//echo(circle(20));

//polygon(circle(20));
        
        
function ellipse(r1, r2) = 
        [for (phi = [1 : 1 : 360]) 
            [r1 * cos(phi), r2 * sin(phi)]
        ];
        
//polygon(ellipse(40,20));
        
function sine_wave(range, enlarge)=
        [for 
            (theta=[0:1:range]) 
                [theta,enlarge*sin(theta)]
            
        ];
    
polygon(sine_wave(360+360,100));