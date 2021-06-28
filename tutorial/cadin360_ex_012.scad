//hladke
//
$fa=1;
//
$fs=0.4;
//_

//pruhlednost=0.5;
pruhlednost=1.0;

d_kruh_horni_vnejsi=38;
d_kruh_horni_vnitrni=20;
trubka_horni_wt=30;

d_kruh_dolni_vnejsi=64;
d_kruh_dolni_vnitrni=34;

pakna_wt=10;

d_r64=64*2;

//m
module pakna_2d()
 {
 circle(d=d_kruh_horni_vnejsi);
  translate([
            0,
            -75,
            0])
  
  circle(d=d_kruh_dolni_vnejsi);
 }
 
module r64()
 difference()
 {
 translate([
        -16,
        -30,
        0])
 square([35,
         60-7], 
        center=true); 
 translate([-75-5+0.1-0.05,
            -75/2+5+10+0.5,
             0])
 circle(d=d_r64);
 }
  
module pakna_bez_der_2d()
union()
 {
 pakna_2d();
 r64();
 mirror([1,0,0])
 r64();
 }
 
module pakna_s_dirama_2d()
 difference()
 {
 pakna_bez_der_2d();
 circle(d=d_kruh_horni_vnitrni);
 translate([0,-75,0])
 circle(d=d_kruh_dolni_vnitrni);
 }
 
 module pakna_s_dirama_3d()
    color("DodgerBlue", pruhlednost)
    linear_extrude(
    height=pakna_wt,
    center=true)
    pakna_s_dirama_2d();
 
 module trubka_horni()
    color("magenta", pruhlednost)
    difference()
    {
    cylinder(
        h=trubka_horni_wt,
        d=d_kruh_horni_vnejsi,
        center=true);
    cylinder(
        h=trubka_horni_wt+10,
        d=d_kruh_horni_vnitrni,
        center=true);
    }
    
 module kontrolni_stred()
    {
    %cylinder(
        h=50,
        d=2,
        center=true);
    translate([0,-75,0])
    //bude polygon
    //kontrolni stred
    %cylinder(
        h=50,
        d=2,
        center=true);
    }
    
module trubka_spodni_2d()
{
p0=[0,0];
p1=[30,0];
p2=[30,(64-55)/2];
p3=[30-5,(64-55)/2];
p4=[30-5,(64-43)/2];
p5=[30+15,(64-43)/2];
p6=[30+15,(64-34)/2];
p7=[0,(64-34)/2];
points=[
    p0,
    p1,
    p2,
    p3,
    p4,
    p5,
    p6,
    p7,
    ];
translate([+30/2+34/2,0,0])
rotate([0,0,90])
polygon(points);    
}   

module trubka_spodni_3d()
color("lime", pruhlednost)
translate([0,-75,-30/2])
rotate([0,0,0])
rotate_extrude(angle=360)
trubka_spodni_2d();

 //_m

union()
{
 //pakna_bez_der_2d();
 //pakna_s_dirama_2d();
 pakna_s_dirama_3d();
 //color("blue", 1.0)
 trubka_horni();
 
 //kontrolni_stred();

 //trubka_spodni_2d();
 trubka_spodni_3d();
}

