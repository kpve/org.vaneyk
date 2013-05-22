package org.vaneyk.archetype.maven.java.application.web.common;

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