package org.vaneyk.archetype.maven.java.application.web.service;

import java.net.URI;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import org.vaneyk.archetype.maven.java.application.web.client.restful.HelloWorldClient;
import org.vaneyk.archetype.maven.java.application.web.contract.Hello;
import org.vaneyk.archetype.maven.java.application.web.contract.World;
import org.vaneyk.archetype.maven.java.application.web.service.HelloWorldRestServiceIntegrationTest;
import org.vaneyk.archetype.maven.java.application.web.service.restful.HelloWorldServiceImpl;

@RunWith( SpringJUnit4ClassRunner.class )
@ContextConfiguration
(
   locations = { "classpath:context-integration-test.xml" }
)
public class HelloWorldRestServiceIntegrationTest
{
    private static Logger            LOGGER                                        = LoggerFactory.getLogger( HelloWorldRestServiceIntegrationTest.class );
    private static URI               helloWorldRestServiceUri;
    private static String            helloMessage;
    private static String            worldMessage;
    
    // NOTE: spring seems to be a bit fickle with injecting unit tests, particulary with properties values via @Value but using MethodInvokingFactoryBean on a static setTestData method seems to work well
    public static void setTestData( URI helloWorldRestServiceUri, String helloMessage, String worldMessage )
    {
        HelloWorldRestServiceIntegrationTest.helloWorldRestServiceUri = helloWorldRestServiceUri ;
        HelloWorldRestServiceIntegrationTest.helloMessage             = helloMessage;
        HelloWorldRestServiceIntegrationTest.worldMessage             = worldMessage;
        
        HelloWorldRestServiceIntegrationTest.LOGGER.info( "helloWorldRestServiceUri=" + HelloWorldRestServiceIntegrationTest.helloWorldRestServiceUri );
    }
    
    // grrr junit requires test classes to have one empty constructor :( so please make setters public and inject via spring property instead of constructor arg :(  
    public HelloWorldRestServiceIntegrationTest()
    {
    }
    
    @Test
    public void testEnvironment()
    {
        // define test data
        String name = "foo";
        
        // set controls
        HelloWorldServiceImpl helloWorldService     = new HelloWorldServiceImpl( null, HelloWorldRestServiceIntegrationTest.helloMessage, HelloWorldRestServiceIntegrationTest.worldMessage );
        Hello                 controlGetHelloResult = helloWorldService.getHello( name );
        World                 controlGetWorldResult = helloWorldService.getWorld( name );
        
        // test
        HelloWorldClient helloWorldClient = new HelloWorldClient( HelloWorldRestServiceIntegrationTest.helloWorldRestServiceUri );
        Hello testGetHelloResult = helloWorldClient.getHello( name );
        World testGetWorldResult = helloWorldClient.getWorld( name );
        
        // verify results
        Assert.assertEquals( controlGetHelloResult, testGetHelloResult );
        Assert.assertEquals( controlGetWorldResult, testGetWorldResult );
    }

}

