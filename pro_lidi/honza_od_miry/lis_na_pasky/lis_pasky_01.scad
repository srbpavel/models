//hladke
//
$fa=1;
//$fs=0.4;
//_


kolo_prumer_vnejsi=120;
kolo_prumer_vnitrni=40;
kolo_prumer_naboj=60;
kolo_sirka=70;
kolo_sirka_naboj=80;

orezovy_valec_prumer=135;
orezovy_valec_vyska=200;

pocet_vzoru=5;
r=kolo_prumer_vnejsi/2; //polomer
n=pocet_vzoru; //pocet opakovani
krok=360/n;

module prurez_2d_pul()
{
p0=[0,0];
p1=[kolo_prumer_vnejsi/2,
    0];
//r45
p2=[kolo_prumer_vnejsi/2,
    kolo_sirka/2-2];
p21=[kolo_prumer_vnejsi/2-2,
    kolo_sirka/2];
p3=[kolo_prumer_naboj/2,
    kolo_sirka/2];
p4=[kolo_prumer_naboj/2,
    kolo_sirka_naboj/2+20];
p5=[0,
    kolo_sirka_naboj/2+20];
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
//square([20,40],
square([20,60],
       center=false);
 }
}

module vzor_2d()
//rotate([+90,+90,+90])
//color("magenta", 1.0)
//tady pak bude nejaky svg/dxf kapr nebo co
/*
scale([
    0.5,
    1.2,
    1.0])
*/
difference()
{
circle(d=2*25);
//circle(d=2*20);
}

module vzor_3d()
rotate([+90,+90,+90])
linear_extrude(
    height=25,
    center=true)
{
    vzor_2d();
}

//test
//#vzor_3d(); 

module vzory_pro_kolo()
for (i=[0:krok:360-krok])
{
 uhel=i;//+90; //start na 12hodin
 dx=r*cos(uhel);
 dy=r*sin(uhel);
  translate([dx, dy, 0])
   {
   rotate([-0, -0, i])
    {
	 //color("lime", 1.0)
     vzor_3d();	 
    }
   }
}

module orezovy_valec()
cylinder(
    h=orezovy_valec_vyska,
    d=orezovy_valec_prumer,
    center=true);

module prurez_2d()
{
prurez_2d_pul();
mirror([0,1,0])
prurez_2d_pul();
}

//kontrolni zobrazeni 2d
//prurez_2d();
//prurez_2d_pul();

///*
module kolo_3d()
rotate([0,+90,+0])
rotate_extrude(angle=360)
prurez_2d();
//*/

///*
#intersection()
{
rotate([+0,+90,+0])
orezovy_valec();
rotate([+0,+90,0])
vzory_pro_kolo();
 }
//*/

//%
kolo_3d();

//rotate([+0,+90,0])
//vzory_pro_kolo();

//https://blog.prusaprinters.org/cs/jak-na-animace-modelu-v-programu-openscad_33955/
//pro animaci - viewport
//translate
$vpt = [0, 0, 0];
//rotate
$vpr = [
        55, 
        0, 
        360 * $t //25 rotace podle Z
        ];
 //distance
$vpd = 500;
 
