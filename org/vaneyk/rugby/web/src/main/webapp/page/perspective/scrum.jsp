<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>
        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/css/scrum.css" />
        <script type="text/javascript" src="/rugby/js/jquery-1.7.1.js" >
        </script>
        <script type="text/javascript" src="/rugby/js/jquery-ui-1.8.16.custom.min.js" >
        </script>
        <script type="text/javascript" src="/rugby/js/script.js" >
        </script>      
        <script type="text/javascript" src="/rugby/js/http-util.js" >
        </script>
        <script type="text/javascript" src="/rugby/js/menu.js" >
        </script>
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
                    
                    $( '#scrum-product-menu-product-search-input' ).on
                    (
                        'click',
                        function()
                        {
                        	// toggle the component visibility to match the active product menu input field
                        	$( '#view-content' ).hide();
                        	$( '.scrum-component[data-component-name!="product"]' ).hide();
                        	$( '.scrum-component[data-component-name="product"]'  ).fadeIn();
                        }
                    )
                    
                    $( '#scrum-team-menu-team-search-input' ).on
                    (
                        'click',
                        function()
                        {
                        	// toggle the component visibility to match the active team menu input field
                        	$( '#view-content' ).hide();
                        	$( '.scrum-component[data-component-name!="team"]' ).hide();
                        	$( '.scrum-component[data-component-name="team"]'  ).fadeIn();
                        }
                    )
                    
                    $( '[data-component-name=product] .product-row' ).on
                    ( 
                        'click', 
                        function()
                        {
                            // get product name
                            var productName = $( this ).attr( 'data-product-name' );
                            
                            // and update the product search input 
                            if( $( '#scrum-product-menu-product-search-input' ).attr( 'value') != productName )
                            {
                                $( '#scrum-product-menu-product-search-input' ).attr( 'value', productName ).change();
                                $( '#scrum-product-menu-product-search-input' ).trigger( 'change' );
                            }
                        }
                    );
 
                    $( '[data-component-name=team] .team-row' ).on
                    ( 
                        'click', 
                        function()
                        {
                            // get team name
                            var teamName = $( this ).attr( 'data-team-name' );
                            
                            // and update the team search input 
                            if( $( '#scrum-team-menu-team-search-input' ).attr( 'value') != teamName )
                            {
                                $( '#scrum-team-menu-team-search-input' ).attr( 'value', teamName );
                                $( '#scrum-team-menu-team-search-input' ).trigger( 'change' );
                            }
                        }
                    );
                    
                    $( '#view-menu-items' ).click
                    (
                        function()
                        {
                            // update the view content
                            $( '#scrum-components' ).hide();
                            $( '#view-content' ).fadeIn();
                        }
                    ) 
                    
                }
            );
        </script>
    </head>
    <body>
        <div id="perspective-scrum" >
            <div id="header" class="containFloatedChildren" >
            </div>
            <div id="scrum-components" class="containFloatedChildren" >
                <div class="scrum-component" data-component-name="product" >
<!-- TODOl: add, modify, delete product here? -->
	                <fieldset class="selection-list" >
	                    <legend>select</legend>
	                    <table class="data" >
	                        <tr>
	                           <th>name</th>
	                           <th>owner</th>
	                           <th>description</th>
	                        </tr>
	                        <tr class="product-row" data-product-name="product 1" >
	                            <td class="product-name"        >product 1</td>
	                            <td class="product-owner"       >jimmy product-owner</td>
	                            <td class="product-description" >Production description blah blah blah...</td>
	                        </tr>
	                        <tr class="product-row" data-product-name="product 2" >
	                            <td class="product-name"        >product 2</td>
	                            <td class="product-owner"       >jimmy product-owner</td>
	                            <td class="product-description" >Production description blah blah blah...</td>
	                        </tr>
	                        <tr class="product-row" data-product-name="product 3" >
	                            <td class="product-name"        >product 3</td>
	                            <td class="product-owner"       >jimmy product-owner</td>
	                            <td class="product-description" >Production description blah blah blah...</td>
	                        </tr>
	                    </table>
	                </fieldset>
                </div>
                <div class="scrum-component" data-component-name="team" >
	                <fieldset class="selection-list" >
	                    <legend>select</legend>
	                    <table class="data" >
	                        <tr>
	                           <th>name</th>
	                           <th>owner</th>
	                           <th>description</th>
	                        </tr>
	                        <tr class="team-row" data-team-name="team 1" >
	                            <td>team 1</td>
	                            <td>joe owner</td>
	                            <td>Team description</td>
	                        </tr>
	                        <tr class="team-row" data-team-name="team 2" >
	                            <td>team 2</td>
	                            <td>joe owner</td>
	                            <td>Team description</td>
	                        </tr>
	                        <tr class="team-row" data-team-name="team 3" >
	                            <td>team 3</td>
	                            <td>joe owner</td>
	                            <td>Team description</td>
	                        </tr>
	                    </table>
	                </fieldset>
                </div>
            </div>
            <div id="view-content" >
                view content!
            </div>
        </div>
    </body>
</html>
