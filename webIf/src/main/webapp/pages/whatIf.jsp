<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title><s:text name="MyCloud.message" /></title>
<link
	href="${pageContext.request.contextPath}/assets/css/per_page/whatif.css"
	type="text/css" media="screen" rel="stylesheet" />
	
<script type="text/javascript">
	var REST_HOST = '<s:property value="getRestHost()" />';
	var REST_PORT = '<s:property value="getRestPort()" />';
</script>
	
	<!-- PACKERY + DRAGGABILLY -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/packery.pkgd.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/draggabilly.js" ></script>
	
	<!-- FLOT + SMOOTH -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/flot/jquery.flot.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/flot/curvedLines.js" ></script>    
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/whatif.js"></script>
	<script src="http://malsup.github.com/jquery.form.js"></script>
</head>

<body>
	<!-- Promo -->
	<div id="col-top"></div>
	<div class="box" id="col">

		<div id="ribbon"></div>
		<!-- /ribbon (design/ribbon.gif) -->

		<!-- Screenshot in browser (replace tmp/browser.gif) -->
		<div id="col-browser"></div>

		<div id="col-text">

			<h2>What-If Analysis</h2>

			<!-- <h2 id="slogan"><span><s:property value="message"/></span></h2> -->

			<!--  <a href="${pageContext.request.contextPath}/registration.jsp">Register</a>  -->


			<form id="whatif">
			
				<div class="table">
					<div class="row">
						<div class="column first">
							<fieldset>
								<legend>Data Access Pattern:</legend>
									<div class="param">
										<label for="ACF">Application Contention Factor:</label>
										<input type="text" id="ACF" name="acf" size="5" />
									</div>
									<div class="param">
										<label for="PercentageSuccessWriteTransactions">Write Transactions Percentage:</label>
										<input type="text" name="PercentageSuccessWriteTransactions" id="PercentageSuccessWriteTransactions" size="5" />
									</div>
									<div class="param">
										<label for="AvgNumPutsBySuccessfulLocalTx"># PUT per write transaction:</label>
										<input type="text" name="AvgNumPutsBySuccessfulLocalTx" id="AvgNumPutsBySuccessfulLocalTx" size="5" />
									</div>
									<div class="param">
										<label for="AvgGetsPerWrTransaction"># GET per write transaction:</label>
										<input type="text" name="AvgGetsPerWrTransaction" id="AvgGetsPerWrTransaction" size="5" />
									</div>
									<div class="param">
										<label for="AvgGetsPerROTransaction"># GET per read only transaction:</label>
										<input type="text" name="AvgGetsPerROTransaction" id="AvgGetsPerROTransaction" size="5" />
									</div>
									<div class="param">
									</div>							
							</fieldset>											
						</div>
					</div>
					<div class="row">
						<div class="column">
							<fieldset>
								<legend>CPU Costs:</legend>
									<div class="param">
										<label for="LocalUpdateTxLocalServiceTime">Write transaction demand:</label>
										<input type="text" name="LocalUpdateTxLocalServiceTime" id="LocalUpdateTxLocalServiceTime" size="5" />
									</div>
									<div class="param">
										<label for="LocalReadOnlyTxLocalServiceTime">Read Only transaction demand:</label>
										<input type="text" name="LocalReadOnlyTxLocalServiceTime" id="LocalReadOnlyTxLocalServiceTime" size="5" />																	
									</div>
									<div class="param">
									</div>
					
							</fieldset>											
						</div>
					</div>
					<div class="row">
						<div class="column">
							<fieldset>
								<legend>NET Costs:</legend>
									<div class="param">
										<div class="line"></div>
										<label for="AvgPrepareCommandSize">Size of prepare message:</label>										
										<input type="text" name="AvgPrepareCommandSize" id="AvgPrepareCommandSize" size="5" />
									</div>
									<div class="param">
										<label for="AvgPrepareAsync">Prepare latency:</label>
										<input type="text" name="AvgPrepareAsync" id="AvgPrepareAsync" size="5" />
									</div>
									<div class="param">
										<label for="AvgCommitAsync">Commit latency:</label>
										<input type="text" name="AvgCommitAsync" id="AvgCommitAsync" size="5" />
									</div>
									<div class="param">
										<label for="AvgRemoteGetRtt">Remote get latency:</label>
										<input type="text" name="AvgRemoteGetRtt" id="AvgRemoteGetRtt" size="5" />
									</div>
									<div class="param">
									</div>
									<div class="param">
									</div>
								</fieldset>											
						</div>
					</div>
					<div class="row">
						<div class="column">
							<fieldset>
								<legend>Forecasting:</legend>
									<div class="param">
										<div class="line"></div>
										<input type="checkbox" name="oracoles" value="ANALYTICAL">Analytical<br>
									</div>
									<div class="param">
										<input type="checkbox" name="oracoles" value="SIMULATOR">Simulator<br>										
									</div>
									<div class="param">
										<input type="checkbox" name="oracoles" value="MACHINE_LEARNING">Machine Learning<br>										
									</div>
									<div class="param">
										<input type="text" id="repDegree" name="repDegree" value="2">
										
									</div>
									<div class="param">
										<select name="repProtocol">
											<option value="TWOPC">2PC</option>
											<option value="TO">TO</option>
											<option value="PB">PB</option>
										</select>
									</div>
									<div class="param">
									</div>
								</fieldset>											
						</div>
					</div>					
					
					<div class="action">
									
				    
				    
					
					
					
					
					
								<input id="updateValues" type="submit" class="submit" value="Update values from system" size="40" />
								<input id="forecastAction" type="button" class="submit" value="Forecast" size="40" /> 																
					</div>
					
				</div>				
			</form>
			
			<div id="container">
				<div class="item">
					<div class="plotTitle">Throughput</div>
					<div id="placeholderThroughput" class="plot"></div>
				</div>
				<div class="item">
					<div class="plotTitle">Read Response Time</div>
					<div id="placeholderReadResponseTime" class="plot"></div>
				</div>
				<div class="item">
					<div class="plotTitle">Write Response Time</div>
					<div id="placeholderWriteResponseTime" class="plot"></div>
				</div>
				<div class="item">
					<div class="plotTitle">AbortRate %</div>
					<div id="placeholderAbortRate" class="plot"></div>
				</div>
			</div>	   				
			


		</div>
		<!-- /col-text -->

	</div>
	<!-- /col -->
	<div id="col-bottom"></div>

	<hr class="noscreen">
	<hr class="noscreen">
	<div class="modal"></div>
</body>
</html>



