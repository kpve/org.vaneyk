<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>
        <link rel="stylesheet" type="text/css" href="/rugby/page/css/main.css" />

        <jsp:include page="/include/standard-javascript-include.jsp" />

        <script type="text/javascript">
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
                    $( '#body' ).fadeIn( shortFadeTimeInMillis );
                    
                    // --- user menu       -------------------------------------------------------------------------------
                    var user = $.urlParameters( window.location.search.substring( 1 ) )[ 'user' ];
                    $( '#user-menu-label-value' ).html( user );
                    $( '#user-menu-label-value' ).show();
                    
                    $( '#logout' ).click
                    (
                        function()
                        {
                            $( '#body' ).fadeOut( shortFadeTimeInMillis );
                            setTimeout( "window.location = '/rugby/page/splash.jsp'", shortFadeTimeInMillis );
                        }
                    )
                    
                    // TODO THIS IS FOR THE INITIAL HTML SKIN ONLY!! NOT SECURE!!
                      // if the user is a guest disable the perspective menu and set the perspective to reporting
                    if( user == 'guest' )
                    {
                        $( '#perspective-menu-items' ).hide();
                        $( '#perspective-menu' ).unbind( 'mouseenter' );
                        $( '#perspective-menu-items *[data-menu-item=reporting]' ).click();
                    }

                    // --- perspective menu       -------------------------------------------------------------------------------
                    $( '#perspective-menu-items *[data-menu-item]' ).click
                    (
                        function()
                        {
                            // get perspective
                            var perspective = $( this ).attr( 'data-menu-item' );
                            
                            // update header to show only perspective menus for this perspective
                            // NOTE: CSS attribute value selectors do not support not equals yet, so we turn off all menus here and then turn on the main menus with a second selector
                            // NOTE: jquery's effects such as show, fadeIn don't seem to play nice with the menu elements that need display=table style so we manually apply it here
                            $( '#header > .menu[data-menuType!=main]' ).hide();
                            $( '#header > .menu[data-menuType=perspective][data-perspective=' + perspective + ']' ).css( 'display', 'table' );
                            
                            // update the perspective
                            //     menus
                            $( '#perspective-content > [data-perspective!=' + perspective + ']' ).hide();
                            $( '#perspective-content > [data-perspective =' + perspective + ']' ).fadeIn( shortFadeTimeInMillis );
                            
                            //     content
                            $( '#perspective-content' ).fadeOut();
                            $( '#perspective-content' ).load( '/rugby/page/perspective/' + perspective + '.jsp' );
                            $( '#perspective-content' ).fadeIn();
                        }
                    )
                    
                    $( '#scrum-product-menu-product-search-input' ).on
                    (
                    	'change',
                        function()
                        {
alert( 'delete me - CHANGE!' );
                            // get the product
                            var product = $( this ).attr( 'value' );
                            
                            //  display the team menu
                            if( product != 'bogus' )
                            {
                                $( '#team-menu' ).fadeIn();
                            }
                            else
                            {
                                $( '#team-menu' ).fadeOut();
                                $( '#view-menu' ).fadeOut();
                             }
                        }
                    )
                    
                    $( '#scrum-team-menu-team-search-input' ).on
                    (
                        'change',
                        function()
                        {
                            // get the team
                            var team = $( this ).attr( 'value' );
                            
                            // display the view menu
                            if( team )
                            {
                                $( '#view-menu' ).fadeIn();
                            }
                            else
                            {
                                $( '#view-menu' ).fadeOut();
                             }
                        }
                    )
                    
                    $( '#view-menu-items' ).click
                    (
                        function()
                        {
                            // get the perspective and view
                            var perspective = $( '#perspective-menu-label-value' ).text();
                            var view        = $( '#view-menu-label-value' ).text();
                            
                            // update the view content
                            $( '#view-content' ).fadeOut();
                            $( '#view-content' ).load( '/rugby/page/perspective/view/' + perspective + '/' + view + '.jsp' );
                            $( '#view-content' ).fadeIn();
                        }
                    )
                }
            );
        </script>
    </head>
    <body>
        <div id="body" >
            <div id="header" class="containFloatedChildren" >
                <div id="user-menu" data-menuType="main" class="menu vertical-sliding-menu inline-right-layout" >
                     <div id="user-menu-header" class="menu-header" >
                         <span id="user-menu-label" class="menu-label" >
                             user: <span id="user-menu-label-value" class="menu-label-value"></span>
                         </span>
                     </div>
                    <div id="user-menu-items" class="menu-items vertical-menu-items" >
                        <div id="logout" data-menu-item="logout" class="menu-item" >
                            <span class="menu-item-label" >logout</span>
                        </div>
                    </div>
                </div>
                <div id="perspective-menu" data-menuType="main" class="menu vertical-sliding-menu inline-right-layout" >
                    <div id="perspective-menu-header" class="menu-header">
                        <div id="perspective-menu-label" class="menu-label" >
                            perspective: <span id="perspective-menu-label-value" class="menu-label-value" ></span>
                        </div>
                    </div>
                    <div id="perspective-menu-items" class="menu-items vertical-menu-items" >
                        <div data-menu-item="admin"        class="menu-item" >
                            <span class="menu-item-label" >admin</span>
                        </div>
                        <div data-menu-item="scrum"      class="menu-item" >
                            <span class="menu-item-label" >scrum</span>
                        </div>
                        <div data-menu-item="reporting" class="menu-item" >
                            <span class="menu-item-label" >reporting</span>
                        </div>
                    </div>
                </div>
                <div id="admin-menu" class="menu vertical-sliding-menu inline-right-layout" data-menuType="perspective" data-perspective="admin"  >
                    <div id="admin-menu-header" class="menu-header">
                        <div id="admin-menu-label" class="menu-label" >
                            admin: <span id="admin-menu-label-value" class="menu-label-value" ></span>
                        </div>
                    </div>
                    <div id="admin-menu-items" class="menu-items vertical-menu-items" >
                        <div data-menu-item="user"         class="menu-item" >
                            <span class="menu-item-label" >user</span>
                        </div>
                        <div data-menu-item="team"         class="menu-item" >
                            <span class="menu-item-label" >team</span>
                        </div>
                        <div data-menu-item="notification" class="menu-item" >
                            <span class="menu-item-label" >notification</span>
                        </div>
                        <div data-menu-item="system"       class="menu-item" >
                            <span class="menu-item-label" >system</span>
                        </div>
                    </div>
                </div>
                <div id="product-menu" data-menuType="perspective" data-perspective="scrum" class="menu vertical-sliding-menu inline-right-layout" >
                    <div id="product-menu-header" class="menu-header">
                        <div id="product-menu-label" class="menu-label" >
                            product: <input type="text" id="scrum-product-menu-product-search-input" class="" ></input>
                        </div>
                    </div>
                </div>
                <div id="team-menu" data-menuType="perspective-product-selected" data-perspective="scrum" class="menu vertical-sliding-menu inline-right-layout" >
                    <div id="team-menu-header" class="menu-header">
                        <div id="team-menu-label" class="menu-label" >
                            team: <input type="text" id="scrum-team-menu-team-search-input" class="" ></input>
                        </div>
                    </div>
                </div>
                
<!-- TODO revisit, should team menu be an input field with type-ahead?  perhaps a list of teams int the content section below?
          This is important to how we associate teams with products - probably should be loose and not team is a chile of product
          so that that teams can easily switch products if needed...
                <div id="team-menu" data-menuType="perspective-product-selected" data-perspective="scrum" class="menu vertical-sliding-menu inline-right-layout" >
                    <div id="team-menu-header" class="menu-header">
                        <div id="team-menu-label" class="menu-label" >
                            team: <span id="team-menu-label-value" class="menu-label-value" ></span>
                        </div>
                     </div>
                    <div id="team-menu-items" class="menu-items vertical-menu-items" >
                        <div data-menu-item="team 1" class="menu-item" >
                            <span class="menu-item-label" >team 1</span>
                        </div>
                        <div data-menu-item="team 2" class="menu-item" >
                            <span class="menu-item-label" >team 2</span>
                        </div>
                        <div data-menu-item="team 3" class="menu-item" >
                            <span class="menu-item-label" >team 3</span>
                        </div>
                    </div>
                </div>
-->
                <div id="view-menu" data-menuType="perspective-product-and-team-selected" data-perspective="scrum" class="menu vertical-sliding-menu inline-right-layout" >
                    <div id="view-menu-header" class="menu-header">
                        <div id="view-menu-label" class="menu-label" >
                            view: <span id="view-menu-label-value" class="menu-label-value" ></span>
                        </div>
                    </div>
                    <div id="view-menu-items" class="menu-items vertical-menu-items" >
                        <div data-menu-item="backlog" class="menu-item" >
                            <span class="menu-item-label" >backlog</span>
                        </div>
                        <div data-menu-item="planning" class="menu-item" >
                            <span class="menu-item-label" >planning</span>
                        </div>
                        <div data-menu-item="estimation"     class="menu-item" >
                            <span class="menu-item-label" >estimation</span>
                        </div>
                        <div data-menu-item="daily-scrum"  class="menu-item" >
                            <span class="menu-item-label" >daily-scrum</span>
                        </div>
                        <div data-menu-item="daily-update" class="menu-item" >
                            <span class="menu-item-label" >daily-update</span>
                        </div>
                        <div data-menu-item="daily-update" class="menu-item" >
                            <span class="menu-item-label" >demo</span>
                        </div>
                        <div data-menu-item="daily-update" class="menu-item" >
                            <span class="menu-item-label" >retrospective</span>
                        </div>
                        <div data-menu-item="reporting"    class="menu-item" >
                            <span class="menu-item-label" >reporting</span>
                        </div>
                    </div>
                </div>
            </div>
            <div id="perspective-content" class="containFloatedChildren" >
            </div>
        </div>
    </body>
</html>
