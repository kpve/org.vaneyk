<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>

        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/view/scrum/css/pre-planning.css" />
        
        <jsp:include page="/include/standard-javascript-include.jsp" />

        <script type="text/javascript">
            var bodyOnClickOneTime = false;
            
            $( document ).ready
            (
                function()
                {
                    // TODO
                }
            );
        </script>
    </head>
    <body>
        <div class="vertical-spacer-center" ></div>
        <div id="pre-planning-content" class="form">
            <fieldset>
                <legend>pre-planning</legend>
                <span id="sprint-planning-form-title">Sprint 77</span>
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
			    	                    <input type="text" name="team-velocity-when-pre-planning-occured" value="10.6" readonly="readonly" class="form-field-input" ></input>
			    	                </td>
				                </tr>
				                <tr>
				                    <td>
				                        <span class="form-field-label" >team commitment</span>
				                    </td>
				                    <td>
			    	                    <input type="text" name="team-velocity-when-pre-planning-occured" value="10" class="form-field-input" ></input>
			    	                </td>
				                </tr>
				            </table>
                        </td>
                        <td class="sprint-planning-form-goals-content" >
                            <textarea id="sprint-goals-field" name="sprint-goals" class="form-field-input" >
                            </textarea>
                        </td>
                    </tr>
                </table>
	            <table>	                
	                <tr>
	                    <td>
	                        <h3>Backlog</h3>
	                        <div>
	                            <span name="backlog-item-priority">1</span>
	                            <span name="backlog-item-title">Title 1...</span>
	                            <span name="theme" >A Theme</span>
	                            <span name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                            </span>
	                        </div>
	                        <div>
	                            <span name="backlog-item-priority">2</span>
	                            <span name="backlog-item-title">Title 2...</span>
	                            <span name="theme" >A Theme</span>
	                            <span name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                            </span>
	                        </div>
	                    </td>
	                    <td>
	                        <h3>Commitment</h3>
	                    </td>
	                </tr>
	            </table>
	        </fieldset>
        </div>
    </body>
</html>
