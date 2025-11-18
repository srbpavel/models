//CONFIG
$fn=50;

/*
$fa=1;
$fs=0.4;
*/

//COEFICIENT --> future use for cnc as elox is adding volume
coeficient = 0;

// unit: mm
diameter_magazine = coeficient + 35.4;
diameter_ammo = coeficient + 6.5;
diameter_center = coeficient + 5 ;
diameter_top_ring = coeficient + 18.9; 
diameter_top_ring_scrool = coeficient + 3; 
diameter_bottom_ring = coeficient + 13.6; 
diameter_o_ring = coeficient + 35.4; //VERIFY
diameter_o_ring_wall = coeficient + 1.7; 
diameter_outside_shaft = coeficient + 3; ;

height_magazine =  coeficient + 10;
height_top_ring =  coeficient + 2;
height_bottom_ring =  coeficient + 0.2;
height_o_ring_shaft =  coeficient + 3.2;
height_outside_shaft =  coeficient + 2.4;
height_bottom_to_outside_shaft =  coeficient + 4.2; // bottom for two ruber seal

count_ammo = 12; // same for flower shaft + outside_shaft

position_ammo = 8.3; // edge to edge ammo-center
position_outside_shaft = 14.5; // edge to edge outside_shaft-center
position_flower_hole = 4.5; // 4.6 // edge to edge flower_shaft-center
position_o_ring = (height_magazine / 2) - height_bottom_to_outside_shaft; // 10 / 2 = 5 - 4.2 = 0.8
//CONFIG_


module magazine_2d()
  difference()
{
  circle(d = diameter_magazine);    
  circle(d = diameter_center);
  
  #all_ammo();
}

    
module all_ammo()
{
  krok = 360 / count_ammo;
  r = position_ammo + (diameter_ammo / 2) + (diameter_center / 2 );
  
  for (i=[0:krok:360-krok])
    {
      uhel=i;//+90; //start na 12hodin
      dx=r*cos(uhel);
      dy=r*sin(uhel);
      
      translate([dx, dy])
	{    
	  circle(d = diameter_ammo);
	}
    }
}


module magazine_3d()
{
  linear_extrude(
    height=height_magazine,
    center=true)
    
    magazine_2d();
}

 
module bottom_ring_2d()
  difference()
{
  circle(d = diameter_bottom_ring);    
  circle(d = diameter_center);
}


module bottom_ring_3d()
  translate([0,
	     0,
	     -(height_magazine / 2 + height_bottom_ring / 2)])
{
  linear_extrude(
		 height=height_bottom_ring * 1, //pro spojeni bez mezery
		 center=true)
    
    bottom_ring_2d();
}


module o_ring()
{
  rotate_extrude(angle=360)
    {
      translate([
		 (diameter_magazine/2) - (diameter_o_ring_wall/2) + 0,//1
		 0])
	
	square(size=[height_o_ring_shaft,
		     height_o_ring_shaft],
	       center=false); //true
    }
}


module all_outside_shaft()
  #linear_extrude(
  height=height_outside_shaft * 2, //pro spojeni bez mezery
  center=true)
  
    {
      krok = 360 / count_ammo;
      r = position_outside_shaft + (diameter_center / 2 ) + 1; // posun ven
      
      for (i=[0:krok:360-krok])
        {
	  uhel=i;
	  dx=r*cos(uhel);
	  dy=r*sin(uhel);
          
	  translate([dx, dy])
            {    
	      circle(d = diameter_outside_shaft);
            }
        }
    }

    
module flower_shaft()
{
  union()
    
    circle(d = diameter_top_ring_scrool);
  
  translate([0, -0.25, 0])
    circle(d = diameter_top_ring_scrool);
}


module flower()
  linear_extrude(
		 height=height_top_ring * 1, //pro spojeni bez mezery
		 center=true)
  
  difference()
{
  circle(d = diameter_top_ring);    
  circle(d = diameter_center);
  
  {
    krok = 360 / count_ammo;
    r = position_flower_hole
      + (diameter_center / 2 )
      + diameter_top_ring_scrool
      + -1; // -1 posun ven
    
    for (i=[0:krok:360-krok])
      {
	uhel=i;
	dx=r*cos(uhel);
	dy=r*sin(uhel);
        
	translate([dx, dy])
	  {    
	    #flower_shaft();
	  }
      }
  }
}

    
//MAIN
//%all_ammo();

//%magazine_2d();
//%magazine_3d();

///*
difference()
{
  magazine_3d();
  
  translate([0, 0, height_outside_shaft * 2]) // 0.25!!!
    rotate([0, 0, 360 / count_ammo / 2 - (5.5/2)])
    // - 0 zarez ve stredu
    // - 5.5 vyoseni az na dotyk, takze 1/2 jako na 1/4
    #all_outside_shaft();
    
    translate([0,0,-position_o_ring]) // 10 / 2 = 5 - 4.2 = 0.8
    #o_ring();
    
    }
//*/

//%bottom_ring_2d();
bottom_ring_3d();

///*
translate([0, 0, height_magazine / 2 + height_top_ring / 2])
    flower();
//*/

//%flower_shaft();

