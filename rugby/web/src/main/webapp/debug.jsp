<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"       prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml"       prefix="x"   %>

<span>services</span>
<br/>
<a href="http://localhost:9090/rugby/service/1.0/rest/helloWorld/hello?_wadl&_type=xml">hello wadl</a>
<br/>
<a href="http://localhost:9090/rugby/service/1.0/rest/helloWorld/world?_wadl&_type=xml">world wadl</a>
<br/>
<span>resources</span>
<br/>
<c:import    var="wadl"                   url="http://localhost:9090/rugby/service/1.0/rest/helloWorld/hello?_wadl&_type=xml" />
<c:import    var="resourceLinksTransform" url="wadlToHtmlLinks.xsl"                                />
<x:transform xml="${wadl}"                xslt="${resourceLinksTransform}"                         />
<br/>


