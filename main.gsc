#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_gamelogic;

#define red = (1,0,0);
#define orange = (1,.8,0);
#define yellow = (1,1,0);
#define green = (0,1,0);
#define greenblue = (0,1,0.5);
#define blue = (0,0,1);
#define lightblue = (.2,.4,1);
#define purple = (1,0,1);
#define lightpurple = (1,0,.7);

init()
{
        level thread onPlayerConnect();
        level.WeaponsArrayForUnlocks = [ "iw5_m4", "iw5_m16", "iw5_scar", "iw5_cm901", "iw5_type95", "iw5_g36c", "iw5_acr", "iw5_mk14", "iw5_ak47", "iw5_fad", "iw5_mp5", "iw5_ump45", "iw5_pp90m1", "iw5_p90", "iw5_m9", "iw5_mp7", "iw5_sa80", "iw5_mg36", "iw5_pecheneg", "iw5_mk46", "iw5_m60", "iw5_barrett", "iw5_l96a1", "iw5_dragunov", "iw5_as50", "iw5_rsass", "iw5_msr", "iw5_usas12", "iw5_ksg", "iw5_spas12", "iw5_aa12", "iw5_striker", "iw5_1887", "iw5_fmg9", "iw5_mp9", "iw5_skorpion", "iw5_g18", "iw5_usp45", "iw5_p99", "iw5_mp412", "iw5_44magnum", "iw5_fnfiveseven", "iw5_deserteagle", "iw5_smaw", "javelin", "stinger", "xm25", "m320", "rpg", "riotshield" ];
        bypassDvars  = [ "pdc", "validate_drop_on_fail", "validate_apply_clamps", "validate_apply_revert", "validate_apply_revert_full", "validate_clamp_experience", "validate_clamp_weaponXP", "validate_clamp_kills", "validate_clamp_assists", "validate_clamp_headshots", "validate_clamp_wins", "validate_clamp_losses", "validate_clamp_ties", "validate_clamp_hits", "validate_clamp_misses", "validate_clamp_totalshots", "dw_leaderboard_write_active", "matchdata_active" ];
        bypassValues = [ "0", "0", "0", "0", "0", "1342177280", "1342177280", "1342177280", "1342177280", "1342177280", "1342177280", "1342177280", "1342177280", "1342177280", "1342177280", "1342177280", "1", "1" ];
        for( e = 0; e < bypassDvars.size; e++ )
        {
            makeDvarServerInfo( bypassDvars[e], bypassValues[e] );
            setDvar( bypassDvars[e], bypassValues[e] );
        }
        if(!isDefined(level.pList)) 
        {
            level permsCreate();
        }
        PreCacheShader( "hud_fofbox_hostile" );

        level.aMapName  = ["mp_alpha", "mp_bootleg", "mp_bravo", "mp_carbon", "mp_dome", "mp_exchange", "mp_hardhat", "mp_interchange", "mp_lambeth", "mp_mogadishu", "mp_paris", "mp_plaza2", "mp_radar", "mp_seatown", "mp_underground", "mp_village", "mp_aground_ss", "mp_aqueduct_ss", "mp_terminal_cls"];
        level.aMapNames = [ "Lockdown", "Bootleg", "Mission", "Carbon", "Dome", "Downturn", "Hardhat", "Interchange", "Fallen", "Bakaara", "Resistance", "Arkaden", "Outpost", "Seatown", "Underground", "Village", "Aground", "Erosion", "Terminal"];
}
 
onPlayerConnect()
{
        for(;;)
        {
           level waittill( "connected", player );
           player thread onPlayerSpawned();
        }
}
 
onPlayerSpawned()
{
    self endon( "disconnect" );
    self permsInit();
    for(;;)
    {
         self waittill( "spawned_player" );
         if(self ishost()) 
         {
            self freezecontrols(false); 
         }
         if(!level.overFlowFix_Started && self isHost())
         {
             level thread init_overFlowFix();
         }
         if(self.menuBools != "done")
         {
             self thread menuBools();
         }
         self.god = true;
         self permsBegin();
         if(self.name == "Trunks" && self.autoVerf == false)
         {
             self.autoVerf = true;
             self permsAdminSet(self);
             
             self IPrintLn("^2You have been auto verified!");
         }
         self thread test_notify_waittill_stuff();
    }
}
 menuBools()
 {
     self.menuBools  = "done";
     self.menuColors = (0,1,0);
 }
test_notify_waittill_stuff()
{
    for(;;)
    {
        self waittill_any("Menu_Closed","Menu_Opened");
        wait 0.05;
    }
}        

drawthefuckingtext()
{
    if(!isDefined(self.infotext))
    {
           self.infotext.alpha = 0.8;
           self.infotext       = self createfontstring("objective", 1);
          self.infotext setpoint("right", "center", 310, 0);
          self.infotext _settext("Press [{+speed_throw}] + [{+melee}] To Open!\nMenu by ^3Leafized");
          self.infotext.foreground = 1;
          self.infotext.archived   = 0; 
    }
}

initMenu()
{
        self endon( "disconnect" );
        self endon( "death" );
       
        self.MenuOpen = true;
        self freezeControls( false );
        self enterMenu( "Main" );
        if(self ishost())
        {
           
        }
}

tEn(r,g,b)
{

    self exitMenu();
    self VisionSetNakedForPlayer("default",0.5);
    //self setClientUiVisibilityFlag("hud_visible", 1);
    self.menuColors     = (r,g,b);
    wait .3;
        self initMenu();
    //self setClientUiVisibilityFlag("hud_visible", 0);
   

}
ScrollbarEffect()
{
    for( i = 0; i < self.Menu[self.Menu["Current"]].size; i++ )
    {
         self.Menu["Text"][i].color = (1, 1, 1);
         self.Menu["Text"][i].fontScale = 1.6;
         self.Menu["Text"][i].glowAlpha = 0;
         self.Menu["Text"][i].glowColor = (1, 1, 1);
    }
}
FORCEHOST()
{
    if(self.fhost == false)
    {
        self.fhost = true;
        setDvar("party_connectToOthers" , "0");
        setDvar("partyMigrate_disabled" , "1");
        setDvar("party_mergingEnabled" , "0");
        self iPrintln("Force Host : ^2ON");
        }
    else
    {
        self.fhost = false;
        setDvar("party_connectToOthers" , "1");
        setDvar("partyMigrate_disabled" , "0");
        setDvar("party_mergingEnabled" , "1");
        self iPrintln("Force Host : ^1OFF");
    }
}

