package com.expedia.archetype.maven.java.application.service.standalone;

import java.net.URI;
import java.util.concurrent.Executors;


import com.expedia.archetype.maven.java.application.service.contract.HelloWorldService;
import com.expedia.archetype.maven.java.application.service.contract.World;
import com.expedia.archetype.maven.java.application.service.contract.Hello;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class HelloWorldServiceImpl implements HelloWorldService, Runnable
{
    private static final long DEFAULT_SERVICE_PAUSE_IN_MILLIS = 10000;
    
    private Logger    logger;
    private String    name;
    private String    helloMessage;
    private String    worldMessage;
    private long      servicePauseInMillis;
    
    public HelloWorldServiceImpl()
    {
        this( null, null, null, null, null );
    }
    
    public HelloWorldServiceImpl( Logger logger, String name, String helloMessage, String worldMessage, Long servicePauseInMillis )
    {
        this.setLogger              ( logger               );
        this.setName                ( name                 );
        this.setHelloMessage        ( helloMessage         );
        this.setWorldMessage        ( worldMessage         );
        this.setServicePauseInMillis( servicePauseInMillis );
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

    private void setName( String name )
    {
        this.name = name;    
    }
    
    private void setHelloMessage( String helloMessage )
    {
        this.helloMessage = helloMessage;
    }
    
    private void setWorldMessage( String worldMessage )
    {
        this.worldMessage = worldMessage;
    }
    
    private void setServicePauseInMillis( Long servicePauseInMillis )
    {
        this.servicePauseInMillis = ( servicePauseInMillis == null ? HelloWorldServiceImpl.DEFAULT_SERVICE_PAUSE_IN_MILLIS : servicePauseInMillis );
    }
    
    public Hello getHello( String name )
    {
        Hello hello = new Hello( this.helloMessage, name );
        
        this.logger.info( "hey, look the logger works: " + hello );
        
        return hello;
    }

    public World getWorld( String name )
    {
        World world = new World( this.worldMessage, name );
        
        this.logger.info( "hey, look the logger works: " + world );
        
        return world;
    }
 
    public long getServicePauseInMillis()
    {
        return this.servicePauseInMillis;
    }
    
    public void run()
    {
        try
        {
             this.logger.info( "starting service - interrupt thread to stop" );
            while( true )
            {
                this.getHello( this.name );
                this.getWorld( this.name );
                Thread.sleep( this.servicePauseInMillis );
            }
        }
        catch( InterruptedException ie )
        {
            this.logger.info( "service interrupted, exiting." );
        }
    }
    
    public static void main( String[] args )
    {
        // start spring context  NOTE: this is done before everything else because we use spring to manage low level things like logging
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext( "classpath*:applicationContext.xml" );
        
        // echo args for debugging :)    
        Logger mainLogger = LoggerFactory.getLogger( HelloWorldServiceImpl.class );
        mainLogger.info( "args (not currently used by simple hello world implementation): " + args );

        // start service thread
        String helloWorldServiceImplBeanName = "com_expedia_archetype_maven_java_application_service_standalone_HelloWorldServiceImpl";
        HelloWorldServiceImpl helloWorldServiceImpl  = (HelloWorldServiceImpl)applicationContext.getBean( helloWorldServiceImplBeanName );
        Executors.newSingleThreadScheduledExecutor().execute( helloWorldServiceImpl ); 
        
        mainLogger.info( "done launching service" );
    }
}


