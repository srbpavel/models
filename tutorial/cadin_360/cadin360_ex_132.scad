//hladke
//
$fa=1;
//
$fs=0.4;
//_

kolo_prumer_vnejsi=120;
kolo_prumer_vnitrni=40;
kolo_prumer_naboj=60;
kolo_sirka=70;
kolo_sirka_naboj=80;

module prurez_2d_pul()
{
p0=[0,0];
p1=[120/2,0];
//r45
p2=[120/2,70/2-2];
p21=[120/2-2,70/2];
p3=[60/2,70/2];
p4=[60/2,80/2];
p5=[0,80/2];
points=[
    p0,
    p1,
    p2,
    p21,
    p3,
    p4,
    p5
    ];

difference()
 {
polygon(points);
square([20,40],
       center=false);

translate([
    93.2/2+30,
    0,
    0])
color("magenta", 1.0)
circle(d=2*30);

//kontrolni zobrazeni
/*
translate([40,25,0])
%square([20,10],
       center=false);
*/
 }
}

module prurez_2d()
{
prurez_2d_pul();
mirror([0,1,0])
prurez_2d_pul();
}

//kontrolni zobrazeni 2d
//prurez_2d();

///*
module kolo_3d()
rotate([0,+90,+0])
rotate_extrude(angle=360)
prurez_2d();
//*/

//%
kolo_3d();



