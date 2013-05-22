package com.expedia.archetype.maven.java.application.service.common;

public class SomeCommonThingy 
{
    private String somethingToTest;
    
    public SomeCommonThingy( String somethingToTest )
    {
        this.setSomethingToTest( somethingToTest );
    }
    
    public void setSomethingToTest( String somethingToTest )
    {
        this.somethingToTest = somethingToTest;
    }
    
    public String getSomethingToTest()
    {
        return this.somethingToTest;
    }
}