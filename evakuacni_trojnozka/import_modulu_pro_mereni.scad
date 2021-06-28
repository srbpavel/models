
translate([
    74,
    6,
    110])
rotate([90,0,0])
color("lime", 1.0)
square([10,59.5],
center=true);

translate([
    74,
    6,
    -38])
rotate([90,0,0])
color("magenta", 1.0)
square([10,210],
center=true);

//trojnozka
//
//config.scad na parametry
//dily z plechu na rezani laserem jako import/include
//trubky jako moduly tady

//include <zakladni_deska.scad>;
use <zakladni_deska.scad>;
rotate([+90, +0, +0])
translate([
        0, 
        0,
        -material_wt/2])
kotvici_deska_3d();

include <kridlo.scad>;
rotate([+90, +0, +90])
translate([-material_wt/2,
            0,
            0])
{
 for (a=[0:dokola/3:dokola])
  {
  rotate([0, a, +0])
  translate([bk_sirka/2+material_wt, 
      0,
      -material_wt/2])
  bocni_kridlo_3d();
  }
}

include <kryci_kruh.scad>;
translate([0, 0, +bk_vyska/2])
%kryci_kruh_3d();

//chci mit chytrej posun dopredu podle prepoctu o kolik to jde dolu, ale maka to kolmyho kridla ale ne u tech dvou zrotovanejch kua
//hele smazal jsem komenty modulu a maka to dobre?
include <patka.scad>;
//"y" koordinata je "a" strana trojuhelniku
/////patka_posune_vertikalni=0;
t_a=-patka_posun_vertikalni-bk_vyska/2-material_wt+patka_trubka_posun_vertikalni;
//t_a=-bk_vyska/2-material_wt;//sedi pod kridlem a kopiruje predni hranu
rotate([+0, +0, 90])
translate([0-material_wt/2,
           0,
           0])
{
 for (a=[0:dokola/3:dokola])
  {
  rotate([0, 0, +a])
  translate([
      11-t_a/tan(70)+bk_sirka/2+50, //korekce_na_stred - dopredu/dozadu 
      0,
      t_a //posun dolu/nahoru
      ])
  patka_s_dirama_3d();
  }
}

include <hranol_na_lano.scad>;
//t_aa vertikalni pohyb
//t_aa=-100;
t_aa=-patka_posun_vertikalni+patka_trubka_posun_vertikalni;
rotate([+90, +0, +90])
translate([-material_wt/2,
            0,
            0])
{
 for (a=[0:dokola/3:dokola])
  {
  rotate([0, a, +0])
  translate([36-t_a/tan(70)+material_wt, //dopredu/dozadu
      t_aa-hranol_vyska/2, //posun dolu/nahoru
      -material_wt/2])
  hranol_na_lano_s_dirama_3d();
  }
}

module stopka()
difference()
{
rotate([-0, -20, -0])
cylinder(h=l_stopka,
        d=d_stopka,
        center=false);
//hranol_pro_orez
translate([-175, -0, 475])
cube([80, 80, 30],
      center=true);
}
//_konec_difference

module tri_stopky()
{
 /*me sere, nehazi to chybu ale trubku nevidim    
//jeste jsem neznal z tutorialu ze muzu dat 360-1 a dalsi podminky
 //for (aaa=[360:-dokola/3:0])
 for (aaa=[0:dokola/3:360])
 {
  if (aaa==0)
       {
       echo("aaa-if=",aaa)
       translate([+300, +0, -380])
       stopka();
       }
  else
       if (aaa==360)
	    {
	    echo("aaa_else_if=",aaa);
            }
       else
	    {
	    translate([+300, +0, -380])
	    rotate([0, 0, 360-aaa])
            echo("aaa_else=",aaa);
	    }
  ///echo("aaa=",aaa);
 }
*/
     
//tohle maka, a je to min radku nez 'for'+'if' ale chtel bych to tak mit radsi
translate([+300, +0, -380])
stopka();
rotate([-0, 0, +240])
translate([+300, +0, -380])
stopka();
rotate([-0, 0, +120])
translate([+300, +0, -380])
stopka();
}

//zobrazeni tri_stopek a rotace na kridlo
///*docasne zakryt at vidim patk
rotate([0, 0, 90])
tri_stopky();
//*/


//stopky_jako_patky [ale bez orezu
module stopka_jako_patka()
difference()
{
rotate([-0, -20, -0])
cylinder(h=l_patka_trubka,
        d=d_patka_trubka,
        center=false);
//hranol_pro_orez
translate([-175+150, -0, 475-487])
//color("lime", 1.0)
cube([80, 80, 30],center=true);
}
//_konec_difference

module tri_stopky_jako_patky()
{
translate([+300+patka_trubka_posun_horizontalni,
	   +0,
	   -380+patka_trubka_posun_vertikalni]) //-1000 pridano
stopka_jako_patka();
rotate([-0, 0, +240])
translate([+300+patka_trubka_posun_horizontalni,
	   +0,
	   -380+patka_trubka_posun_vertikalni])
stopka_jako_patka();
rotate([-0, 0, +120])
translate([+300+patka_trubka_posun_horizontalni,
	   +0,
	   -380+patka_trubka_posun_vertikalni])
stopka_jako_patka();
}

rotate([0, 0, 90])
tri_stopky_jako_patky();
///_konec_stopky_jaky_patky

module noha()
difference()
{
posun_rozdil_prumeru_trubek=(d_stopka-d_noha)/2+3; //+3 korekce na centrovani
translate([+noha_posun_horizontalni+posun_rozdil_prumeru_trubek,
	   +0,
	   noha_posun_vertikalni])
 {
 //rotace
 rotate([-0, -20, -0]) //rotace_nakloneni
 cylinder (h=l_noha,d=d_noha, center=false);
 }
}

module tri_nohy()
{
rotate([-0, -0, 0])
color( "blue", 1.0 )
noha();
rotate([-0, 0, +240])
color( "red", 1.0 )
noha();
rotate([-0, 0, +120])
color( "magenta", 1.0 )
noha();
}

rotate([0, 0, +90])
tri_nohy();


///___________________________________________

/*
{
 for (a=[0:dokola/3:dokola])
  {
  rotate([0, 0, a])
  //translate([36-t_a/tan(70)+material_wt, //dopredu/dozadu
    //  t_aa-hranol_vyska/2, //posun dolu/nahoru
      //-material_wt/2])
  stopka();  
  }
}
*/

//rotate([0, 0, 90])
 //translate([+290, +0, -380])

/*
{
 for (a=[0:dokola/3:dokola])
  {
  rotate([0, 0, a])
  //translate([36-t_a/tan(70)+material_wt, //dopredu/dozadu
    //  t_aa-hranol_vyska/2, //posun dolu/nahoru
      //-material_wt/2])
  stopka();  
  }
}
*/
