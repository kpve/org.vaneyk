<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>
        <link rel="stylesheet" type="text/css" href="/rugby/page/css/splash.css" />

        <jsp:include page="/include/standard-javascript-include.jsp" />

        <script type="text/javascript">
        
            var bodyOnClickOneTime = false;
            $( document ).ready
            (
                function()
                {
                    // request full screen mode  
                    // TODO delete the try/catch when the new w3c standard is fully implemeted
                    try
                    {
                        $( 'body' ).requestFullscreen();
                    }
                    catch( error )
                    {
                    }
                    
                    // fade in the body
                    $( '#body' ).fadeIn( longFadeTimeInMillis );
                    
                    // set ui behaviors
                    $( '#body' ).click
                    (
                        function()
                        {
                            // only allow the splash to login transition to happen once
                            if( bodyOnClickOneTime == false )
                            {
                                bodyOnClickOneTime = true;

                                // hide splash title and show login
                                $( '#splashTitle' ).hide  ( mediumFadeTimeInMillis );
                                $( '#login-form'  ).fadeIn( mediumFadeTimeInMillis );
                            }
                        }
                    );
                    $( '#login-action-login' ).click
                    (
                        function()
                        {
                            // fade out the body and send to the main page as a guest
                            $( '#body' ).fadeOut( shortFadeTimeInMillis );
                            var user = $( '#login-action-user-name-input' ).val();
                            setTimeout( "window.location = '/rugby/page/main.jsp?user=" + encodeURIComponent( user ) + "';", shortFadeTimeInMillis );
                        }
                    )
                    $( '#login-action-guest' ).click
                    (
                        function()
                        {
                            // fade out the body and send to the main page as a guest
                            $( '#body' ).fadeOut( shortFadeTimeInMillis );
                            var user = 'guest';
                            setTimeout( "window.location = '/rugby/page/main.jsp?user=" + encodeURIComponent( user ) + "';", shortFadeTimeInMillis );
                        }
                    )
                }
            );
        </script>
    </head>
    <body>
        <div id="body" >
            <div id="splash-and-login-pane" >
                <span id="splashTitle" >rugby</span>
<!--
                <div id="login" >
                    <div>
                        <input id="username" type="text" />
                    </div>
                    <div>
                        <input id="password" type="password" />
                    </div>
                    <div id="login-action">
                        <span id="login-submit">login</span> | <span id="guest-submit">guest</span>
                    </div>
                </div>
-->
                <div id="login-form" class="form classic-form" >
                    <div class="DELETE_ME" >
                        <span id="login-action-user-name-label" class="form-field-label" ><!-- silent --></span>
                        <input id="login-action-user-name-input" type="text" class="form-field-input" />
                    </div>
                    <div class="DELETE_ME" >
                        <span id="login-action-password-label" class="form-field-label" ><!-- silent --></span>
                        <input id="login-action-password-input" type="password" class="form-field-input" />
                    </div>
                    <div class="DELETE_ME form-actions" >
                        <span class="form-field-label"><!--  no label --></span>
                        <span class="form-field-input">
                            <span id="login-action-login" class="form-field-action inline-right-layout" >login</span><span id="login-action-guest" class="form-field-action">guest</span>
                        </span>
                    </div>
                </div>
            </div>
    </body>
</html>
