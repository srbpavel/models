//hladke
//
$fa=1;
//
$fs=0.4;
//_

oval_delka=70;
oval_sirka=20;
oval_wt=5;
dira_vnejsi_vyska=7;

roztec_der=56.8;
roztec_der_vnitrnich=31.6;
roztec_rozdil=12.7;

prumer_der=8;
prumer_vnejsi_diry=12;

r64_5=64.5*2;

//m
module oval()
 difference()
 {
 square([
        oval_delka,
        oval_sirka],
        center=true);
 square([roztec_der_vnitrnich,
        4],
        center=true);
 dira();
 mirror([1,0,0])
 dira();
 translate([
        +roztec_rozdil,
        0,
        0])
 dira();
 mirror([1,0,0])
 translate([
        +roztec_rozdil,
        0,
        0])
 dira();
     
     }
        
module dira()
 translate([
     roztec_der_vnitrnich/2,
     0,
     0])
 circle(d=prumer_der);

module r645()
 translate([0,
            -44-0.18,
             0])
 {
 difference()
  {
  circle(d=r64_5);
  translate([0,-21+0.18,0])
  square([200,150], 
        center=true);
  }
 }

module oval_s_vyrezem_2d()
union()
{ 
oval();
r645();
mirror([0,1,0])
r645();
}

module dira_vnejsi()
{ 
translate([
    +roztec_der/2,
    0,
    0])
 difference()
 {
 cylinder(
    h=dira_vnejsi_vyska,
    d=prumer_vnejsi_diry,
    center=true);
 //+10 pro lepsi viditelnost
 cylinder(
    h=dira_vnejsi_vyska+10,
    d=prumer_der,
    center=true);
 }
}

module oval_s_vyrezem_3d()
 linear_extrude(
    height=oval_wt,
    center=true)
    oval_s_vyrezem_2d();

//_m
        
//oval_s_vyrezem_2d();
oval_s_vyrezem_3d();

dira_vnejsi();
mirror([1,0,0])
dira_vnejsi();