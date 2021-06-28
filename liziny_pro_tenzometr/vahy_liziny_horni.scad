//config

//$fn=0;
$fn=50;

zakladna_sirka=050;
zakladna_delka=380;

wt_material=5;

//korekce vyoseni
//kov=wt_material/2;
kov=0;

dira_prumer=6.5;

//config_

//moduly
module vingl_plocha(
    vingl_sirka,
    vingl_delka)
    
    {
        square([vingl_sirka,
                vingl_delka],
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
        +115+7, 
        +kov, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer);
//B        
translate([
        +115+7+(2*9.5), 
        kov, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer); 
//C        
translate([
        +115+7+(1*9.5), 
        +kov+7.5, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer);
//D        
translate([
        +115+7+(1*9.5), 
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
            vingl_plocha(
            vingl_sirka=zakladna_sirka,
            vingl_delka=zakladna_delka);    
        }
//hlavni

//ctyri_diry();

//dira pojistna        
/*
translate([
        +30, 
        +kov, 
        0])
#dira_pro_sroub(
        prumer_diry=dira_prumer);
*/

//kontrolni
///*
translate([
        +150-2*(7+9.5),
        0,
        0])        
ctyri_diry();        
//*/      
}       
//objekty_
