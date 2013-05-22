<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>
        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/css/perspective.css"  />
        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/css/admin.css" />
        <script type="text/javascript" src="/rugby/js/jquery-1.7.1.js" >
        </script>
        <script type="text/javascript" src="/rugby/js/jquery-ui-1.8.16.custom.min.js" >
        </script>
        <script type="text/javascript" src="/rugby/js/script.js" >
        </script>      
        <script type="text/javascript" src="/rugby/js/http-util.js" >
        </script>
        <script type="text/javascript">
            var bodyOnClickOneTime = false;
            
            $( document ).ready
            (
                function()
                {
                    // set ui behaviors
                    
                    // --- admin menu items -------------------------------------------------------------------------------
                    $( '#admin-menu-items *[admin]' ).on
                    ( 
                        'click', 
                        function()
                        {
                            // get admin
                            var admin = $( this ).attr( 'admin' );
                            
                            // update the selected admin value in the admin menu label
                            $( '#admin-menu-label-selected-admin-value-wrapper' ).hide();
                            $( '#admin-menu-label-selected-admin-value'         ).html( admin );
                            $( '#admin-menu-label-selected-admin-value-wrapper' ).fadeIn( shortFadeTimeInMillis );
                        }
                    );
                    $( '#admin-menu > .menu-items > [data-menu-item]' ).on
                    ( 
                        'click',
                        function()
                        {
                            // toggle admin component based on selected menu item
                            var menuItem = $( this ).attr( 'data-menu-item' );
                            $( '#admin-components > [data-admin-component]' ).hide();
                            $( '#admin-components > [data-admin-component=' + menuItem + ']' ).fadeIn( shortFadeTimeInMillis );
                        }
                    );
                    $( '#admin-components .perspective-actions > .perspective-action' ).on
                    ( 
                        'click',
                        function()
                        {
                            // get form name
                            var formName = $( this ).attr( 'data-action-form-name' );
                            
                            // swap forms 
                            // NOTE: jquery fadeIn seems to use display: block under the covers, since these forms use display table we apply the fade to the forms parent div ;)
                            $( this ).closest( '.component' ).find( '.perspective-component-forms' ).hide();
                            $( this ).closest( '.component' ).find( '.form' ).hide();
                            $( this ).closest( '.component' ).find( '.form[data-action-form-name=' + formName + ']' ).css( 'display', 'block' );
                            $( this ).closest( '.component' ).find( '.perspective-component-forms' ).fadeIn( shortFadeTimeInMillis );
                        }
                    );
            
                    // --- user add forms ---------------------------------------------------------------------------------
                    $( '.clone-row' ).on
                    ( 
                        'click',
                        function()
                        {
                            // clone new row
                            var cloneOfThisRow = $( this ).closest( '.form-row' ).clone();
                            cloneOfThisRow.insertBefore( $( this ).closest( '.form' ).find( '.form-actions' ) );
                        }
                    );
                    $( '.add-row' ).on
                    ( 
                        'click',
                        function()
                        {
                            // clone new row
                            var cloneOfThisRow = $( this ).closest( '.form-row' ).clone();
                            cloneOfThisRow.clearForm();
                            cloneOfThisRow.insertBefore( $( this ).closest( '.form' ).find( '.form-actions' ) );
                        }
                    );
                    $( '.delete-row' ).on
                    ( 
                        'click',
                        function()
                        {
                            // if there is only one row left just clear it
                            if( $( this ).closest( '.form' ).find( '.form-row-fields' ).length == 1 )
                            {
                                $( this ).closest( '.form' ).find( '.form-row-fields' ).clearForm();
                            }
                            else
                            {
                                // otherwise delete the row
                                var cloneOfThisRow = $( this ).closest( '.form-row' ).remove();
                            }
                        }
                    );
            
                    // --- user modify forms ------------------------------------------------------------------------------
                    $( '.user-action-modify-subaction-select-user' ).on
                    ( 
                        'click',
                        function()
                        {
                            // NOTE: algorithm assumes 
                            //       1) select and modify fields have the same count
                            //       2) select and modify fields have the same order
                            //       3) select fields have data attributes
                            //       4) modify fields are inputs
                            //       5) the modify row has a data field for the user email address
                            //       6) if the selected user is already present the user is notified
                            
                            var originalEmail   = $( this ).find( '[data-email]' ).attr( 'data-email' );
                            var alreadySelected = $( '.subaction-submit-form-table-row[data-original-email="' + originalEmail + '"]' );
                            
                            if( alreadySelected != null && alreadySelected.length > 0 )
                            {
                                alert( 'You have already selected this user.' ); // TODO update when a standard dialog option is chosen
                            }
                            else
                            {
                                // get a new modify row and a handle to its inputs
                                var newUserActionModifySubactionSubmitFormRow       = $( '#TEMPLATE-user-action-modify-subaction-submit-form-table-row' ).clone();
                                    newUserActionModifySubactionSubmitFormRow.removeAttr( 'id' );
                                var newUserActionModifySubactionSubmitFormRowInputs = $( newUserActionModifySubactionSubmitFormRow ).find( '.form-input' );
                                
                                // iterate over the select fields
                                var fieldIndex = 0;
                                $( this ).children( '.copy-field' ).each
                                (
                                    function()
                                    {
                                        // iterate over the select field attributes
                                        var selectAttributes = $( $( this )[ 0 ].attributes ).each
                                        (
                                            function()
                                            {
                                                // copy the data elements from the select field to the modify field
                                                var dataAttributeStartsWith = 'data-';
                                                if( this.name.substring( 0, dataAttributeStartsWith.length ) == dataAttributeStartsWith )
                                                {
                                                    $( newUserActionModifySubactionSubmitFormRowInputs[ fieldIndex ] ).attr( this.name, this.value );
                                                    $( newUserActionModifySubactionSubmitFormRowInputs[ fieldIndex ] ).attr( 'value',   this.value );
                                                    
                                                    // give the selected email value to the row's data-original-email attribute
                                                    if( this.name == 'data-email' )
                                                    {
                                                        newUserActionModifySubactionSubmitFormRow.attr( 'data-original-email', this.value );
                                                    }
                                                   }
                                            }
                                        )
                                        
                                        // increment field index
                                        fieldIndex++;
                                    }
                                );
    
                                // give the new row to the submit table
                                var thisForm        = $( this ).closest( '.form' );
                                var thisFormActions = $( thisForm ).find( '.form-actions' );
                                $( newUserActionModifySubactionSubmitFormRow ).insertBefore( $( thisFormActions ) );
                                $( newUserActionModifySubactionSubmitFormRow ).show();
      
                                //  show the submit/cancel buttons in the event the form was empty and the buttons were hidden
                                $( thisFormActions ).show();
                            }
                        }
                    );
                    $( '.user-action-modify-subaction-submit-form-table-team-input' ).on
                    ( 
                        'mouseenter',
                        function()
                        {
                            var optionsElement       = $( this ).next( '.user-action-modify-subaction-submit-form-table-team-input-options' );
                            var topJustBelowInput    = $( this ).position().top + ( 1.1 * $( this ).height() );
                            var leftCenterdOnInput   = $( this ).position().left + $( this ).width() / 2 - optionsElement.width() / 2;
                            // TODO standard jquery offet, position functions didn't seem to behave so this is a bit old school, revisit
                            optionsElement.css( 'position', 'absolute'         );
                            optionsElement.css( 'top',      topJustBelowInput  );
                            optionsElement.css( 'left',     leftCenterdOnInput );
                            optionsElement.show();
                        }
                    );
                    $( '.user-action-modify-subaction-submit-form-table-team-input-options' ).on
                    (
                        'mouseleave',
                        function()
                        {
                            $( this ).hide();
                        }
                    ); 
                    $( '.user-action-modify-subaction-submit-form-table-team-input-option' ).on
                    (
                        'click',
                        function()
                        {
                            var team  = $( this ).attr( 'data-team' );
                            // TODO replace > input with > .user-action-modify-subaction-submit-form-table-team-input, not sure why the class select or is not working and it is preferable
                            $( this ).closest( '.user-action-modify-subaction-submit-form-table-team-input-cell' ).find ( '> input' ).val( team );
                        }
                    );
                    $( '.remove-me-button' ).on
                    (
                        'click',
                        function()
                        {
                            // cache a few things before removing the element as once it's removed we can't navigate the dom above it anymore ;)
                            var actionSubmitTable    = $( this ).closest( '.action-submit-table' );
                            var rowCountBeforeDelete = $( actionSubmitTable ).find( '.form-row' ).length;
                            
                            // remove the row
                            $( this ).closest( '.subaction-submit-form-table-row' ).remove();
                            
                            // hide submit/cancel row if the delete form is empty  NOTE: < 3 because 1 data row + 1 submit button row :)
                            if( rowCountBeforeDelete < 3 )
                            {
                                $( actionSubmitTable ).find( '.form-submit-row' ).hide();
                            }
                            else
                            {
                                $( actionSubmitTable ).find( '.form-submit-row' ).show();
                               }
                        }
                    );

                    // --- user delete forms ------------------------------------------------------------------------------
                    $( '.user-action-delete-subaction-select-user' ).on
                    ( 
                        'click',
                        function()
                        {
                            // NOTE: algorithm assumes 
                            //       1) select and delete fields have the same count
                            //       2) select and delete fields have the same order
                            //       3) select fields have data attributes
                            //       4) the delete row has a data field for the user email address
                            //       5) if the selected user is already present the user is notified
                            
                            var email           = $( this ).find( '[data-email]' ).attr( 'data-email' );
                            var alreadySelected = $( this ).closest( '.form' ).find( '.subaction-submit-form-table-row[data-email="' + email + '"]' );
                            
                            if( alreadySelected != null && alreadySelected.length > 0 )
                            {
                                alert( 'You have already selected this user.' ); // TODO update when a standard dialog option is chosen
                            }
                            else
                            {
                                // get a new delete row and a handle to its inputs
                                var newUserActionDeleteSubactionSubmitFormRow       = $( '#TEMPLATE-user-action-delete-subaction-submit-form-table-row' ).clone();
                                    newUserActionDeleteSubactionSubmitFormRow.removeAttr( 'id' );
                                var newUserActionDeleteSubactionSubmitFormRowInputs = $( newUserActionDeleteSubactionSubmitFormRow ).find( '.form-input' );
                                
                                // iterate over the select fields
                                fieldIndex = 0;
                                $( this ).children( '.copy-field' ).each
                                (
                                    function()
                                    {
                                        // iterate over the select field attributes
                                        selectAttributes = $( $( this )[ 0 ].attributes ).each
                                        (
                                            function()
                                            {
                                                // copy the data elements from the select field to the delete field
                                                dataAttributeStartsWith = 'data-';
                                                if( this.name.substring( 0, dataAttributeStartsWith.length ) == dataAttributeStartsWith )
                                                {
                                                    $( newUserActionDeleteSubactionSubmitFormRowInputs[ fieldIndex ] ).html( this.value );
                                                    
                                                    // give the selected email value to the row's data-email attribute
                                                    if( this.name == 'data-email' )
                                                    {
                                                        newUserActionDeleteSubactionSubmitFormRow.attr( 'data-email', this.value );
                                                    }
                                                   }
                                            }
                                        )
                                        
                                        // increment field index
                                        fieldIndex++;
                                    }
                                );
    
                                // give the new row to the submit table
                                var thisForm        = $( this ).closest( '.form' );
                                var thisFormActions = $( thisForm ).find( '.form-actions' );
                                $( newUserActionDeleteSubactionSubmitFormRow ).insertBefore( $( thisFormActions ) );
                                $( newUserActionDeleteSubactionSubmitFormRow ).show();
      
                                //  show the submit/cancel buttons in the event the form was empty and the buttons were hidden
                                $( thisFormActions ).show();                                
                            }
                        }
                    );
                    $( '.user-action-delete-subaction-submit-form-table-team-input' ).on
                    ( 
                        'mouseenter',
                        function()
                        {
                            var optionsElement       = $( this ).next( '.user-action-delete-subaction-submit-form-table-team-input-options' );
                            var topJustBelowInput    = $( this ).position().top + ( 1.1 * $( this ).height() );
                            var leftCenterdOnInput   = $( this ).position().left + $( this ).width() / 2 - optionsElement.width() / 2;
                            // TODO standard jquery offet, position functions didn't seem to behave so this is a bit old school, revisit
                            optionsElement.css( 'position', 'absolute'         );
                            optionsElement.css( 'top',      topJustBelowInput  );
                            optionsElement.css( 'left',     leftCenterdOnInput );
                            optionsElement.show();
                        }
                    );
                    $( '.user-action-delete-subaction-submit-form-table-team-input-options' ).on
                    (
                        'mouseleave',
                        function()
                        {
                            $( this ).hide();
                        }
                    ); 
                    $( '.user-action-delete-subaction-submit-form-table-team-input-option' ).on
                    (
                        'click',
                        function()
                        {
                            var team  = $( this ).attr( 'data-team' );
                            // TODO replace > input with > .user-action-delete-subaction-submit-form-table-team-input, not sure why the class select or is not working and it is preferable
                            $( this ).closest( '.user-action-delete-subaction-submit-form-table-team-input-cell' ).find ( '> input' ).val( team );
                        }
                    );
                    $( '.remove-me-button' ).on
                    (
                        'click',
                        function()
                        {
                            // cache a few things before removing the element as once it's removed we can't navigate the dom above it anymore ;)
                            var actionSubmitTable    = $( this ).closest( '.action-submit-table' );
                            var rowCountBeforeDelete = $( this ).closest( '.action-submit-table' ).find( '.form-row' ).length;
                            
                            // remove the row
                            $( this ).closest( '.subaction-submit-form-table-row' ).remove();
                            
                            // hide submit/cancel row if the delete form is empty  NOTE: < 3 because 1 data row + 1 submit button row :)
                            if( rowCountBeforeDelete < 3 )
                            {
                                $( actionSubmitTable ).find( '.form-submit-row' ).hide();
                            }
                            else
                            {
                                $( actionSubmitTable ).find( '.form-submit-row' ).show();
                               }
                        }
                    )
                    
                    // --- team add forms ---------------------------------------------------------------------------------
                    $( '.team-action-any-subaction-select-user' ).on
                    ( 
                        'click',
                        function()
                        {
                            // NOTE: algorithm assumes 
                            //       1) select and add fields have the same count
                            //       2) select and add fields have the same order
                            //       3) select fields have data attributes
                            //       4) the add row has a data field for the user email address
                            //       5) if the selected user is already present the user is notified
                            
                            var email           = $( this ).find( '[data-email]' ).attr( 'data-email' );
                            var alreadySelected = $( this ).closest( '.form' ).find( '.subaction-submit-form-table-row[data-email="' + email + '"]' );
                            
                            if( alreadySelected != null && alreadySelected.length > 0 )
                            {
                                alert( 'You have already selected this user.' ); // TODO update when a standard dialog option is chosen
                            }
                            else
                            {
                                // get a new user add row and a handle to its inputs
                                var addTeamActionSelectUserSubactionSubmitFormRow       = $( '#TEMPLATE-team-action-any-subaction-submit-form-table-row' ).clone();
                                    addTeamActionSelectUserSubactionSubmitFormRow.removeAttr( 'id' );
                                var addTeamActionSelectUserSubactionSubmitFormRowInputs = $( addTeamActionSelectUserSubactionSubmitFormRow ).find( '.form-input' );
                                
                                // iterate over the select fields
                                var fieldIndex = 0;
                                $( this ).children( '.copy-field' ).each
                                (
                                    function()
                                    {
                                        // iterate over the select field attributes
                                        selectAttributes = $( $( this )[ 0 ].attributes ).each
                                        (
                                            function()
                                            {
                                                // copy the data elements from the select field to the delete field
                                                var dataAttributeStartsWith = 'data-';
                                                if( this.name.substring( 0, dataAttributeStartsWith.length ) == dataAttributeStartsWith )
                                                {
                                                    $( addTeamActionSelectUserSubactionSubmitFormRowInputs[ fieldIndex ] ).html( this.value );
                                                    
                                                    // give the selected email value to the row's data-email attribute
                                                    if( this.name == 'data-email' )
                                                    {
                                                        addTeamActionSelectUserSubactionSubmitFormRow.attr( 'data-email', this.value );
                                                    }
                                                   }
                                            }
                                        )
                                        
                                        // increment field index
                                        fieldIndex++;
                                    }
                                );
    
                                // give the new row to the submit table
                                var thisForm        = $( this ).closest( '.form' );
                                var thisFormActions = $( thisForm ).find( '.form-actions' );
                                $( addTeamActionSelectUserSubactionSubmitFormRow ).insertBefore( $( thisFormActions ) );
                                $( addTeamActionSelectUserSubactionSubmitFormRow ).show();
      
                                //  show the submit/cancel buttons in the event the form was empty and the buttons were hidden
                                $( thisFormActions ).show();                                
                            }
                        }
                    );
                    // unfortunately the delete action is special :(
                    $( '.team-action-delete-subaction-select-team' ).on
                    ( 
                        'click',
                        function()
                        {
                            // NOTE: algorithm assumes 
                            //       1) select and add fields have the same count
                            //       2) select and add fields have the same order
                            //       3) select fields have data attributes
                            //       4) the add row has a data field for the user team address
                            //       5) if the selected user is already present the user is notified
                            
                            var team            = $( this ).find( '[data-team]' ).attr( 'data-team' );
                            var alreadySelected = $( this ).closest( '.form' ).find( '.subaction-submit-form-table-row[data-team="' + team + '"]' );
                            
                            if( alreadySelected != null && alreadySelected.length > 0 )
                            {
                                alert( 'You have already selected this team.' ); // TODO update when a standard dialog option is chosen
                            }
                            else
                            {
                                // get a new user add row and a handle to its inputs
                                var addTeamActionSelectUserSubactionSubmitFormRow       = $( '#TEMPLATE-team-action-delete-subaction-submit-form-table-row' ).clone();
                                    addTeamActionSelectUserSubactionSubmitFormRow.removeAttr( 'id' );
                                var addTeamActionSelectUserSubactionSubmitFormRowInputs = $( addTeamActionSelectUserSubactionSubmitFormRow ).find( '.form-input' );
                                
                                // iterate over the select fields
                                var fieldIndex = 0;
                                $( this ).children( '.copy-field' ).each
                                (
                                    function()
                                    {
                                        // iterate over the select field attributes
                                        selectAttributes = $( $( this )[ 0 ].attributes ).each
                                        (
                                            function()
                                            {
                                                // copy the data elements from the select field to the delete field
                                                var dataAttributeStartsWith = 'data-';
                                                if( this.name.substring( 0, dataAttributeStartsWith.length ) == dataAttributeStartsWith )
                                                {
                                                    $( addTeamActionSelectUserSubactionSubmitFormRowInputs[ fieldIndex ] ).html( this.value );
                                                    
                                                    // give the selected team value to the row's data-team attribute
                                                    if( this.name == 'data-team' )
                                                    {
                                                        addTeamActionSelectUserSubactionSubmitFormRow.attr( 'data-team', this.value );
                                                    }
                                                   }
                                            }
                                        )
                                        
                                        // increment field index
                                        fieldIndex++;
                                    }
                                );
    
                                // give the new row to the submit table
                                var thisForm        = $( this ).closest( '.form' );
                                var thisFormActions = $( thisForm ).find( '.form-actions' );
                                $( addTeamActionSelectUserSubactionSubmitFormRow ).insertBefore( $( thisFormActions ) );
                                $( addTeamActionSelectUserSubactionSubmitFormRow ).show();
      
                                //  show the submit/cancel buttons in the event the form was empty and the buttons were hidden
                                $( thisFormActions ).show();                                
                            }
                        }
                    );                    
                    $( '.remove-me-button' ).on
                    (
                        'click',
                        function()
                        {
                            // cache a few things before removing the element as once it's removed we can't navigate the dom above it anymore ;)
                            var actionSubmitTable    = $( this ).closest( '.action-submit-table' );
                            var rowCountBeforeDelete = $( this ).closest( '.action-submit-table' ).find( '.form-row' ).length;
                            
                            // remove the row
                            $( this ).closest( '.subaction-submit-form-table-row' ).remove();
                            
                            // hide submit/cancel row if the delete form is empty  NOTE: < 3 because 1 data row + 1 submit button row :)
                            if( rowCountBeforeDelete < 3 )
                            {
                                $( actionSubmitTable ).find( '.form-submit-row' ).hide();
                            }
                            else
                            {
                                $( actionSubmitTable ).find( '.form-submit-row' ).show();
                               }
                        }
                    )                    
                }
            );
        </script>
    </head>
    <body>
<!-- TODO delete me
        <div id="admin-content" >
            <div>TODO</div>
            <div>user: add, modify, delete</div>
            <div>team: add, modify, delete</div>
            <div>notifications: add, modify, delete</div>
            <div>system: settings - port, etc; bounce app; ...</div>
        </div>
-->
        <div id="admin-components" >
            <div id="admin-component-user" data-admin-component="user" class="component containFloatedChildren" >
                <div id="user-actions" class="perspective-actions" >
                    <div id="user-action-add"    class="perspective-action" data-action-form-name="add"    >
                        add
                    </div>
                    <div id="user-action-modify" class="perspective-action" data-action-form-name="modify" >
                        modify
                    </div>
                    <div id="user-action-delete" class="perspective-action" data-action-form-name="delete" >
                        delete
                    </div>
                    <div id="user-action-delete" class="perspective-action" data-action-form-name="bulk-delete" >
                        bulk delete
                    </div>                    
                </div>
                <div class="perspective-component-forms containFloatedChildren" >
                    <div id="user-action-add-form" class="form tabular-form" data-action-form-name="add" >
                        <fieldset>
                            <legend>add</legend>
                            <table>
                                <tr class="form-row" >
                                    <td class="form-field-label" >user</td>
                                    <td class="form-field-label" >email</td>
                                    <td class="form-field-label" >first name</td>
                                    <td class="form-field-label" >last name</td>
                                    <td class="form-field-label" >password</td>
                                    <td class="form-field-label" >confirm password</td>
                                    <td class="form-field-label" ><!-- add/delete entry has no label --></td>                            
                                </tr>
                                <tr class="form-row form-row-fields" >
                                    <!--  TODO for some reason firefox doesn't treat the form-field-input class on an input element the same as span elements so 
                                              we are wrapping the input elements with span elements here :(
                                    -->
                                    <td class="form-field-input" >
                                        <input name="user-action-add-form-user-input"               type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-add-form-email-input"              type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-add-form-first-name-input"         type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-add-form-last-name-input"          type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-add-form-password-input"           type="password" />
                                    </td>                            
                                    <td class="form-field-input" >
                                        <input name="user-action-add-form-confirm-password-input"   type="password" />
                                    </td>
                                    <td class="                             inline-right-layout"                ><!-- no content, just for styling --></td>
                                    <td class="clone-row  form-field-action inline-right-layout" >clone</td>
                                    <td class="add-row    form-field-action inline-right-layout" >add</td>
                                    <td class="delete-row form-field-action inline-right-layout" >remove</td>
                                </tr>
                                <tr class="form-row form-actions form-submit-row" >
                                    <td class="form-field-input" colspan="100%" >
                                        <span class="form-field-action inline-right-layout" >submit</span>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>                  
                    <div id="user-action-modify-form" class="form tabular-form containFloatedChildren" data-action-form-name="modify" >
                        <fieldset class="tabular-form" data-action-form-name="modify" >
                            <legend>search</legend>
                            <table>
                                <tr class="form-row form-row-fields" >
                                    <td class="form-field-label" >user</td>
                                    <td class="form-field-label" >first name</td>
                                    <td class="form-field-label" >last name</td>
                                    <td class="form-field-label" >email</td>
                                    <td class="form-field-label" >team</td>
                                </tr>
                                <tr class="form-row form-row-fields" >
                                    <!--  TODO for some reason firefox doesn't treat the form-field-input class on an input element the same as span elements so 
                                              we are wrapping the input elements with span elements here :(
                                    -->
                                    <td class="form-field-input" >
                                        <input name="user-action-modify-subaction-search-form-user-input"               type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-modify-subaction-search-form-first-name-input"         type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-modify-subaction-search-form-last-name-input"          type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-modify-subaction-search-form-email-input"              type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-modify-subaction-search-form-team"                     type="text"     />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset class="action-subaction-select-form-left" >
                            <legend>select</legend>
                            <table class="data" title="click to modify" >
                                <tr class="user-action-modify-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joe.user"           >joe.user</td>
                                    <td class="copy-field" data-first-name="Joe"                >Joe</td>
                                    <td class="copy-field" data-last-name ="User"               >User</td>
                                    <td class="copy-field" data-email     ="joe.user@email.com" >joe.user@email.com</td>
                                </tr>
                                <tr class="user-action-modify-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joanne.user"            >joanne.user</td>
                                    <td class="copy-field" data-first-name="JoeAnne"                >JoeAnne</td>
                                    <td class="copy-field" data-last-name ="User"                   >User</td>
                                    <td class="copy-field" data-email     ="joeanne.user@email.com" >joeanne.user@email.com</td>
                                </tr>
                            </table>                        
                        </fieldset>
                        <fieldset class="action-submit-form action-subaction-select-form-right" >
                            <legend>modify</legend>
                            <table class="action-submit-table " >
                                <tr class="form-row form-actions form-submit-row" >
                                    <td class="form-field-input" colspan="100%" >
                                        <span class="form-field-action inline-right-layout" >submit</span>
                                    </td>
                                </tr>                            
                            </table>
                        </fieldset>
                    </div>
                    <div id="user-action-delete-form" class="form tabular-form containFloatedChildren" data-action-form-name="delete" >
                        <fieldset class="tabular-form" data-action-form-name="delete" >
                            <legend>search</legend>
                            <table>
                                <tr class="form-row form-row-fields" >
                                    <td class="form-field-label" >user</td>
                                    <td class="form-field-label" >first name</td>
                                    <td class="form-field-label" >last name</td>
                                    <td class="form-field-label" >email</td>
                                    <td class="form-field-label" >team</td>
                                </tr>
                                <tr class="form-row form-row-fields" >
                                    <!--  TODO for some reason firefox doesn't treat the form-field-input class on an input element the same as span elements so 
                                              we are wrapping the input elements with span elements here :(
                                    -->
                                    <td class="form-field-input" >
                                        <input name="user-action-delete-subaction-search-form-user-input"               type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-delete-subaction-search-form-first-name-input"         type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-delete-subaction-search-form-last-name-input"          type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-delete-subaction-search-form-email-input"              type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="user-action-delete-subaction-search-form-team"                     type="text"     />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset class="action-subaction-select-form-left" >
                            <legend>select</legend>
                            <table class="data" title="click to delete" >
                                <tr class="user-action-delete-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joe.user"           >jose.user</td>
                                    <td class="copy-field" data-first-name="Joe"                >Joe</td>
                                    <td class="copy-field" data-last-name ="User"               >User</td>
                                    <td class="copy-field" data-email     ="joe.user@email.com" >joe.user@email.com</td>
                                    <td class="copy-field" data-team      ="team1"              >team1</td>
                                </tr>
                                <tr class="user-action-delete-subaction-select-user" >
                                    <td class="copy-field" data-user="joanne.user"                  >joanne.user</td>
                                    <td class="copy-field" data-first-name="JoeAnne"                >JoeAnne</td>
                                    <td class="copy-field" data-last-name ="User"                   >User</td>
                                    <td class="copy-field" data-email     ="joeanne.user@email.com" >joeanne.user@email.com</td>
                                    <td class="copy-field" data-team      ="team1"                  >team2</td>
                                </tr>
                                <tr class="user-action-delete-subaction-select-user" >
                                    <td class="copy-field" data-user      ="fooanne.user"           >fooanne.user</td>
                                    <td class="copy-field" data-first-name="FooAnne"                >FooAnne</td>
                                    <td class="copy-field" data-last-name ="User"                   >User</td>
                                    <td class="copy-field" data-email     ="Fooanne.user@email.com" >fooanne.user@email.com</td>
                                    <td class="copy-field" data-team      ="team1"                  >team2</td>
                                </tr>                                
                            </table>                        
                        </fieldset>
                        <fieldset class="action-submit-form action-subaction-select-form-right" >
                            <legend>delete</legend>
                            <table class="action-submit-table data" >
                                <tr class="form-row form-actions form-submit-row" >
                                    <td class="form-field-input" colspan="100%" >
                                        <span class="form-field-action inline-right-layout" >submit</span>
                                    </td>
                                </tr>                            
                            </table>
                        </fieldset>
                    </div>
                    <div id="user-action-bulk-delete-form" class="form tabular-form containFloatedChildren" data-action-form-name="bulk-delete" >
                        <fieldset class="tabular-form" data-action-form-name="bulk-delete" >
                            <legend>bulk-delete</legend>
                            <textarea class="bulk-delete-input" rows="40" cols="100" >Provide a comma delimited list of users here to perform a bulk delete.</textarea>
                            <span class="form-field-action inline-right-layout tabular-form form-submit-row action-bulk-delete-subaction-action-form-submit" >submit</span>
                        </fieldset>
                    </div>
                </div>
            </div>
            <div id="admin-component-team" data-admin-component="team" class="component containFloatedChildren" >
                <div id="team-actions" class="perspective-actions" >
                    <div id="team-action-add"    class="perspective-action" data-action-form-name="add"    >
                        add
                    </div>
                    <div id="team-action-modify" class="perspective-action" data-action-form-name="modify" >
                        modify
                    </div>
                    <div id="team-action-delete" class="perspective-action" data-action-form-name="delete" >
                        delete
                    </div>
                    <div id="team-action-delete" class="perspective-action" data-action-form-name="bulk-delete" >
                        bulk delete
                    </div>                    
                </div>
                <div class="perspective-component-forms containFloatedChildren" >
                    <div id="team-action-add-form" class="form tabular-form" data-action-form-name="add" >
                        <fieldset class="tabular-form" data-action-form-name="add" >
                            <legend>search user</legend>
                            <table>
                                <tr class="form-row form-row-fields" >
                                    <td class="form-field-label" >user</td>
                                    <td class="form-field-label" >first name</td>
                                    <td class="form-field-label" >last name</td>
                                    <td class="form-field-label" >email</td>
                                    <td class="form-field-label" >team</td>
                                </tr>
                                <tr class="form-row form-row-fields" >
                                    <!--  TODO for some reason firefox doesn't treat the form-field-input class on an input element the same as span elements so 
                                              we are wrapping the input elements with span elements here :(
                                    -->
                                    <td class="form-field-input" >
                                        <input name="team-action-add-subaction-search-form-user-input"               type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-add-subaction-search-form-first-name-input"         type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-add-subaction-search-form-last-name-input"          type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-add-subaction-search-form-email-input"              type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-add-subaction-search-form-team"                     type="text"     />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset class="action-subaction-select-form-left" >
                            <legend>select user</legend>
                            <table class="data" title="click to add" >
                                <tr class="team-action-any-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joe.user"           >joe.user</td>
                                    <td class="copy-field" data-first-name="Joe"                >Joe</td>
                                    <td class="copy-field" data-last-name ="team"               >User</td>
                                    <td class="copy-field" data-email     ="joe.team@email.com" >joe.user@email.com</td>
                                    <td class="copy-field" data-team      ="team1"              >team1</td>
                                </tr>
                                <tr class="team-action-any-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joeanne.user"           >joeanne.user</td>
                                    <td class="copy-field" data-first-name="JoeAnne"                >JoeAnne</td>
                                    <td class="copy-field" data-last-name ="team"                   >User</td>
                                    <td class="copy-field" data-email     ="joeanne.team@email.com" >joeanne.user@email.com</td>
                                    <td class="copy-field" data-team      ="team1"                  >team2</td>
                                </tr>
                                <tr class="team-action-any-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joeanne.user"           >joeanne.user</td>
                                    <td class="copy-field" data-first-name="FooAnne"                >FooAnne</td>
                                    <td class="copy-field" data-last-name ="team"                   >User</td>
                                    <td class="copy-field" data-email     ="Fooanne.team@email.com" >fooanne.user@email.com</td>
                                    <td class="copy-field" data-team      ="team1"                  >team2</td>
                                </tr>                                
                            </table>                        
                        </fieldset>
                        <fieldset class="action-subaction-select-form-right" >
                            <legend>add team</legend>
                            <table class="team-action-any-subaction-submit-team-name-fields" >
                                <tr class="form-row" >
                                    <td class="form-field-label">
                                        team name
                                    </td>
                                    <td class="form-field-input">
                                        <input name="name" type="text" />
                                    </td>
                                </tr>
                            </table>
                            <table class="data" >
                                <tr class="form-row form-actions form-submit-row" >
                                    <td class="form-field-input" colspan="100%" >
                                        <span class="form-field-action inline-right-layout" >submit</span>
                                    </td>
                                </tr>                            
                            </table>
                        </fieldset>
                    </div>                  
                    <div id="team-action-modify-form" class="form tabular-form containFloatedChildren" data-action-form-name="modify" >
                        <fieldset class="tabular-form" data-action-form-name="modify" >
                            <legend>search user</legend>
                            <table>
                                <tr class="form-row form-row-fields" >
                                    <td class="form-field-label" >user</td>
                                    <td class="form-field-label" >first name</td>
                                    <td class="form-field-label" >last name</td>
                                    <td class="form-field-label" >email</td>
                                    <td class="form-field-label" >team</td>
                                </tr>
                                <tr class="form-row form-row-fields" >
                                    <!--  TODO for some reason firefox doesn't treat the form-field-input class on an input element the same as span elements so 
                                              we are wrapping the input elements with span elements here :(
                                    -->
                                    <td class="form-field-input" >
                                        <input name="team-action-modify-subaction-search-form-user-input"               type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-modify-subaction-search-form-first-name-input"         type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-modify-subaction-search-form-last-name-input"          type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-modify-subaction-search-form-email-input"              type="text"     />
                                    </td>
                                    <td class="form-field-input" >
                                        <input name="team-action-modify-subaction-search-form-team"                     type="text"     />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset class="action-subaction-select-form-left" >
                            <legend>select user</legend>
                            <table class="data" title="click to modify" >
                                <tr class="team-action-any-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joe.user"           >joe.user</td>
                                    <td class="copy-field" data-first-name="Joe"                >Joe</td>
                                    <td class="copy-field" data-last-name ="team"               >team</td>
                                    <td class="copy-field" data-email     ="joe.team@email.com" >joe.team@email.com</td>
                                    <td class="copy-field" data-team      ="team1"              >team1</td>
                                </tr>
                                <tr class="team-action-any-subaction-select-user" >
                                    <td class="copy-field" data-user      ="joeanne.user"           >joeanne.user</td>
                                    <td class="copy-field" data-first-name="JoeAnne"                >JoeAnne</td>
                                    <td class="copy-field" data-last-name ="team"                   >team</td>
                                    <td class="copy-field" data-email     ="joeanne.team@email.com" >joeanne.team@email.com</td>
                                    <td class="copy-field" data-team      ="team1"                  >team2</td>
                                </tr>
                            </table>                        
                        </fieldset>
                        <fieldset class="action-subaction-select-form-right" >
                            <legend>select and modify team</legend>
                            <table class="team-action-any-subaction-submit-team-name-fields">
                                <tr class="form-row" >
                                    <td class="form-field-label" >
                                        team name
                                    </td>
                                    <td class="form-field-input form-field-action">
                                        <input class="inline-right-layout" name="name" type="text" />
                                        <span class="form-field-action " >select</span>
                                    </td>
                                </tr>
                                <tr class="form-row" >
                                    <td class="form-field-label">
                                        change team name
                                    </td>
                                    <td class="form-field-input">
                                        <input class="inline-right-layout"  name="changed-team-name" type="text" />
                                    </td>
                                </tr>
                            </table>                            
                            <table class="data" >
                                <tr class="form-row form-actions form-submit-row" >
                                    <td class="form-field-input" colspan="100%" >
                                        <span class="form-field-action inline-right-layout" >submit</span>
                                    </td>
                                </tr>                            
                            </table>
                        </fieldset>
                    </div>
                    <div id="team-action-delete-form" class="form tabular-form containFloatedChildren" data-action-form-name="delete" >
                        <fieldset class="tabular-form" data-action-form-name="delete" >
                            <legend>search</legend>
                            <table>
                                <tr class="form-row form-row-fields" >
                                    <td class="form-field-label" >team</td>
                                </tr>
                                <tr class="form-row form-row-fields" >
                                    <!--  TODO for some reason firefox doesn't treat the form-field-input class on an input element the same as span elements so 
                                              we are wrapping the input elements with span elements here :(
                                    -->
                                    <td class="form-field-input" >
                                        <input name="team-action-delete-subaction-search-form-team"                     type="text"     />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset class="action-subaction-select-form-left" >
                            <legend>select</legend>
                            <table class="data" title="click to delete" >
                                <tr class="team-action-delete-subaction-select-team" >
                                    <td class="copy-field" data-team      ="team1" >team1</td>
                                </tr>
                                <tr class="team-action-delete-subaction-select-team" >
                                    <td class="copy-field" data-team      ="team2" >team2</td>
                                </tr>
                                <tr class="team-action-delete-subaction-select-team" >
                                    <td class="copy-field" data-team      ="team3" >team3</td>
                                </tr>                                
                            </table>
                        </fieldset>
                        <fieldset class="action-subaction-select-form-right" >
                            <legend>delete</legend>
                            <table class="data" >
                                <tr class="form-row form-actions form-submit-row" >
                                    <td class="form-field-input" colspan="100%" >
                                        <span class="form-field-action inline-right-layout" >submit</span>
                                    </td>
                                </tr>                            
                            </table>
                        </fieldset>
                    </div>
                    <div id="team-action-bulk-delete-form" class="form tabular-form containFloatedChildren" data-action-form-name="bulk-delete" >
                        <fieldset class="tabular-form" data-action-form-name="bulk-delete" >
                            <legend>bulk-delete</legend>
                            <textarea class="bulk-delete-input" rows="40" cols="100" >Provide a comma delimited list of teams here to perform a bulk delete.</textarea>
                            <span class="form-field-action inline-right-layout tabular-form form-submit-row action-bulk-delete-subaction-action-form-submit" >submit</span>
                        </fieldset>
                    </div>
                </div>
            </div>
            <div id="admin-component-notification" data-admin-component="notification" class="component containFloatedChildren" >
                TODO: Notification
            </div>
            <div id="admin-component-system" data-admin-component="system" class="component containFloatedChildren" >
                TODO: System
            </div>
        </div>
<div id="hiddenReusableFormElements" style="display: none; " >
    <table>
        <tr id="TEMPLATE-user-action-modify-subaction-submit-form-table-row" class="subaction-submit-form-table-row form-row" data-original-email="" >
            <td data-original-user="" >
                <input name="user" type="text" class="form-input" />
            </td>
            <td data-original-first-name="" >
                <input name="first-name" type="text" class="form-input" />
            </td>
            <td data-original-last-name="" >
                <input name="last-name" type="text" class="form-input" />
            </td>
            <td data-original-email="" >
                <input name="email" type="text" class="form-input" />
            </td>
<!-- TODO delete? doesn't fit well on screen
            <td data-original-team="" class="user-action-modify-subaction-submit-form-table-team-input-cell" >
                <input class="user-action-modify-subaction-submit-form-table-team-input" name="team" type="text" class="form-input" />
                <div class="user-action-modify-subaction-submit-form-table-team-input-options" >
                    <div class="user-action-modify-subaction-submit-form-table-team-input-option" data-team="team1">team1</div>
                    <div class="user-action-modify-subaction-submit-form-table-team-input-option" data-team="team2">team2</div>
                    <div class="user-action-modify-subaction-submit-form-table-team-input-option" data-team="team3">team3</div>
                    <div class="user-action-modify-subaction-submit-form-table-team-input-option" data-team="team4">team4</div>
                </div>
            </td>
-->            
            <td>
                <div class="remove-me-button" >remove</div>
            </td>
        </tr>
    </table>
    <table>
        <tr id="TEMPLATE-user-action-delete-subaction-submit-form-table-row" class="subaction-submit-form-table-row form-row" data-email="" >
            <td data-first-name="" >
                <span type="text" class="form-input" ></span>
            </td>
            <td data-last-name="" >
                <span type="text" class="form-input" ></span>
            </td>
            <td data-email="" >
                <span name="email" type="text" class="form-input" ></span>
            </td>
            <td data-team="" >
                <span name="team" type="text" class="form-input" ></span>
            </td>            
            <td data-team="" class="user-action-delete-subaction-submit-form-table-team-input-cell" >
                <span class="user-action-delete-subaction-submit-form-table-team-input" type="text" ></span>
            </td>
            <td>
                <div class="remove-me-button" >remove</div>
            </td>
        </tr>
    </table>    
    <table>
        <tr id="TEMPLATE-team-action-any-subaction-submit-form-table-row" class="subaction-submit-form-table-row" >
            <td data-first-name="" >
                <span type="text" class="form-input" ></span>
            </td>
            <td data-last-name="" >
                <span type="text" class="form-input" ></span>
            </td>
            <td data-email="" >
                <span name="email" type="text" class="form-input" ></span>
            </td>
            <td data-team="" >
                <span name="team" type="text" class="form-input" ></span>
            </td>            
            <td data-team="" class="team-action-delete-subaction-submit-form-table-team-input-cell" >
                <span class="team-action-delete-subaction-submit-form-table-team-input" type="text" ></span>
            </td>
            <td>
                <div class="remove-me-button" >remove</div>
            </td>
        </tr>
    </table>
    <table>
        <tr id="TEMPLATE-team-action-delete-subaction-submit-form-table-row" class="subaction-submit-form-table-row" >
            <td data-team="" >
                <span name="team" type="text" class="form-input" ></span>
            </td>            
            <td data-team="" class="team-action-delete-subaction-submit-form-table-team-input-cell" >
                <span class="team-action-delete-subaction-submit-form-table-team-input" type="text" ></span>
            </td>
            <td>
                <div class="remove-me-button" >remove</div>
            </td>
        </tr>
    </table>    
</div>
    </body>
</html>
