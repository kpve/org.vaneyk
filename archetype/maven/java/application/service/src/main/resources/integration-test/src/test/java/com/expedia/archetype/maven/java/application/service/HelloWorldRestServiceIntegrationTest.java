package com.expedia.archetype.maven.java.application.service;

import java.net.URI;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.expedia.archetype.maven.java.application.service.client.restful.HelloWorldClient;
import com.expedia.archetype.maven.java.application.service.contract.Hello;
import com.expedia.archetype.maven.java.application.service.contract.World;

@RunWith( SpringJUnit4ClassRunner.class )
@ContextConfiguration
(
   locations = { "classpath:context-integration-test.xml" }
)
public class HelloWorldRestServiceIntegrationTest
{
    private static Logger LOGGER = LoggerFactory.getLogger( HelloWorldRestServiceIntegrationTest.class );
    
    // NOTE: spring seems to be a bit fickle with injecting unit tests, particulary with properties values via @Value but using MethodInvokingFactoryBean on a static setTestData method seems to work well
    public static void setTestData( /* TODO */ )
    {
        // TODO
    }
    
    // grrr junit requires test classes to have one empty constructor :( so please make setters public and inject via spring property instead of constructor arg :(  
    public HelloWorldRestServiceIntegrationTest()
    {
    }

    // TODO
    @Test
    public void testEnvironment()
    {
        // define test data
        
        // set controls
        
        // test
        
        // verify results
    }

}

