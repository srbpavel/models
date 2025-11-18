//hladke
//
$fa=1;
//
$fs=0.4;
//_

sirka_zakladny=20;
d_r20=40;
d_r60=120;
d_dira_zakladna=20;

sirka_klinu=20;
d_dira_klin=30;
d_r30=60;
d_r15=30;

//m
module r20()
 translate([-40-20/2,0,0])
 circle(d=d_r20);
 
module r60()
 difference()
 {
 translate([-40,-40,0])
 //+1 aby to nedelelo mezeru
 square([40+1,
        40+1],
        center=true);
 translate([
    -100/2-30+1+0.5,
    -80/2-10-30+5.5+0.1,
    0])
 circle(d=d_r60);
 }
 
module dira_zakladna()
 translate([-40-20/2,0,0])
 circle(d=d_dira_zakladna);

module zakladna_t()
union()
{
square([40+20+40,
        d_r20],
        center=true);
translate([0,-d_r20/2,0])
square([d_r20,
        80],
        center=true);
}

///_m

module zakladna_s_dirama_2d()
difference()
{
union()
 { 
zakladna_t();
//%
r20();
mirror([1,0,0])
//%
r20();
translate([+40+20/2,
           -80+d_r20/2,
           0])
//%
r20();
r60();
mirror([1,0,0])
r60();
 }

//#
 dira_zakladna();
mirror([1,0,0])
//#
dira_zakladna();
 translate([+40+20/2,
            -80+20,
            0])
//#
dira_zakladna();
}

//klin
module klin_2d()
//na diru
difference()
{
//na radius r15
difference()
{
union()
 {
//radius velkej
translate([94.2,
           d_r30/2,
           0])
  {
  circle(d=d_r30);
  }
//_
//k
p0=[0, 0];
p1=[94.2, 0];
//...
p2=[94.2, 60];
p21=[94.2-13, 60-3];
p3=[0,20/2];
p4=[0,20/2];
p5=[0,20/2];
points=[
    p0,
    p1,
    p2,
    p21,
    p3,
    p4,
    p5
    ];
polygon(points);
//_k
 }
//radius malej
translate([0,
           15+10,
           0])
    {
    circle(d=d_r15);
    }
//_
}
//dira klin
translate([
            94.2,
            d_r30/2,
            0])
circle(d=d_dira_klin);
}
//_m_klin

module klin_3d()
{
 linear_extrude(
    height=sirka_klinu,
    center=true)
    klin_2d();
}

module zakladna_s_dirama_3d()
{
 linear_extrude(
    height=sirka_zakladny,
    center=true)
    zakladna_s_dirama_2d();
    
}

//zakladna_s_dirama_2d();
zakladna_s_dirama_3d();

//klin_2d();
translate([ -0,
            20-54.2,
            +10-10])
rotate([+90,+0,+90])
klin_3d();
