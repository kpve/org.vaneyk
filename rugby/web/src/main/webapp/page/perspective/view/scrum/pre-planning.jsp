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
        <div id="pre-planning-content" class="form classic-form">
            <fieldset>
                <legend>pre-planning</legend>
                <span id="title">Sprint 77</span>
                <input type="hidden" name="sprint-number" value="77" ></input>
                <div id="sprint-planning-form" class="form classic-form" >
                    <div>
                        <span class="form-field-label" >name</span>
                        <input name="sprint-name" type="text" class="form-field-input" />
                    </div>
                    <div>
                        <span class="form-field-label" ><!-- silent --></span>
                        <input name="team-velocity-when-pre-planning-occured" class="form-field-input" value="10.6" readonly="readonly" ></input>
                    </div>
                    <div class="form-actions" >
                        <span class="form-field-label"><!--  no label --></span>
                        <span class="form-field-input">
                            <span id="login-action-login" class="form-field-action inline-right-layout" >login</span><span id="login-action-guest" class="form-field-action">submit</span>
                        </span>
                    </div>
                </div>
                <table >
                    <tr>
                        <td>
				            <table>
				                <tr class="form-row">
				                    <td>
				                        <span>Name</span>
				                    </td>
				                    <td>
				                        <input type="text" name="sprint-name" ></input>
				                    </td>
				                </tr>
				                <tr>
				                    <td>Team Velocity</td>
				                    <td>
			    	                    <input type="text" name="team-velocity-when-pre-planning-occured" value="10.6" readonly="readonly" ></input>
			    	                </td>
				                </tr>
				                <tr>
				                    <td>Team Commitment</td>
				                    <td>
			    	                    <input type="text" name="team-velocity-when-pre-planning-occured" value="10" ></input>
			    	                </td>
				                </tr>
				            </table>
                        </td>
                        <td>
                            <div>Goals</div>
                            <textarea name="sprint-goals">
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
