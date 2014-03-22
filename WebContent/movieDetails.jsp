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
	</style>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" > </script>
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
        	$('#movieTitle').append(data.title);
        	$('#movieImg').append("<img src='" + data.posters.thumbnail + "' />");
            $('#movieDetails').append("<tr><td>Critic Score : " + data.ratings.critics_score + "</td><td> Audience Score : " + 
         		   data.ratings.audience_score + "</td></tr><tr><td>Runtime: " + data.runtime + "</td><td>Rating : " +
         		   data.ratings.critics_rating + "</td></tr><tr><td>Synopsis : <br>" + data.synopsis + "</td></tr>");

            popularloaded = 1;
            if (popularloaded > 0) {
	            $('#loading').hide();
            }
        };
	</script>
	
	

</head>
<body onload="populateTables(<%=request.getParameter("movie_id")%>)">
	<h1>Movie Details</h1>
	<span id="loading" style="display:none"><h2><font color="green">Loading...</font></h2></span>
	<h3 id="movieTitle"></h3>
	<table width="100%" id="movieDetails">
		<tr>
			<td id="movieImg" width="35%">
				
			</td>
			<td width=60%>
				<table id="movieDetails">
				</table>
			</td>
		</tr>
	</table>
</body>
</html>