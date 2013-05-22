package com.expedia.archetype.maven.java.application.service.contract;

import com.expedia.archetype.maven.java.application.service.contract.World;

public interface HelloWorldService
{
    public Hello getHello( String name );
    public World getWorld( String name );
}
