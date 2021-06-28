//hladke
//
$fa=1;
//
$fs=0.4;
//_

d_r32=32*2;
wt=10;

pruhlednost=0.5;
//pruhlednost=1.0;

//m
module klic_bez_der_2d()
//color("lime", pruhlednost)
union()
{
scale([
        //0.5777777778,
        ((26*2))/(90/100)*0.01,
        //((26*2)/(90/100))/100,
        1,
        1])
circle(d=90);

translate([
        -164.9/2,
        0,
        0])
square([164.9,
        50],
        center=true);
translate([
        -164.9,
        0,
        0])
circle(d=50);
}

module r32()
translate([+13.8,0,0])
circle(d=d_r32);

module klic_s_dirama_2d()
//pro_mereni
/*
translate([
        13.8,
        0,
        0])
square([
    32*2,
    40],
    center=true);
*/

{
difference()
 {
klic_bez_der_2d();
union()
  {    
intersection()
   {    
r32();
//pro prunik s kruhem
//+3 pro korekci rohu
//ale je to spravne???
translate([
        -100/2-13.8+3,
        //-100/2+13.8,
        0,
        0])
square([
        100,
        40],//+30
        center=true);
   }
//vyrez levy kruh
translate([
        -164.9,
        0,
        0])
circle(d=34);   
//orezovy vnitrni pravy
translate([
        100/2-13.8+3,
        0,
        0])
square([
        100,
        40],
        center=true);
  }
 }
}

module klic_s_dirama_3d()
    //color("lime", 1.0)
    linear_extrude(
    height=wt,
    center=true)
    klic_s_dirama_2d();

//_m

//klic_bez_der_2d();
//klic_s_dirama_2d();
klic_s_dirama_3d();
