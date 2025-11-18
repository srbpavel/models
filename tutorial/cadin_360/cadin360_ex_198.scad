//hladke
//
$fa=1;
//
$fs=0.4;
//_

vnejsi_delka=120;
vnejsi_d=50;

vnitrni_delka=120;
vnitrni_d=30;

prumer_priruby=100;
pocet_der=6;
prumer_pozice_der=75;
prumer_dira_v_prirube=12;

prumer_male_priruby=65;

module trubka(h,d)
cylinder(h=h,
         d=d,
         center=true);

module tecko(h,d)
//slouceni trubek na T
union()
{
rotate([+0, +90, 0])
 trubka(h=h,
        d=d);

translate([0, -80/2, 0])
scale([1, 1/1.5, 1])
rotate([+90, +0, 0])
 trubka(h=h,
        d=d);
}


//vnitrni dira v T
//%
difference()
{
//tecko vnejsi
tecko(h=vnejsi_delka,
      d=vnejsi_d);

//tecko vnitrni
//+10 posun at to vidim
#tecko(h=vnitrni_delka+10-10,
      d=vnitrni_d);
}

module priruba_2d(d)
    circle(d=d);

module dira_2d(d)
    //color("lime", 1.0)
    circle(d=d);

module priruba_2d_s_dirama()
difference()
{
//samotna priruba
priruba_2d(d=prumer_priruby);
//diry obvodove
krok=360/pocet_der;
for (i=[0:krok:360-krok])
{
 uhel=i;//+90; //start na 12hodin
 dx=(prumer_pozice_der/2)*cos(uhel);
 dy=(prumer_pozice_der/2)*sin(uhel);
  translate([dx, dy, 0])
   {
   rotate([-0, -0, i])
    {
     dira_2d(
      d=prumer_dira_v_prirube);
    }
   }
//_for
}
//vnitrni trubko dira
//+1 pac to kreslilo skrz
dira_2d(d=vnitrni_d+1);
//_difference
}

module priruba_3d()
 linear_extrude(height=10,
                center=true)
 priruba_2d_s_dirama();

//pozice priruby na T
translate([0, -80+10, 0])
rotate([+90, +0, +0])
    priruba_3d();

module priruba_mala_2d()
    difference()
    {
    priruba_2d(
        d=prumer_male_priruby);
    //+1 nekresli uvnitr
    dira_2d(d=vnitrni_d+1);
    }
    
module priruba_mala_3d()
    translate([vnejsi_delka/2-10, 0, 0])
    rotate([+0, +90, +0])
    {
    linear_extrude(height=10,
                center=true)
    priruba_mala_2d();
    }

//pozice male priruby na T
priruba_mala_3d();
// opacna -x strana
mirror([1, 0, 0])
priruba_mala_3d();

module r2()
translate([vnejsi_delka/2-5+1, 
    0, 
    +0])
rotate([+0, +90, +0])
color("lime", 1.0)
rotate_extrude(angle=360)
translate([+25+1, 0, +0])
difference()
{       
square([2,2],
        center=true);
translate([1, 1, 0])
circle(d=4);
}

//vnejsi radiusy
r2();
mirror([1, 0, 0])
r2();

//vnitrni radiusy
translate([-vnejsi_delka+20,
            0, 
            0])
            r2();

mirror([1, 0, 0])
translate([-vnejsi_delka+20,
            0, 
            0])
            r2();

//radius na velky prirube
translate([0, -120, 0])
rotate([0, 0, +90])
r2();

///*
module r45()
color("magenta", 1.0)
rotate_extrude(angle=360)
//posun pro polomer rotace
translate([+25+1-1-10-1, 0, +0])

mirror([1,0,0])
difference()
{       
//zakladni ctverec
square([2,2],
        center=true);

//rotacni na orez pro 45stupnu
translate([+1,+1,0])
rotate([+0, +0, -45])
square([3,3],
        center=true);
}

//posun ven z priruby
translate([-0, -79.12, +0])
rotate([+90,+0,0])
r45();
//*/
