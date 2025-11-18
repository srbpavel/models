//hladke
//
$fa=1;
//
$fs=0.4;
//_

//pruhlednost=0.5;
pruhlednost=1.0;

wt_steny=5;
d_diry=15;
r15=15*2;

a_strana_ctverce=30;
b_strana_ctverce=29;

l_obedlniku=55;
ll_obedlniku=25;
sirka_obdelniku=30;
h_obdelniku=50;
hh_obdelniku=20;

roztec_der_vodorovne=40;
roztec_der_svisle=35;

//m
module l_ko_bez_der()
union()
{
p0=[0,0];
p1=[sirka_obdelniku,0];
p2=[sirka_obdelniku,
    hh_obdelniku];
p3=[sirka_obdelniku
    +
    ll_obedlniku,
    hh_obdelniku];
p4=[sirka_obdelniku
    +
    ll_obedlniku,
    hh_obdelniku
    +
    sirka_obdelniku];
p5=[0,
    hh_obdelniku
    +
    sirka_obdelniku];
points=[
    p0,
    p1,
    p2,
    p3,
    p4,
    p5
    ];
polygon(points);
translate([r15/2,0,0])
circle(d=r15);
translate([
r15/2+roztec_der_vodorovne,
roztec_der_svisle,
0])
circle(d=r15);
}

module l_ko_s_dirama_2d()
difference()
{
l_ko_bez_der();
//union()
//{
//spodni
translate([
    r15/2,
    0,
    0])
circle(d=d_diry);
//horni_leva

translate([
    r15/2+roztec_der_vodorovne,
    roztec_der_svisle,
    0])
circle(d=d_diry);
//horni_prava

translate([
    r15/2,
    roztec_der_svisle,
    0])
circle(d=d_diry);
//}
}

module ctverec_s_dirou()
difference()
{
square([
 b_strana_ctverce,
 a_strana_ctverce],
 center=true);
circle(d=d_diry);
}

module l_ko_s_dirama_3d()
    rotate([90,0,90])
    //color("lime", 1.0)
    linear_extrude(
    height=wt_steny,
    center=true)
    l_ko_s_dirama_2d();

module krychle_bez_der()
 cube([
    //width=
b_strana_ctverce,
    //depth=
a_strana_ctverce,
    //height=
a_strana_ctverce],
    center=true);

module valecek(vyska)
cylinder(
    h=vyska+10,
    d=d_diry,
    center=true);

module krychler_s_dirama()
difference()
{
krychle_bez_der();
//svisly osa-z
///*
color("magenta", pruhlednost)
mirror([0,0,0])
valecek(vyska=29);
//*/
//vodorovny osa-y
color("lime", pruhlednost)
mirror([0,1,1])
valecek(vyska=29);
//vodorovny osa-x
color("blue", pruhlednost)
rotate([0,90,0])
valecek(vyska=29);
}

//_m

//l_ko_bez_der();
//
//l_ko_s_dirama_2d();

//rotate([90,0,90])
//levo-
translate([
    -b_strana_ctverce/2
    +
    wt_steny/2,
    0,
    0])
l_ko_s_dirama_3d();
//pravo+
translate([
    +b_strana_ctverce/2
    -
    wt_steny/2,
    0,
    0])
l_ko_s_dirama_3d();

//hele ona je to krychle, nema to wt
//ctverec_s_dirou();
translate([
    0,
    a_strana_ctverce/2,
    h_obdelniku
    -
    a_strana_ctverce/2])
krychler_s_dirama();


