//hladke
//
$fa=1;
//
$fs=0.4;
//_

d_kruh_vnejsi=100;
d_kruh_vnitrni=50;
kruh_vnejsi_wt=40;

zakladna_delka=116;
zakladna_patky_mezera=76;
zakladna_patka_sirka=20;
zakladna_patka_vyska=15;
zakladna_vyska=25;
zakladna_sirka=30;

ulozeni_kruhu_wt=10;
ulozeni_vyska_rovna=33.3;
ulozeni_sirka_rovna=96;
ulozeni_stred_vyska=120;
ulozeni_stred_vyoseni=106;
pozice_kruhu_v_ulozeni=145;
vyoseni_kruhu=50;

r149_1=149.1*2;
r45=45*2;
r3=3*2;

//m
module r45()
 translate([92.9+0.09,
            33.5+0.33,
            0])
 {
 //radius_velky
 difference()
  {
  translate([-60+2+2,
            +35+2,
             0])
  rotate([+0,
          +0,
          +57])
  square([90-20+10,
           90-30], 
        center=true);
  circle(d=r45);
      
      /*
      translate([
            0,
            -160,
            0])
  #square([300,
           300], 
        center=true);*/
  }
 }

module r149_1()
 translate([101.1,
            33.3,
            0])
 {
 //radius_velky
 difference()
  {
  circle(d=r149_1);
  translate([
            75,
            -0,
            0])
  square([300,
           400], 
        center=true);
  translate([
            0,
            -160,
            0])
  square([300,
           300], 
        center=true);
  }
 }


module prurez_zakladna_2d()
{
p0=[0,
    0];
p1=[zakladna_patka_sirka,
    0];
p2=[zakladna_patka_sirka,
    zakladna_patka_vyska];
p21=[zakladna_patka_sirka
    +
    zakladna_patky_mezera,
    zakladna_patka_vyska];
p3=[zakladna_patka_sirka
    +
    zakladna_patky_mezera,
    0];
p4=[zakladna_patka_sirka
    +
    zakladna_patky_mezera
    +
    zakladna_patka_sirka,
    0];
p5=[zakladna_patka_sirka
    +
    zakladna_patky_mezera
    +
    zakladna_patka_sirka,
    zakladna_vyska];
p6=[0,
    zakladna_vyska];
points=[
    p0,
    p1,
    p2,
    p21,
    p3,
    p4,
    p5,
    p6
    ];
polygon(points);
}

module prurez_zakladna_3d()
    color("magenta", 1.0)
    linear_extrude(
    height=zakladna_sirka)
    prurez_zakladna_2d();

module ulozeni()
    union()
   {
    translate([
    0,
    ulozeni_vyska_rovna/2,
    0])
    {
    square([ulozeni_sirka_rovna,
            ulozeni_vyska_rovna
            ],
            center=true);
    }
    
    
    translate([
    ulozeni_stred_vyoseni/2,
    ulozeni_stred_vyska,
    0])
    circle(d=d_kruh_vnejsi);
   } 
    
module ulozeni_s_radiusem_2d()
    difference()
    {
     union()
     {
     ulozeni();
     r149_1();
     r45();
     }
    
    
    {
    translate([
    ulozeni_stred_vyoseni/2,
    ulozeni_stred_vyska,
    0])
    circle(d=d_kruh_vnitrni);
    }
    
   }

module ulozeni_s_radiusem_3d()
    color("blue", 1.0)
    linear_extrude(
    height=ulozeni_kruhu_wt,
    center=true)
    ulozeni_s_radiusem_2d();

module naboj_2d()
   translate([
    ulozeni_stred_vyoseni/2,
    ulozeni_stred_vyska,
    0])
    difference()
    {
    circle(d=d_kruh_vnejsi);
    circle(d=d_kruh_vnitrni);
    }
    
module naboj_3d()
    color("lime", 1.0)
    linear_extrude(
    height=kruh_vnejsi_wt,
    center=true)
    naboj_2d();

//_m

//prurez_zakladna_2d();
 //ulozeni_s_radiusem_2d();
//naboj_2d();

//rotace pro lepsi kontrolu
//rotate([90,0,0])
union()
{
translate([
        -zakladna_delka/2,
        -zakladna_vyska,
        -zakladna_sirka/2])
prurez_zakladna_3d();
ulozeni_s_radiusem_3d();
translate([
            0,
            0,
            +kruh_vnejsi_wt/2-5])
    naboj_3d();
}
