//hladke
//
$fa=1;
//
$fs=0.4;
//_

trubka_vyska=200;
trubka_prumer_vnejsi=40;
trubka_prumer_vnitrni=20;

prumer_dira_trojuhelnik=0;

strana_ctverce=10;
prumer_radiusu=20;

//////

module trubka_2d()
difference()
{
circle(d=trubka_prumer_vnejsi);
circle(d=trubka_prumer_vnitrni);
}

module trubka_3d()
{
linear_extrude(
    height=trubka_vyska-prumer_radiusu/2,
    center=true)
    trubka_2d();
}

module r10_concave()
{
    rotate_extrude(angle=360)
    translate([+10, 0, 0])
    difference()
    {
    circle(d=prumer_radiusu);
    translate([0,-5,0])
    square([20,10],
        center=true);
    translate([-5,-0,0])
    square([10,20],
        center=true);
    }
}

///

module kridlo_s_dirou_2d()
translate([0,0,0])
{
//-1 zapusteni do trubky
p0=[-1,0];
p1=[60-20,0];
p2=[60-20+15/2+4.5,+28-4];
p3=[-1,79.6];
points=[p0, p1, p2, p3];
difference()
{
union()
 {
polygon(points);
translate([ 60-20, 
            30/2,
            0])
circle(d=30);
 }
translate([ 60-20, 
            30/2,
            0])
circle(d=20);
}
}

module kridlo_s_dirou_3d()
{
rotate([+90, 0, 0])
linear_extrude(
    height=10,
    center=true)            
kridlo_s_dirou_2d();
}

module tri_kridla()
{
r=trubka_prumer_vnejsi/2; //polomer
n=3; //pocet opakovani
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
	 kridlo_s_dirou_3d();
    }
   }
}
}

//%
union()
{    
translate([
        0, 
        0, 
        -prumer_radiusu/4])
trubka_3d();
translate([ 0,
            0,
            trubka_vyska/2-prumer_radiusu/2])
r10_concave();
}

translate([0,0,-100])
//%
tri_kridla();