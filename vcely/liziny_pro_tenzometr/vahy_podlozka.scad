//config

//$fn=0;
$fn=50;

zakladna_sirka=35;
zakladna_delka=33;

//mozna 6mm
wt_material=5;

//korekce vyoseni
//kov=wt_material/2;
kov=0;

// 6.5 
dira_prumer=7.0;

//config_

//moduly
module podlozka_plocha(
    podlozka_sirka,
    podlozka_delka)
    
    {
        square([podlozka_sirka,
                podlozka_delka],
                center=false);
        
        }
        
module dira_pro_sroub(
    prumer_diry)
    {
        circle(d=prumer_diry);
        }

module ctyri_diry()
{
//A        
translate([
        +7, 
        +kov, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer);
//B        
translate([
        +7+(2*9.5), 
        kov, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer); 
//C        
translate([
        +7+(1*9.5), 
        +kov+7.5, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer);
//D        
translate([
        +7+(1*9.5), 
        +kov-7.5, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer);
}        

//moduly_
        
//objekty
difference()
{        
translate([
        0, 
        +zakladna_sirka/2, 
        0])
        {
            rotate([+0,+0,-90])        
            podlozka_plocha(
            podlozka_sirka=zakladna_sirka,
            podlozka_delka=zakladna_delka);    
        }
//hlavni
ctyri_diry();

//kontrolni
/*
translate([
        +150-2*(7+9.5),
        0,
        0])        
ctyri_diry();        
*/      
}       
//objekty_
