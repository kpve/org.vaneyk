package org.vaneyk.archetype.maven.java.application.web.contract;

import org.vaneyk.archetype.maven.java.application.web.contract.World;

public interface HelloWorldService
{
    public Hello getHello( String name );
    public World getWorld( String name );
}
