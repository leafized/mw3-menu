vector_scal(vec, scale)

{

    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);

    return vec;

}
UFOMode()
{
    if(self.UFOMode == false)
    {
        self thread doUFOMode();
        self.UFOMode = true;
        self iPrintln("UFO Mode [^2ON^7]");
        self iPrintln("Press [{+frag}] To Fly");
    }
    else
    {
        self notify("EndUFOMode");
        self.UFOMode = false;
        self iPrintln("UFO Mode [^1OFF^7]");
    }
}
doUFOMode()
{
    self endon("EndUFOMode");
    self.Fly = 0;
    UFO      = spawn("script_model",self.origin);
    for(;;)
    {
        if(self FragButtonPressed())
        {
            self playerLinkTo(UFO);
            self.Fly = 1;
        }
        else
        {
            self unlink();
            self.Fly = 0;
        }

        if(self.Fly == 1)
        {
            Fly = self.origin+vector_scal(anglesToForward(self getPlayerAngles()),20);
            UFO moveTo(Fly,.01);
        }
        wait .001;
    }
}

Test_Function(input, i2, i3, i4, i5, bold)
{
    if(bold == undefined) self iprintln(input, i2, i3, i4, i5);
    else if(bold == 1) self IPrintLnBold(input, i2, i3, i4, i5);
}

testBool()
{
    if(self.TestBool == false)
    {
        self.TestBool = true;
    }
    else if(self.TestBool == true)
    {
        self.TestBool = false;
    }
}
pLocation()
{
   string = self.origin;
   self IPrintLnBold(string);
}
tpF(var)
{
}


doAimbot()
{
    if(self.autoAim == false)
    {
        self.autoAim = true;
        self thread autoAim();
        self IPrintLn("Unfair Aimbot ^7Enabled");
    }
    else
    {
        self.autoAim = false;
        self notify("aim_over");
        self IPrintLn("Unfair Aimbot ^1Disabled");
    }
}
autoAim()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon("aim_over");
    for(;;)
    {
        wait 0.01;
        aimAt = undefined;
        foreach(player in level.players)
        {
                if( (player == self) || (level.teamBased && self.pers["team"] == player.pers["team"]) || ( !isAlive(player) ) )
                        continue;
                if( isDefined(aimAt) )
                {
                        if( closer( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), aimAt getTagOrigin( "j_head" ) ) )
                                aimAt = player;
                }
                else
                        aimAt = player;
        }
        if( isDefined( aimAt ) )
        {
                self setplayerangles( VectorToAngles( ( aimAt getTagOrigin( "j_head" ) ) - ( self getTagOrigin( "j_head" ) ) ) );
                if( self AttackButtonPressed() )
                       aimAt thread [[level.callbackPlayerDamage]]( self, self, 2147483600, 8, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0 );
        }
    }
}