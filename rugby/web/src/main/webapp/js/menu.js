var DEFAULT_VERTICAL_MENU_SLIDER_PAD_OUT         = 25;
var DEFAULT_VERTICAL_MENU_SLIDER_PAD_IN          = 15;
var DEFAULT_VERTICAL_MENU_SLIDER_RATE            = 250;
var DEFAULT_VERTICAL_MENU_SLIDER_RATE_MULTIPLIER = 1.5;

function verticalMenuSlide( menuElement, padOut, padIn, rate, rateMultiplier )
{
    // use defaults if inputs not provided
    padOut         = ( padOut         == null ? DEFAULT_VERTICAL_MENU_SLIDER_PAD_OUT         : padOut         );
    padIn          = ( padIn          == null ? DEFAULT_VERTICAL_MENU_SLIDER_PAD_IN          : padIn          );
    rate           = ( rate           == null ? DEFAULT_VERTICAL_MENU_SLIDER_RATE            : rate           );
    rateMultiplier = ( rateMultiplier == null ? DEFAULT_VERTICAL_MENU_SLIDER_RATE_MULTIPLIER : rateMultiplier );

    // create the slide effects for each menu item
    var menuItems = menuElement.children( '.menu-items' ).children( '.menu-item' ); // TODO refine this select
    var timer = 0;
    $( menuItems ).each
    (
        function( i )
        {
            // margin left = - ([width of element] + [total vertical padding of element])
            $( this ).css( "margin-left","-180px" );
        
            // updates timer
            timer = ( rate * rateMultiplier + rate );
            $( this ).animate( { marginLeft: "0"    }, timer );
            $( this ).animate( { marginLeft: "15px" }, timer );
            $( this ).animate( { marginLeft: "0"    }, timer );

            // create a hover slide effect for the menu item label
            $( this ).children( '.menu-item-label' ).hover
            (
                function()
                {
                    $( this ).animate( { paddingLeft: padOut }, 150 );
                },        
                function()
                {
                     $( this ).animate( { paddingLeft: padIn }, 150 );
                }
            );
        }
    );
}

$( document ).ready
(
    function()
    {
        $( '.menu' ).mouseenter
        (
            function()
            {
                $( this ).children( '.menu-items' ).fadeIn( shortFadeTimeInMillis );

                verticalMenuSlide( $( this ) );
            }
        )
        $( '.menu' ).mouseleave
        (
            function()
            {
                $( this ).children( '.menu-items' ).fadeOut( shortFadeTimeInMillis );
            }
        )
        $( '.menu-item-label' ).hover
        (
            function()
            {
                $( this ).css( 'color',     '#000000' );
                $( this ).css( 'font-size', '200%'    );
            }
        )
        $( '.menu-item-label' ).mouseleave
        (
            function()
            {
                $( this ).css( 'color',     '#FFFFFF' );
                $( this ).css( 'font-size', '100%'    );
            }
        )
        $( '.menu-item' ).click
        (
            function()
            {
                // get menu item value
                menuItemValue = $( this ).attr( 'data-menu-item' );
                
                // update the selected view value in the view menu label
                menuLabel      = $( this ).parent().parent().children( '.menu-header' ).children( '.menu-label' );
                menuLabelValue = $( menuLabel ).children( '.menu-label-value' );
                $( menuLabelValue ).hide();
                $( menuLabelValue ).html( menuItemValue );
                $( menuLabelValue ).fadeIn( shortFadeTimeInMillis );
            }
        )            
        
    }
);

/* TODO revisit horizontal sliding menus
function horizontalSlide( navigation_id, pad_out, pad_in, time, multiplier )
{
    // creates the target paths
    var list_elements = navigation_id + " li.horizontal-sliding-element";
    var link_elements = list_elements + " a";
    
    // initiates the timer used for the sliding animation
    var timer = 0;
    
    // creates the slide animation for all list elements 
    $( list_elements ).each
    (
        function( i )
        {
            // margin left = - ([width of element] + [total vertical padding of element])
            $( this ).css( "margin-left","-180px" );
        
            // updates timer
            timer = ( timer * multiplier + time );
            $( this ).animate( { marginLeft: "0"    }, timer );
            $( this ).animate( { marginLeft: "15px" }, timer );
            $( this ).animate( { marginLeft: "0"    }, timer );
        }
    );

    // creates the hover-slide effect for all link elements         
    $( link_elements ).each
    (
        function( i )
        {
              $(this).hover
              (
                function()
                {
                    $( this ).animate( { paddingLeft: pad_out }, 150 );
                },        
                function()
                {
                     $( this ).animate( { paddingLeft: pad_in }, 150 );
                }
            );
        }
    );
}

$( document ).ready
(
    function()
    {
        horizontalSlide( ".horizontal-sliding-navigation", 25, 15, 150, .8 );
        
        $( '.horizontal-sliding-menu' ).mouseenter
        (
            function()
            {
                $( '.horizontal-sliding-menu-items' ).fadeIn( shortFadeTimeInMillis );
            }
        )
        $( '.horizontal-sliding-menu' ).mouseleave
        (
            function()
            {
                $( '.horizontal-sliding-menu-items' ).fadeOut( shortFadeTimeInMillis );
            }
        )           
    }
);

*/