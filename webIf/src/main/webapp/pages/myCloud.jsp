<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title><s:text name="MyCloud.message"/></title>
    
    <style type="text/css">
    	p {
    		display: inline;
    	}
    </style>
    
    <link href="${pageContext.request.contextPath}/assets/css/per_page/myCloud.css" type="text/css" media="screen" rel="stylesheet" />


<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/packery.pkgd.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/draggabilly.js" ></script>
<!-- <script type="text/javascript" src="http://packery.metafizzy.co/packery.pkgd.min.js" ></script> -->
<!-- <script type="text/javascript" src="http://draggabilly.desandro.com/draggabilly.pkgd.min.js" ></script> -->

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/flot/jquery.flot.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/flot/curvedLines.js" ></script>    
<script type="text/javascript">
	var REST_HOST = '<s:property value="getRestHost()" />';
	var REST_PORT = '<s:property value="getRestPort()" />';
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/myCloud.js"></script>

    
<script type="text/javascript">

var REST_STATUS = 'http://' + REST_HOST + ':' + REST_PORT +'/status';

$(document).ready(
		function(){
			Retrieve();
			
			//$.plot($("#placeholder"), [ [[0, 0], [1, 1]] ], { yaxis: { max: 1 } });
		}    		
);
    
    var Polling = function(){
    	setTimeout(Retrieve, 5000);
    }
    
    var Retrieve = function(){
    	
    	$.getJSON( REST_STATUS, function(data){Update(data)})
    		.complete(function(){
    			Polling();
    		})
    		.fail(function() { 
    			setTimeout(function(){
            		document.location.reload(true);	
            	}, 5000);
    		});
    	/*
    	$.ajax({
            type: 'GET',
            crossDomain:true,
            dataType: 'json',
            url: 'http://46.252.152.83:9998/status',
            success: function (data) {
            	Update(data);
            },
            error: function (request, status, error) {
//            	setTimeout(function(){
//            		document.location.reload(true);	
//            	}, 5000);
		console.log(status);
		console.log(error);            	
            },
            complete: Polling
        });  
    	*/
    }
    
/**
{
   "status":"WORKING",
   "scale":{
      "small":0,
      "medium":0,
      "large":0,
      "type":"AUTO",
      "method":"ANALYTICAL"
   },
   "replicationProtocol":{
      "protocol":"TWOPC",
      "type":"AUTO",
      "method":"ANALYTICAL"
   },
   "replicationDegree":{
      "degree":2,
      "type":"AUTO",
      "method":"ANALYTICAL"
   },
   "dataPlacement":{
      "type":"AUTO",
      "method":"ANALYTICAL"
   }
}
*/
    
    var Update = function(json) {
    	console.log(json); 
		
		$("span#status").text(json.state);
		
		
		/* SCALE */
		$("p#scale_tuning").text( (json.scale.forecaster == "NONE") ? "MANUAL" : json.scale.forecaster );			
		
		$("p#scale_conf").text( $.trim(json.scale.nodes) + " " + $.trim(json.scale.configuration));
		
		$("p#rep_degree_tuning").text( (json.replication_degree.forecaster == "NONE") ? "MANUAL" : json.replication_degree.forecaster );	
		$("p#rep_degree_conf").text( $.trim(json.replication_degree.degree) );
		
		$("p#rep_prot_tuning").text( (json.replication_protocol.forecaster == "NONE") ? "MANUAL" : json.replication_protocol.forecaster );		
		$("p#rep_prot_conf").text( $.trim(json.replication_protocol.protocol) );
		
		$("p#placement_tuning").text( $.trim(json.data_placement) );
		
	};

    </script>
    
</head>

<body>
	<!-- Promo -->
	<div id="col-top"></div>
	<div class="box" id="col">
    
    <div id="ribbon"></div> <!-- /ribbon (design/ribbon.gif) -->
        
    <!-- Screenshot in browser (replace tmp/browser.gif) -->
    <div id="col-browser"></div> 
    
  	<div id="col-text">
        
        <h2><s:property value="message"/></h2>
        <h3>State: <span style="display: inline;" id="status"></span></h3>
        
        <!-- <h2 id="slogan"><span><s:property value="message"/></span></h2> -->
	   				
	   				
	   				
		<table id="box-table-a" summary="Employee Pay Sheet">
		    <thead>
		    	<tr>
		        	<th scope="col">Autotuned Feature</th>
		            <th scope="col">Status</th>
		            <th scope="col">Current</th>
		            <th scope="col">Optimal</th>
		        </tr>
		    </thead>
		    <tbody>
		    	<tr>
		        	<td>Scale</td>
		            <td><p id="scale_tuning"></p></td>
		            <td><p id="scale_conf"></p></td>
		            <td>OPT</td>
		        </tr>
		        <tr>
		        	<td>Replication Degree</td>
		            <td><p id="rep_degree_tuning"></p></td>
		            <td><p id="rep_degree_conf"></p></td>
		            <td>OPT</td>
		        </tr>
		        <tr>
		        	<td>Protocol Switching</td>
		            <td><p id="rep_prot_tuning"></p></td>
		            <td><p id="rep_prot_conf"></p></td>
		            <td>OPT</td>
		        </tr>
		        <tr>
		        	<td>Data Placement</td>
		            <td><p id="placement_tuning"></p></td>
		            <td>--</td>
		            <td>--</td>
		        </tr>
		    </tbody>
		</table>
		
		<h3>Workload and Performance Monitor:</h3>
				
		<iframe src="http://127.0.0.1/stats2/index.php?rootFolder=csv" style="width: 100%; height: 900px"></iframe>
		
		
<!-- 		<form id="plot">	 -->
<!-- 		<fieldset>		 -->
<!-- 			<legend>Manage plots</legend> -->
<!-- 				<div class="table"> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="column">Instance</div> -->
<!-- 						<div class="column">Category</div> -->
<!-- 						<div class="column">Attribute</div> -->
<!-- 						<div class="column">Title</div> -->
<!-- 						<div class="column">Action</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="column"> -->
<%-- 							<select> --%>
<!-- 								<option value="SMALL">Cluster</option> -->
<%-- 							</select> --%>
<!-- 						</div> -->
<!-- 						<div class="column"> -->
<%-- 							<select> --%>
<!-- 								<option value="SMALL">CAT</option> -->
<%-- 							</select> --%>
<!-- 						</div> -->
<!-- 						<div class="column"> -->
<%-- 							<select> --%>
<!-- 								<option value="SMALL">ATTR</option> -->
<%-- 							</select> --%>
<!-- 						</div> -->
<!-- 						<div class="column"> -->
<!-- 							<input type="text" size="30" /> -->
<!-- 						</div> -->
<!-- 						<div class="column"> -->
<!-- 							<input type="button" value="Add" /> -->
<!-- 						</div> -->
<!-- 					</div>					 -->
<!-- 				</div>		 -->
<!-- 			</fieldset>				 -->
<!-- 		</form> -->
		
<!-- 		<div>Double click to delete</div> -->
					
<!-- 		<div id="container"> -->
<!-- 			<div class="item"> -->
<!-- 				<div class="plotTitle">Throughput</div> -->
<!-- 				<div id="placeholderThroughput" class="plot"></div> -->
<!-- 			</div> -->
<!-- 			<div class="item"> -->
<!-- 				<div class="plotTitle">Nodes</div> -->
<!-- 				<div id="placeholderNodes" class="plot"></div> -->
<!-- 			</div> -->
<!-- 			<div class="item"> -->
<!-- 				<div class="plotTitle">Write %</div> -->
<!-- 				<div id="placeholderWritePercentage" class="plot"></div> -->
<!-- 			</div> -->
<!-- 			<div class="item"> -->
<!-- 				<div class="plotTitle">Abort Rate %</div> -->
<!-- 				<div id="placeholderAbortRate" class="plot"></div> -->
<!-- 			</div> -->
<!-- 		</div>	   				 -->
	   	
	   		   		   			
	   				
	   	
		</div>
		<!-- /col-text -->

	</div>
	<!-- /col -->
	<div id="col-bottom"></div>

	<hr class="noscreen">
	<hr class="noscreen">       
</body>
</html>



