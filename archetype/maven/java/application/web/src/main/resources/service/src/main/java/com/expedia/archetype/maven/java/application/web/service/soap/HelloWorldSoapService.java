package  com.expedia.archetype.maven.java.application.web.service.soap;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.expedia.archetype.maven.java.application.web.contract.HelloWorldService;
import com.expedia.archetype.maven.java.application.web.contract.World;
import com.expedia.archetype.maven.java.application.web.contract.Hello;

@WebService
// NOTE: this interface is needed because the jax-ws soap stacks (we are using cxf) require placing annotations on the service interface
//       but we want to prevent placing soap specific annotations on the actual hello world service interface
public interface HelloWorldSoapService extends HelloWorldService
{
    @WebMethod
    public Hello getHello( String name );
    
    @WebMethod
    public World getWorld( String name );
}
