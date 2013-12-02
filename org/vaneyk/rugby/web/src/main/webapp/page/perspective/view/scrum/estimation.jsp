<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Rugby</title>
        
        <link rel="stylesheet" type="text/css" href="/rugby/page/perspective/view/scrum/css/estimation.css" />
        
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
        <div id="estimation-content" class="form" >
            <fieldset>
                <legend>estimation</legend>
                <span class="title" >Sprint 77</span>
                <input type="hidden" name="sprint-number" value="77" ></input>
	            <table id="sprint-estimation-backlog-items" >
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
	                    <td class="sprint-estimation-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">2</td>
	                    <td name="backlog-item-title">Title 2...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>2</td>
	                    <td class="sprint-estimation-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">3</td>
	                    <td name="backlog-item-title">Title 3...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>3</td>
	                    <td class="sprint-estimation-item-is-estimated" >no</td>
	                </tr>
	                <tr>
	                    <td name="backlog-item-priority">4</td>
	                    <td name="backlog-item-title">Title 4...</td>
	                    <td name="theme" >A Theme</td>
	                    <td name="backlog-item-description" onclick="" > <!-- TODO onclick show description (expand, popup?) -->
	                    </td>
	                    <td>4</td>
	                    <td class="sprint-estimation-item-is-estimated" >no</td>
	                </tr>
	            </table>
	        </fieldset>
        </div>
    </body>
</html>
