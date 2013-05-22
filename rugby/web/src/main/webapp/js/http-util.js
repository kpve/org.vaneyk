
$.urlParameters = function urlParameters( urlSearchSubstring )
{
    // define parameter regex and return object
    var parameterRegex = /([^&=]+)=([^&]*)/g, queryParameters = {};
 
    // iterate over parameters
    while( parameter = parameterRegex.exec( urlSearchSubstring ) )
    {
        // decode
        queryParameters[ decodeURIComponent( parameter[ 1 ] ) ] = decodeURIComponent( parameter[ 2 ] );
    }
    
    return queryParameters;
}

