package org.vaneyk.archetype.maven.java.application.web.service.soap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.vaneyk.archetype.maven.java.application.web.contract.Hello;
import org.vaneyk.archetype.maven.java.application.web.contract.World;
//import org.vaneyk.commons.debug.DebugUtilities;

public class HelloWorldServiceImpl implements HelloWorldSoapService
{
    private Logger    logger;
    private String    helloMessage;
    private String    worldMessage;
    
    public HelloWorldServiceImpl()
    {
        this( null, null, null );
    }
    
    public HelloWorldServiceImpl( Logger logger, String helloMessage, String worldMessage )
    {
        this.setLogger      ( logger       );
        this.setHelloMessage( helloMessage );
        this.setWorldMessage( worldMessage );
    }
    
    private void setLogger( Logger logger )
    {
        if( logger == null )
        {
            this.logger = LoggerFactory.getLogger( this.getClass() );
            this.logger.warn( "Undefined logger provided, substituing default: " + this );
        }
        else
        {
            this.logger = logger;
        }
    }

    private void setHelloMessage( String helloMessage )
    {
        this.helloMessage = helloMessage;
    }
    
    private void setWorldMessage( String worldMessage )
    {
        this.worldMessage = worldMessage;
    }
    
    public Hello getHello( String name )
    {
        Hello hello = new Hello( this.helloMessage, name );
        
        this.logger.info( "hey, look the logger woks: " + hello );
        
        return hello;
    }
    
    public World getWorld( String name )
    {
        World world = new World( this.worldMessage, name );
        
        this.logger.info( "hey, look the logger woks: " + world );
        
        return world;
    }
}

