$fa=1;
$fs=0.4;

vnejsi_d=90;
stredni_d=78;
vnitrni_d=50;

sirka_zubu=10;

/* kontroloa vnejsiho polomeru

#circle(d=vnejsi_d);
*/

difference()
{
 circle(d=stredni_d);
 circle(d=vnitrni_d);
}


r=stredni_d/2; //polomer
n=16; //pocet opakovani
krok=360/n;


for (i=[0:krok:360-krok])
{
 uhel=i;//+90; //start na 12hodin
 dx=r*cos(uhel);
 dy=r*sin(uhel);
  translate([dx, dy, 0])
   {
   rotate([-0, -0, i])
    {
	 color("lime", 1.0)
	 square([vnejsi_d-stredni_d,
		 sirka_zubu],
	      center=true);
    }
   }
}



	
