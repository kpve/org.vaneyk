package org.vaneyk.archetype.maven.java.application.web.service.restful;

import java.net.URI;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.vaneyk.archetype.maven.java.application.web.contract.HelloWorldService;
import org.vaneyk.archetype.maven.java.application.web.contract.World;
import org.vaneyk.archetype.maven.java.application.web.contract.Hello;
//import org.vaneyk.commons.debug.DebugUtilities;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HelloWorldServiceImpl implements HelloWorldService
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
    
    @GET
    @Path( "helloWorld/hello/{name}" )
    @Produces("application/xml")
    @Override
    public Hello getHello( @PathParam( "name" )String name )
    {
        Hello hello = new Hello( this.helloMessage, name );
        
        this.logger.info( "hey, look the logger woks: " + hello );
        
        return hello;
    }

    @GET
    @Path( "helloWorld/world/{name}" )
    @Produces("application/xml")
    @Override
    public World getWorld( @PathParam( "name" )String name )
    {
        World world = new World( this.worldMessage, name );
        
        this.logger.info( "hey, look the logger woks: " + world );
        
        return world;
    }
    
}


