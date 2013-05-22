package com.expedia.archetype.maven.java.application.web.contract;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

@XmlRootElement
public class World
{
    private static final String DEFAULT_WORLD_MESSAGE = "this is your world ";

    private String worldMessage;
    private String name;
    
    public World()
    {
        this( null, null );
    }
    
    public World( String worldMessage, String name )
    {
        this.setWorldMessage( worldMessage );
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
    
    public void setWorldMessage( String worldMessage )
    {
        this.worldMessage = ( worldMessage == null ? World.DEFAULT_WORLD_MESSAGE : worldMessage );
    }
    
    public String getWorldMessage()
    {
        return this.worldMessage;
    }
    
    @Override
    public boolean equals( Object object )
    {
        boolean equals = false;
        
        if( object instanceof World )
        {
           World that = (World)object;
           
           if( this == that )
           {
               equals = true;
           }
           else
           {
               equals = new EqualsBuilder()
                            .append( this.getWorldMessage(), that.getWorldMessage() )
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
                   .append( this.getWorldMessage() )
                   .append( this.getName()         )
                   .toHashCode();
    }
    
    public String toString()
    {
        return this.worldMessage + this.getName();
    }
}
