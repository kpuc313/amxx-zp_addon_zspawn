/*****************************************************************
*                            MADE BY
*
*   K   K   RRRRR    U     U     CCCCC    3333333      1   3333333
*   K  K    R    R   U     U    C     C         3     11         3
*   K K     R    R   U     U    C               3    1 1         3
*   KK      RRRRR    U     U    C           33333   1  1     33333
*   K K     R        U     U    C               3      1         3
*   K  K    R        U     U    C     C         3      1         3
*   K   K   R         UUUUU U    CCCCC    3333333      1   3333333
*
******************************************************************
*                       AMX MOD X Script                         *
*     You can modify the code, but DO NOT modify the author!     *
******************************************************************
*
* Description:
* ============
* This is a plugin for Counte-Strike 1.6's Zombie Plague Mod which allows you to respawn if you join late.
*
*****************************************************************/

#include <amxmodx>
#include <hamsandwich>
#include <cstrike>

public plugin_init() {
	register_plugin("[ZP] Addon: zSpawn", "1.0", "kpuc313")
	
	register_event("TeamInfo", "join_team", "a")
}

public join_team() {
	new id = read_data(1)
	static user_team[32]
    
	read_data(2, user_team, 31)  
	new alive = is_user_alive(id)  
    
	if(!is_user_connected(id))
		return 0;
    
	switch(user_team[0])
	{
		case 'C':  
		{
			if(!alive)
				set_task(1.0,"menu",id);
		}
		case 'T':
		{ 
			if(!alive)
				set_task(1.0,"menu",id); 
        		}
        	}
	return 0;
}

public menu(id) {
	if(is_user_alive(id) || cs_get_user_team(id) == CS_TEAM_SPECTATOR)
		return;
	
	new menu = menu_create("Do you want to spawn?", "menu2") 

	menu_additem(menu, "Yes", "1", 0) 
	menu_additem(menu, "No", "2", 0)
     
	menu_display(id, menu, 0) 
} 

public menu2(id, menu, item) {
	if(item == MENU_EXIT ) 
	{ 
		menu_destroy(menu) 
		return PLUGIN_HANDLED 
	} 
	new data[6], iName[64] 
	new access, callback, name[33]
	get_user_name(id, name, 32)

	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback)

	new key = str_to_num(data) 
     
	switch(key) 
	{
		case 1: 
		{
			ExecuteHamB(Ham_CS_RoundRespawn, id)
    		} 
    		case 2: 
    		{
			return PLUGIN_CONTINUE;
		}
	}
         
	menu_destroy(menu) 
	return PLUGIN_HANDLED 
}
