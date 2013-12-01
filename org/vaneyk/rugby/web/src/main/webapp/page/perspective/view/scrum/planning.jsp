<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>

        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/view/scrum/css/planning.css" />
        
        <jsp:include page="/include/standard-javascript-include.jsp" />

        <script type="text/javascript">
            var bodyOnClickOneTime = false;
            
            $( document ).ready
            (
                function()
                {
                    $( '#sprint-planning-commit' ).on
                    (
                        'click',
                        function()
                        {
                        	var areAllCommittedItemsEstimated = true;
                        	$( '.sprint-planning-item-is-estimated' ).each
                        	(
                                function()
                                {
                                    if( $( this ).text() != 'yes' )
                                    {
                                	    areAllCommittedItemsEstimated = false;
                               	    }
                                }
                            )
                            
                            if( areAllCommittedItemsEstimated == true )
                            {
                            	alert( 'TODO not implemented yet' );
                            }
                            else
                            {
                            	alert( 'Please estimate all committed items.' );
                            }
                        }
                    )
                }
            );
        </script>
    </head>
    <body>
        <div class="vertical-spacer-center" ></div>
        <div id="planning-content" class="form">
            <fieldset>
                <legend>planning</legend>
                <span class="title" >Sprint 77</span>
                <input type="hidden" name="sprint-number" value="77" ></input>
                <table>
	                <tr class="form-row" >
	                    <td></td>
	                    <td>
		                    <div id="sprint-planning-form-goals-field-label" class="form-field-label" >goals</div>
	                    </td>
	                </tr>
                    <tr>
                        <td class="sprint-planning-form-non-goals-content" >
				            <table>
				                <tr class="form-row">
				                    <td>
				                        <span class="form-field-label" >name</span>
				                    </td>
				                    <td>
				                        <input name="sprint-name" type="text" class="form-field-input" />
				                    </td>
				                </tr>
				                <tr>
				                    <td>
				                        <span class="form-field-label" class="form-field-input" >team velocity</span>
				                    </td>
				                    <td>
			    	                    <input type="text" name="team-velocity-when-planning-occured" value="10.6" readonly="readonly" class="form-field-input" ></input>
			    	                </td>
				                </tr>
				                <tr>
				                    <td>
				                        <span class="form-field-label" >team commitment</span>
				                    </td>
				                    <td>
			    	                    <input type="text" name="team-velocity-when-planning-occured" value="10" class="form-field-input" ></input>
			    	                </td>
				                </tr>
				            </table>
                        </td>
                        <td class="sprint-planning-form-goals-content" >
                            <textarea id="sprint-goals-field" name="sprint-goals" class="form-field-input" >
                            </textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="0" >
                            <span id="sprint-planning-commit" >commit</span>
                        </td>
                    </td>
                </table>
                
                <br	/>
                <br />
                	
                <span class="title" >Backlog</span>
	            <table id="sprint-planning-backlog-items" >
	                <tr>
	                    <th>priority</th>
	                    <th>title</th>
	                    <th>theme</th>
	                    <th>description</th>
	                    <th>effort</th>
	                    <th>estimated</th>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">1</td>
	                    <td name="backlog-item-title">Title 1...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>1</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">2</td>
	                    <td name="backlog-item-title">Title 2...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>2</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">3</td>
	                    <td name="backlog-item-title">Title 3...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>3</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	                <tr class="sprint-planning-commitment-line" >
	                    <td name="backlog-item-priority">4</td>
	                    <td name="backlog-item-title">Title 4...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>4</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">5</td>
	                    <td name="backlog-item-title">Title 5...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>5</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">6</td>
	                    <td name="backlog-item-title">Title 6...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>6</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">7</td>
	                    <td name="backlog-item-title">Title 7...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>7</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">8</td>
	                    <td name="backlog-item-title">Title 8...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>8</td>
	                    <td class="sprint-planning-item-is-estimated" >no</td>
	                </tr>
	            </table>
	        </fieldset>
        </div>
    </body>
</html>
