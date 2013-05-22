package org.vaneyk.archetype.maven.java.application.web.client.restful;

import java.net.URI;

import javax.ws.rs.core.UriBuilder;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;

import org.vaneyk.archetype.maven.java.application.web.contract.HelloWorldService;
import org.vaneyk.archetype.maven.java.application.web.contract.World;
import org.vaneyk.archetype.maven.java.application.web.contract.Hello;

import java.io.InputStream;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

public class HelloWorldClient implements HelloWorldService
{
    private              HttpClient httpClient;
    private              URI        serviceURI;

    public HelloWorldClient()
    {
        // NOTE: using this constructor requires setting the http client and service uri separately before invoking the client
        this( null );
    }
    
    public HelloWorldClient( URI serviceURI )
    {
        this( null, serviceURI );
    }
    
    public HelloWorldClient( HttpClient httpClient, URI serviceURI )
    {
        super();
        
        this.setHttpClient( httpClient );
        this.setServiceURI( serviceURI );
    }

    public void setHttpClient( HttpClient httpClient )
    {
        this.httpClient = ( httpClient == null ? new HttpClient() : httpClient );
    }

    private HttpClient getHttpClient()
    {
        return this.httpClient;
    }
    
    public void setServiceURI( URI serviceURI )
    {
        this.serviceURI = serviceURI;
    }
    
    private URI getServiceURI()
    {
        return this.serviceURI;
    }
    
    @SuppressWarnings( "unchecked" )
    public static <T> T unmarshall( Class<T> clazz, InputStream unMarshallingStream ) throws JAXBException
    {
        // NOTE: creating a new jaxb context is heavy but for this hello world example it is find - be careful if you copy this!
        JAXBContext  jaxbContext      = JAXBContext.newInstance( clazz );
        Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
        T unmarshalledData = (T)jaxbUnmarshaller.unmarshal( unMarshallingStream );
        
        return unmarshalledData;
    }
    
    @Override
    public Hello getHello( String name )
    {
        Hello hello = null;
        
        try
        {
            // create client method
            UriBuilder serviceURIBuilder    = UriBuilder.fromUri( this.getServiceURI() );    
            String     httpMethodURIString  = serviceURIBuilder.path( "/hello/" + name ).build().toASCIIString();
            HttpMethod httpMethod           = new GetMethod( httpMethodURIString );
            
            // execute client method
            this.getHttpClient().executeMethod( httpMethod );
/* you can use these lines in lieu of the next line if you want to debug the method response     
String helloResponse = httpMethod.getResponseBodyAsString();
hello = this.unmarshall( Hello.class, new ByteArrayInputStream( helloResponse.getBytes() ) );            
*/
            hello = HelloWorldClient.unmarshall( Hello.class, httpMethod.getResponseBodyAsStream() );
        }
        catch( RuntimeException re )
        {
            // just re-throw
            throw re;
        }
        catch( Exception e )
        {
            // convert to a runtime exception
            throw new RuntimeException( e );
        }
        
        return hello;
    }

    @Override
    public World getWorld( String name )
    {
        World world = null;
        
        try
        {
            // create client method
            UriBuilder serviceURIBuilder = UriBuilder.fromUri( this.getServiceURI() );    
            HttpMethod httpMethod = new GetMethod( serviceURIBuilder.path( "/world/" + name ).build().toASCIIString() );
            
            // execute client method
            this.getHttpClient().executeMethod( httpMethod );
/* you can use these lines in lieu of the next line if you want to debug the method response            
String worldResponse = httpMethod.getResponseBodyAsString();
world = this.unmarshall( World.class, new ByteArrayInputStream( worldResponse.getBytes() ) );
*/
            world = HelloWorldClient.unmarshall( World.class, httpMethod.getResponseBodyAsStream() );
        }
        catch( RuntimeException re )
        {
            // just re-throw
            throw re;
        }
        catch( Exception e )
        {
            // convert to a runtime exception
            throw new RuntimeException( e );
        }
        
        return world;
    }
 
    // NOTE this is just a convenience main to allow testing the client against a running service   
    public static void main( String[] args ) throws Exception
    {
        URI serviceURI = new URI( "http://localhost:9090/TODO" );
        HelloWorldClient helloWorldClient = new HelloWorldClient( serviceURI );
        
        Hello hello = helloWorldClient.getHello( "foo" );
        System.out.println( hello );
        
        World world = helloWorldClient.getWorld( "bar" );
        System.out.println( world );
    }
}
