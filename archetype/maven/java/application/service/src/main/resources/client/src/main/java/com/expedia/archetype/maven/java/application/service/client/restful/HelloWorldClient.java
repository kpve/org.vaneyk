package com.expedia.archetype.maven.java.application.service.client.restful;


import com.expedia.archetype.maven.java.application.service.contract.HelloWorldService;
import com.expedia.archetype.maven.java.application.service.contract.World;
import com.expedia.archetype.maven.java.application.service.contract.Hello;

public class HelloWorldClient implements HelloWorldService
{
    public HelloWorldClient()
    {
    }
    
    @Override
    public Hello getHello( String name )
    {
        Hello hello = null;
        
        // TODO code to call service goes here ;)
        
        return hello;
    }

    @Override
    public World getWorld( String name )
    {
        World world = null;
        
        
        // TODO code to call service goes here ;)
        
        
        return world;
    }
 
    // NOTE this is just a convenience main to allow testing the client against a running service   
    public static void main( String[] args ) throws Exception
    {
        System.out.println( "TODO - not implemented yet." );
    }
}
