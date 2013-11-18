var shortFadeTimeInMillis  = 500;
var mediumFadeTimeInMillis = 2000;
var longFadeTimeInMillis   = 5000;

$.fn.clearForm = function()
{
    return this.each
    (
        function()
        {
            if( this.tagName.toLowerCase() != "input" )
            {
                 return $( ":input", this ).clearForm();
            }

            switch( this.type )
            {
                case "password":
                case "textarea":
                case "text":
                    this.value = "";
                    break;
                case "select-multiple":
                case "select-one":
                    this.selectedIndex = -1;
                    break;
                case "radio":
                case "checkbox":
                    this.checked = false;
                    break;
            }
        }
    );
};

/* TODO revisit for easy ".enterkey" event use
$.fn.enterKey = function( fnc )
{
    return this.each( function()
    		          {
                          $( this ).keypress( function( event )
                        		              {
                                                  var keycode = ( ev.keyCode ? ev.keyCode : ev.which );
                                                  if( keycode == '13' )
                                                  {
                                                      fnc.call( this, event );
                                                  }
                                              })
                     })
}
*/