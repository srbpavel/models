//hladke
//
$fa=1;
//
$fs=0.4;
//_

pruhlednost=1.0;
//pruhlednost=1.0;

d_prumer_vnitrni=32;
d_prumer_vyvyseni=40;
d_prumer_stred_der=60;
d_prumer_kraj_der=72;
d_prumer_vnejsi=80;

d_prumer_dira=8;

wt_zakladna=5;
wt_vyvyseni=5;

r10=10*2;
r6=6*2;

pocet_zubu=6;

//m

module zakladna_vzor()
difference()
{
union()
 {
square([20,
        r10,],
        center=true);
translate([
            10,
            0,
            0])
circle(d=r10);
 }
translate([
           10,
            0,
            0])
circle(d=d_prumer_dira);
}

module vyvyseni_vzor()
difference()
{
union()
 {
square([20,
        r6,],
        center=true);
translate([
            10,
            0,
            0])
circle(d=r6);
 }
translate([
           10,
            0,
            0])
circle(d=d_prumer_dira);
}

//promeny musi byt pred module
///r=d_prumer_vnejsi/4; //polomer
///n=pocet_zubu; //pocet opakovani
///krok=360/n;

module zakladna_2d(r,n)
difference()
{
for (i=[0:360/n:360-360/n])
 {
 uhel=i;//+90; //start na 12hodin
 dx=r*cos(uhel);
 dy=r*sin(uhel);
  translate([dx, dy, 0])
  {
   rotate([-0, -0, i])
   {
	 //color("lime", 1.0)
     zakladna_vzor();	 
   }
  }
 }
circle(d=d_prumer_vnitrni);
}

module zakladna_3d()
    //color("lime", 1.0)
    linear_extrude(
    height=wt_zakladna,
    center=true)
    zakladna_2d(
        r=d_prumer_vnejsi/4,
        n=pocet_zubu);

module vyvyseni_2d(r, n)
difference()
{
union()
 {
for (i=[0:360/n:360-360/n])
  {
 uhel=i;//+90; //start na 12hodin
 dx=r*cos(uhel);
 dy=r*sin(uhel);
  translate([dx, dy, 0])
   {
   rotate([-0, -0, i])
    {
	 //color("lime", 1.0)
     vyvyseni_vzor();	 
    }
   }
  }
circle(d=d_prumer_vyvyseni);
 }
 circle(d=d_prumer_vnitrni);
}

module vyvyseni_3d()
    //color("lime", 1.0)
    linear_extrude(
    height=wt_vyvyseni,
    center=true)
    vyvyseni_2d(
        r=d_prumer_vnejsi/4,
        n=pocet_zubu);

//_m
//kontrolni_kolo
//%circle(d=d_prumer_vnejsi);

//%circle(d=d_prumer_vnitrni);

//%circle(d=d_prumer_vyvyseni);

//zakladna_vzor();
//vyvyseni_vzor();


/*
vyvyseni_2d(
    //r=d_prumer_kraj_der/4,
    r=d_prumer_vnejsi/4,
    n=pocet_zubu);
*/

//
//
/*%zakladna_2d(
        r=d_prumer_vnejsi/4,
        n=pocet_zubu);
//
*/
color("orangered", pruhlednost)
zakladna_3d();
translate([
        0,
        0,
        wt_zakladna])
color("dodgerblue", pruhlednost)
vyvyseni_3d();
