
monitorActions()
{
        self endon( "disconnect" );
        self endon( "death" );
        if(self.glowColors == undefined)
        {
            self.glowColors = 0;
        }
        self.MenuOpen = false;
        self.Menu["infoboard"] = self createRectangle( "RIGHT", "CENTER", 410, 0, "white", 200, 35, (0, 0, 0), 0.4, 1 );
        self thread drawthefuckingtext();
        for( ;; )
        {
                if( !self.MenuOpen )
                {
                        if(self meleebuttonpressed() && self adsbuttonpressed())
                        {
                            self initMenu();
                            //self setClientUiVisibilityFlag("hud_visible", 0);
                            self.infotext _setText("^3[{+activate}] ^7Select ^3[{+speed_throw}] ^7& \n^3[{+attack}] ^7Scroll ^3[{+melee}] ^7Back / Close");
                            wait 0.3;
                        }
                }
                else if( self.MenuOpen )
                {
                        if(self AdsButtonPressed())
                        {
                                self doScrolling( -1 );
                                wait 0.1;
                                
                        }
                        if( self AttackButtonPressed())
                        {
                                self doScrolling( 1 );
                                wait 0.1;
                        }
                        if( self usebuttonpressed() )
                        {
                                wait 0.2;
                                function = self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].action;
                                input1   = self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].arg;
                                input2   = self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].arg2;
                                input3   = self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].arg3;
                                input4   = self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].arg4;
                                input5   = self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].arg5;
                                input6   = self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].arg6;
                                self thread [[function]](input1,input2,input3,input4,input5,input);
                                self  destroyMenuText();
                                self  updateMenuStructure();
                                self  createMenuText();
                                
                        }
                        if(self meleebuttonpressed())
                        {
                            if( isDefined( self.Menu["Parents"][self.Menu["Current"]] ) )
                            {
                               self enterMenu( self.Menu["Parents"][self.Menu["Current"]] );
                            }
                            else
                            {
                                self exitMenu();
                               //self setClientUiVisibilityFlag("hud_visible", 1);
                               self.infotext _setText("Press [{+speed_throw}] + [{+melee}] To Open!");
                            }
                            wait 0.15;
                        }
                }
                wait 0.05;
        }
}
