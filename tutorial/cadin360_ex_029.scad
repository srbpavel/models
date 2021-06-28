//hladke
//
$fa=1;
//
$fs=0.4;
//_

d_prumer_ozubu=60;
d_prumer_vnitrni=30;
d_prumer_naboj=40.5;

vyska_ozub=20;
vyska_vnitrni=10;
vyska_naboj=5;
pocet_zubu=20;

r25=25*2;
zub_sirka_vnejsi=2.4;
zub_sirka_vnitrni=6;

//m
module zub()
{
vyska_zubu=
    d_prumer_ozubu/2-r25/2;
//mozna dam x->-1 kvuli pruniku
p0=[0,-1];
p1=[
    zub_sirka_vnitrni/2
    ,-1];
p2=[zub_sirka_vnejsi/2,
    vyska_zubu];
p3=[0,
    vyska_zubu];
points=[
    p0,
    p1,
    p2,
    p3,
    ];
//posunuti zubu
//translate([
  //      0,
    //    d_prumer_naboj/2,
      //  0])
//otoceni zubu
rotate([0,0,-90])
union()
{
polygon(points);
mirror([1,0,0])
polygon(points);
}
}

//promeny musi byt pred module
r=r25/2; //polomer
n=pocet_zubu; //pocet opakovani
krok=360/n;

module zuby_pro_kolo()
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
     zub();	 
    }
   }
}

module ozubene_kolo_2d()
    //kontrolni
    //%circle(d=d_prumer_ozubu);
    color("magenta", 1.0)
    union()
    {
    difference()
     {
    circle(d=r25);
    circle(d=d_prumer_vnitrni);
     }
    zuby_pro_kolo();
    }

module ozubene_kolo_3d()
    //color("lime", 1.0)
    linear_extrude(
    height=vyska_ozub,
    center=true)
    ozubene_kolo_2d();

module vybrani_naboj()
    translate([
        0,
        0,
        +5+2.5+1-0.5])
    cylinder(
    h=vyska_naboj+1,
    d=d_prumer_naboj,
    center=true);

//_m


//ozubene_kolo_2d();
///*
difference()
{
ozubene_kolo_3d();    
vybrani_naboj();
mirror([0,0,1])
vybrani_naboj();
}
//*/