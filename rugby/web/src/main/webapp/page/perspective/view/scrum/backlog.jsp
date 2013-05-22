<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>

        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/view/scrum/css/backlog.css" />
        
        <jsp:include page="/include/standard-javascript-include.jsp" />

        <script type="text/javascript">
            var bodyOnClickOneTime = false;
            
            $( document ).ready
            (
                function()
                {
                	 $( '#add-new-backlog-item-form-table-row' ).on
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
                }
            );
        </script>
    </head>
    <body>
        <div class="vertical-spacer-center" ></div>
        <div id="backlog-content" class="form tabular-form" >
            <fieldset>
	            <legend>backlog</legend>
	            <table>
	                <tr class="form-row" >
	                    <th class="backlog-content-priority"    >priority</th>
	                    <th class="backlog-content-title"       >title</th>
	                    <th class="backlog-content-description" >description</th>
	                    <th class="backlog-content-estimate"    >estimate</th>
	                    <th class="backlog-content-theme"       >theme</th>
	                    <th class="backlog-content-edit"        ></th>
	                </tr>
	                <tr class="form-row-fields" >
	                    <td class="form-field-input" >
	                        <input type="text" value="" class="backlog-content-field" ></input>
	                    </td>
	                    <td class="form-field-input" >
	                        <input type="text" value="" class="backlog-content-field" ></input>
	                    </td>
	                    <td class="form-field-input" >
	                        <input type="text" value="" class="backlog-content-field" ></input>
	                    </td>
	                    <td colspan="0" >
	                        <input type="text" value="" class="backlog-content-field" ><!-- TODO styliezed type ahead/drop down here --></input>
	                    </td>
	                    <td class="form-field-input" >
	                        <input type="text" value="" class="backlog-content-field" ><!-- TODO styliezed type ahead/drop down here --></input>
	                    </td>
	                    <td id="add-new-backlog-item-form-table-row" class="form-field-input"  class="inline-right-layout" >add</td>
	                    <td>
	                        <input type="hidden" name="backlog-content-description" ></input>
	                    </td>
	                </tr>
	                <tr class="last-row-in-table" >
	                    <!-- always leave the last row empty -->
	                </tr>
	            </table>            
            </fieldset>
        </div>
 <div id="hiddenReusableFormElements" style="display: none; " >
    <table>
   	    <tr class="TEMPLATE-new-backlog-item-form-table-row" data-is-new-item="true" >
	        <td class="form-field-input" >1</td>
	        <td class="form-field-input" >
	            <input type="text" value="Title 1" class="backlog-content-field" ></input>
	        </td>
	        <td class="form-field-input" >
	            <input type="text" value="Description 1" class="backlog-content-field" ></input>
	        </td>
	        <td class="form-field-input"  colspan="0" >
	            <input type="text" value="small" class="backlog-content-field" ><!-- TODO styliezed type ahead/drop down here --></input>
	        </td>
	        <td class="form-field-input" >
	            <input type="text" value="theme 1" class="backlog-content-field" ><!-- TODO styliezed type ahead/drop down here --></input>
	        </td>
	        <td class="form-field-input"  class="inline-right-layout" >delete</td>
	    </tr>
	</table>
</div>
    </body>
</html>
