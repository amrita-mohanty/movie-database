<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Upcoming Movies</title>

	<style type="text/css">
		th{
			background-color: #A9D0F5;	
		}
		.title{
			font: bold;
			font-size: 15;
			font-family: cursive;
		}
		
		/* img{
			height:100%;
			width: 100%
		} */
	</style>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" > </script>
	<link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css"/>
	<link rel="stylesheet" href="css/bootstrap-responsive.min.css" type="text/css"/>
	<link rel="stylesheet" href="css/bootstrap.css" type="text/css"/>
	<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
	
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script src="//datatables.net/download/build/nightly/jquery.dataTables.js"></script>
	
	<script type="text/javascript">
	
		var popularloaded = 0;
		var movie_id; 
		function populateTables(id){
			movie_id=id;
			 $('#loading').show();
			getInTheatreMovieList();
		}
	
		function getInTheatreMovieList(){
			//alert("Inside searchCallback() method");
			
			var apikey = "kxv87aj2arknftqf6ywpj2v5";
			var baseUrl = "http://api.rottentomatoes.com/api/public/v1.0/movies/"+movie_id+".json?";

			// construct the uri with our apikey
			var moviesSearchUrl = baseUrl + 'apikey=' + apikey;
			$(document).ready(function() {
			  // send off the query
			  $.ajax({
			    url: moviesSearchUrl,
			    dataType: "jsonp",
			    success: inTheatreCallback
			  });
			});
		}
		
		// receives the results
        function inTheatreCallback(data) {
        	$('upcomingMovieListTable').append('Found ' + data.title + " movie");
        	$('#movieTitle').append("&nbsp;&nbsp;&nbsp;&nbsp;"+data.title);
            	$('#movieDetails').append(
            			"<tr>"+
            				"<td width='20%' align='center'><img src='" + data.posters.profile + "' /></td>" +
            				"<td>"+
            					"<table width='50%'>" +
            						"<tr>"+
            							"<td width='40%'><b>Critic Score :</b> " + data.ratings.critics_score + "</td>"+
            							"<td> <b>Audience Score :</b> " + data.ratings.audience_score + "</td>"+
            						"</tr>"+
            						"<tr>"+
            							"<td  width='40%'><b>Runtime :</b> " + data.runtime + "</td>"+
            							"<td><b>Rating :</b> " + data.ratings.critics_rating + "</td>"+
            						"<tr>"+
            							"<td rowspan='2' colspan='2'><br><b>Synopsis :</b> <br>" + data.synopsis + "</td>"+
            						"</tr>" +
         		   				"</table>"+
         		   			"</td>"+
         		   		"</tr>");

            popularloaded = 1;
            if (popularloaded > 0) {
	            $('#loading').hide();
            }
        };
	</script>

</head>
<body onload="populateTables(<%=request.getParameter("movie_id")%>)">
	<h1 id="movieTitle"></h1>
	<span id="loading" style="display:none"><h2><font color="green">Loading...</font></h2></span>
	<!-- <div class="progress">
	  <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
	    <span class="sr-only">60% Complete</span>
	  </div>
	</div> -->
	<table width="100%" id="movieDetails">
	</table>
</body>
</html>
