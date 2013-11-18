<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>

        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/view/scrum/css/backlog.css" />
        
        <jsp:include page="/include/standard-javascript-include.jsp" />

        <script type="text/javascript">

            $( document ).ready
            (
                function()
                {
               	    var backlogContent = $( '#backlog-items' );
                	
               	    function resetItemPriorities()
               	    {
               	    	var index = 1;
               	    	$( backlogContent ).find( 'input[name="priority"]' ).each
               	    	(
               	    	    function()
               	    		{
               	    		    $( this ).val( index++ );
               	    	    }
               	    	);
               	    }
               	    
                	$( backlogContent ).on
                    (
                         'click',
                         '.insert-item',
                         function()
                         {
                             var formElement = $( this ).closest( '.form' );
                             
                             // get item priorities
                             var currentItemPriority = $( this ).parent().find( 'input:first' ).val();
                             
                             // create new row from template and set priority to table order
                             var newRow = $( "#backlog-item-template" ).clone();
                             newRow.removeAttr( 'id' );
                             newRow.insertAfter( $( this ).parents( 'tr' ) );
                             
                             resetItemPriorities();
                         }
                    ); 
                    
                    $( backlogContent ).on
                    (
                         'click',
                         '.remove-item',
                            function()
                            {
                                var formElement  = $( this ).closest( '.form' );
                                var itemPriority = parseInt( $( this ).parent().find( 'input:first' ).val() );
                                var itemCount    = $( backlogContent ).find( 'input[name="priority"]' ).length;
                                var itemRow      = $( this ).closest( 'tr' )
                             
                                if( itemPriority == 1 && itemCount < 2 )
                                {
                                   $( itemRow ).clearForm();
                                }
                                else
                                {
                                   $( itemRow ).remove();
                                }
                                
                                resetItemPriorities();
                            }
                        );
                    
                    // init form if not items exist
                    if( $( backlogContent ).find( '.form-row-fields' ).length < 1 )
                    {
                            // create new row from template and set priority to table order
                            var newRow = $( "#backlog-item-template" ).clone();
                            newRow.removeAttr( 'id' );
                            newRow.find( 'input:first' ).val( 1 );
                            newRow.insertBefore( $( "#backlog-items" ).find( '.form-actions' ) );
                    }
                }
            );
        </script>
    </head>
    <body>
        <div class="vertical-spacer-center" ></div>
        <div id="backlog-items" class="form tabular-form" >
            <fieldset>
                <legend>backlog</legend>
                <table>
                    <tr class="form-row" >
                        <th class="backlog-item-priority"    >priority</th>
                        <th class="backlog-item-title"       >title</th>
                        <th class="backlog-item-theme"       >theme</th>
                        <th class="backlog-item-effort"      >effort</th>
                        <th class="backlog-item-description" >description</th>
                        <th class="backlog-item-edit"        ></th>
                    </tr>
                    <tr class="form-row form-actions form-submit-row" >
                        <td class="form-field-input" colspan="100%" >
                            <span class="form-field-action inline-right-layout" >submit</span>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
 <div id="hiddenReusableFormElements" style="display: none; " >
    <table>
           <tr id="backlog-item-template" class="form-row form-row-fields" >
            <td class="form-field-input" >
                <input type="text" name="priority" value="" class="backlog-item-field" readonly="readonly" ></input>
            </td>
            <td class="form-field-input" >
                <input type="text" name="title" value="" class="backlog-item-field" ></input>
            </td>
            <td class="form-field-input" >
                <input type="text" name="theme" value="" class="backlog-item-field" ></input>
            </td>
            <td colspan="0" >
                <input type="text" name="effort" value="" class="backlog-item-field" ></input>
            </td>
            <td class="form-field-input" >
                <textarea name="description" value="" class="backlog-item-field" ></textarea>
            </td>
            <td class="insert-item form-field-action inline-right-layout" >insert</td>
            <td class="remove-item form-field-action inline-right-layout" >remove</td>
            <td>
                <input type="hidden" name="backlog-item-description" ></input>
            </td>
        </tr>
    </table>
</div>
    </body>
</html>
