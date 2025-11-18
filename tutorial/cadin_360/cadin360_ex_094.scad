//hladke
//
$fa=1;
//
$fs=0.4;
//_

pruhlednost=0.5;
//pruhlednost=1.0;

r2=2*2;
r20_b=20*2;
r50_c=50*2;

d_vnitrni_a=30;
d_vnejsi_d=120;

wt=10;

//m

//vnitrni
difference()
{
color("blue", pruhlednost)
circle(d=r20_b);

color("lime", pruhlednost)
//#
circle(d=d_vnitrni_a);
}

//vnejsi

difference()
{
#circle(d=d_vnejsi_d);

color("orangered", pruhlednost)
circle(d=r50_c);
}

//_m
/*
nula_x=0;
a=42.094;
b=55;
c=69.259;

p0=[nula_x,
    0];
p1=[b,
    0];
p2=[b,
    a];
points=[
    p0,
    p1,
    p2
    ];
%polygon(points);
mirror([0,1,0])
%polygon(points);
*/

//m_r2
module radius_r2()
difference()
     {
     //ctverec
     translate([
            -10-0.5+0.2
            ,//-r2/2,
            +7/2,//-r2/2,
            0])
     #square([
           r2-0.7,
           r2-0.7],
           center=true);
     //kolo
     translate([
            -10-0.5+0.2
            +r2/2
            ,
            +7/2
         +r2/2
            ,
            0])
     #circle(d=r2);
     }
//_m_r2

{
for (i=[0:360/8:360-360/8])
   {
 uhel=i;//+90; //start na 12hodin
 dx=(120/4)*cos(uhel);
 dy=(120/4)*sin(uhel);
  translate([dx, dy, 0])
    {
   rotate([-0, -0, i])
     {
	 //color("lime", 1.0)
     ///*
     translate([
            30/2-25/2,
            0,
            0])
     square([
            60-25,
            7],
        center=true);
     
     //radius_r2 in_horni
     translate([
            -0.2-0.15-0.06,
            -0.03,
            0])
     //tady radius_r2
     {
     radius_r2();
     }
     
     //radius_r2 in_spodni
     translate([
            -0.2-0.15-0.05,
            +0.03,
            0])
     //tady radius_r2
     {
     mirror([0,1,0])
     radius_r2();
     }
     
     /*
     //radius_r2 horni_in
     translate([
            -8-2+0.1-0.05,
            +1+0.5-0.2,
            0])
     rotate([
            0,
            0,
            -60+10])
     //tady radius_r2
     {
     radius_r2();
     }
     */
     
     //radius_r2 out_horni
     translate([
            +10-1+0.4+0.065,
            0-0.03,
            0])
     //tady radius_r2
     {
     mirror([1,0,0])
     radius_r2();
     }
     
     //radius_r2 out_spodni
     translate([
            +23+0.2+0.075,
            -14+0.2+0.035,
            0])
     //tady radius_r2
     {
     mirror([1,1,0])
     radius_r2();
     }
     
     }
    }
   }
  }



/*
hull()
{
//spodni_centralni
translate([
    r20/2,
    0,
    0])
circle(d=r2);

//obvodovy_horni
translate([
    (r50/2)*cos(45/2),
    (r50/2)*sin(45/2),
    0])
{
circle(d=r2);
}

//obvodovy_dolni
translate([
    (r50/2)*cos(45/2),
    -(r50/2)*sin(45/2),
    0])
circle(d=r2);
}
*/
