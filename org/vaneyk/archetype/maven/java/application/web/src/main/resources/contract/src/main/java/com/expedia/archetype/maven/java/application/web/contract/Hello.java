package com.expedia.archetype.maven.java.application.web.contract;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

@XmlRootElement
public class Hello
{
    private static final String DEFAULT_HELLO_MESSAGE = "hello ";

    private String helloMessage;
    private String name;
    
    public Hello()
    {
        this( null, null );
    }
    
    public Hello( String helloMessage, String name )
    {
        this.setHelloMessage( helloMessage );
        this.setName        ( name         );
    }
    
    public void setName( String name )
    {
        this.name = name;
    }
    
    public String getName()
    {
        return this.name;
    }
    
    public void setHelloMessage( String helloMessage )
    {
        this.helloMessage = ( helloMessage == null ? Hello.DEFAULT_HELLO_MESSAGE : helloMessage );
    }
    
    public String getHelloMessage()
    {
        return this.helloMessage;   
    }
    
    @Override
    public boolean equals( Object object )
    {
        boolean equals = false;
        
        if( object instanceof Hello )
        {
           Hello that = (Hello)object;
           
           if( this == that )
           {
               equals = true;
           }
           else
           {
               equals = new EqualsBuilder()
                            .append( this.getHelloMessage(), that.getHelloMessage() )
                            .append( this.getName(),         that.getName()         )
                            .isEquals();
           }
        }  
         
        return equals;
    }
    
    @Override
    public int hashCode()
    {
        return new HashCodeBuilder(17, 37)
                   .append( this.getHelloMessage() )
                   .append( this.getName()         )
                   .toHashCode();
    }
    
    public String toString()
    {
        return this.helloMessage + this.getName();
    }
}
