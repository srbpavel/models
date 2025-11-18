//hladke
//
$fa=1;
//
$fs=0.4;
//_

//pruhlednost=0.5;
pruhlednost=1.0;

wt_zakladna=20;
wt_vystupujici=30;

d_trubka_horni_vnejsi=40;
d_trubka_horni_vnitrni=30;

d_vystupek_spodni_vnejsi=55;
d_vystupek_spodni_vnitrni=20;
d_vystupek_diry=12;
d_pozice_stredu_der=38;

pocet_der_v_vystupku=4;

roztec_der_hornich=65;

vyoseni_horni_dolni=100;
vyoseni_leva_prava=45;

r20=20*2;
r98=98*2;

//m
module trubky()
translate([
    -roztec_der_hornich/2,
    0,
    0])
difference()
{

color("green", 0.3)
circle(d=
    d_trubka_horni_vnejsi);
/*
circle(d=
    d_trubka_horni_vnitrni);
*/
}

//vystupek
module vystupek(r, n)
translate([
    10+5/2,
    -vyoseni_horni_dolni,
    0])
{
difference()
{
union()
 {
difference()
  {
color("green", 0.3)      
circle(d=
    d_vystupek_spodni_vnejsi);
/*
circle(d=
    d_vystupek_spodni_vnitrni);
*/
  }
 } 
//rotace_der
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
     /*
      circle(
      d=d_vystupek_diry);
     */  
     }
    }
   }
  }
//_rotace
//_vystupek
 } 
}

module placicka_bez_der_2d()
union()
{
trubky();
mirror([1,0,0])
trubky();

//kontrolni_ctverec
//
/*
translate([
    -roztec_der_hornich/2+45/2,
    -100/2,
    0])
%square([
    45,
    100],
    center=true);
*/
//_

//
//r=stred der pro rotaci
vystupek(
    r=(38)/2,
    n=pocet_der_v_vystupku);

///*
//r98
//color("blue", pruhlednost)
difference()
{
intersection()
 {
translate([
    +37+0.6+0.035,
    -34-0.1-0.025,
    0])
circle(d=r98);

translate([
    -100,
    -100+10,
    0])
square([210,
        200],
        center=true);
 }
translate([
    0,
    23+0.25+0.0671,
    0])
circle(d=r20);
}
//_r98
//*/

//r20
//color("lime", pruhlednost)
difference()
{
translate([
    0,
    +7,
    0])
square([34,
        30],
        center=true);

color("lime", 0.5);
translate([
    0,
    23+0.25+0.0671,
    0])
circle(d=r20);
}
//_r20

//hrana100
translate([
        +38+1.5+0.46
-0.4,//+0
        -100
-5,//+0
        0])
rotate([
        0,
        0,
        -7.25+0.02
+0.2-0.07//+0
])
mirror([1,0,0])
square([20,98-0.5
+6.5//+0
],
        center=false);
//_hrana100

//druhej_kontrolni_pro hranu
//
/*
translate([0,-100-55/2,0])
%square([100,55/2],
        center=false);
        
translate([0,-100,0])
#square([100,55/2],
        center=false);
//
*/
//_druhej

//zakryti_diry
translate([
    20,
    -40,
    0])
square([
        40,
        80],
        center=true);
//_zak
}
//_placicka_bez_der

module placicka_s_dirama_2d()
difference()
{
placicka_bez_der_2d();

//diry na diff
//leva
translate([
    -roztec_der_hornich/2,
    0,
    0])
circle(d=
    d_trubka_horni_vnitrni);
//prava
translate([
    +roztec_der_hornich/2,
    0,
    0])
circle(d=
    d_trubka_horni_vnitrni);
//spodni
translate([
    10+5/2,
    -vyoseni_horni_dolni,
    0])
circle(d=
    d_vystupek_spodni_vnitrni);
//rotace ctyr malejch
translate([
    10+5/2,
    -vyoseni_horni_dolni,
    0])
 {
for (i=[0:(360/4):360-(360/4)])
   {
 uhel=i;//+90; //start na 12hodin
 dx=((38)/2)*cos(uhel);
 dy=((38)/2)*sin(uhel);
  translate([dx, dy, 0])
    {
   rotate([-0, -0, i])
     {
	 //color("lime", 1.0)
     circle(
      d=d_vystupek_diry);
     }
    }
   }
 }
}
//_pacicka s dirama_2d

module placicka_s_dirama_3d()
    linear_extrude(
    height=wt_zakladna,
    center=true)
    placicka_s_dirama_2d();

module trubicky_horni()
translate([
    -roztec_der_hornich/2,
    0,
    0])
color("grey", pruhlednost)
difference()
{
cylinder(
    h=wt_vystupujici,
    d=d_trubka_horni_vnejsi,
    center=true);
cylinder(
    h=wt_vystupujici+10,
    d=d_trubka_horni_vnitrni,
    center=true);
}

//_m

//placicka_bez_der_2d();
//placicka_s_dirama_2d();
color("darkred", pruhlednost)


///placicka_s_dirama_3d();

/*///
trubicky_horni();
mirror([1,0,0])
trubicky_horni();
*////

color("orangered", pruhlednost)
///
*translate([
    10+5/2,
    -vyoseni_horni_dolni,
    0])
difference()
{
cylinder(
h=wt_vystupujici,
d=d_vystupek_spodni_vnejsi,
center=true);
 {
cylinder(
h=wt_vystupujici+10,
d=d_vystupek_spodni_vnitrni,
center=true);
     
for (i=[0:(360/4):360-(360/4)])
   {
 uhel=i;//+90; //start na 12hodin
 dx=((38)/2)*cos(uhel);
 dy=((38)/2)*sin(uhel);
  translate([dx, dy, 0])
    {
   rotate([-0, -0, i])
     {
	 //color("lime", 1.0)
     cylinder(
        h=wt_vystupujici+10,
        d=d_vystupek_diry,
        center=true);
     }
    }
   }
 }    
}

trubky();
vystupek(
    r=(38)/2,
    n=pocet_der_v_vystupku);

p0=[-roztec_der_hornich/2,
    0];
p1=[10+5/2,
    0];
p2=[10+5/2,
    -vyoseni_horni_dolni];
points=
    [
    p0,
    p1,
    p2
    ];
%polygon(points);

prepona=105.148;
    /*
    sqrt(    
    pow(2, 
        roztec_der_hornich/2)
    +
    pow(2,
        vyoseni_horni_dolni)
    );
    */
echo(prepona);

prepona_pul_vyska=
    sqrt(
    pow(2, prepona)
    -(
    pow(2,
    (roztec_der_hornich/4
    +
    (10+5/2)/2)
    )))
    ;
echo(prepona_pul_vyska);

translate([
    //1
    -roztec_der_hornich/4
    +
    (10+5/2)/2,
    //2
    //-is_num(prepona_pul_vyska)
    -50
    ,
    //3
    0])
{
#circle(d=prepona);
circle(d=2);
}