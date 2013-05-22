package com.expedia.archetype.maven.java.application.web.common;

import org.junit.Assert;
import org.junit.Test;

public class SomeCommonThingyUnitTest
{
    @Test
    public void testIt()
    {
        // set control
        String control = "foo";
        
        // test
        SomeCommonThingy somethingToTest = new SomeCommonThingy( control );
        String           test            = somethingToTest.getSomethingToTest();
        // verify results
        Assert.assertEquals( control, test );
    }
}