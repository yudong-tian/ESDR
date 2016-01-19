
* ARS data
'open /home/ytian/lswg/Little_Washita/lw_sm_3hr.ctl'
* LIS data 
'open /home/ytian/lswg/Little_Washita/OUTPUT-bigSGP-0.25/cnsr-noah32-nldas2/E514-lsm.ctl'
'set time 1jan2007 1jan2009' 
'set gxout fwrite' 
'set fwrite -be -st ARS-3hr.1gd4r'
'd avg'
'disable fwrite' 
'set gxout fwrite' 
'set fwrite -be -st LIS-Noah-3hr.1gd4r'
'd soilmoist1.2'
'disable fwrite' 
'quit' 



