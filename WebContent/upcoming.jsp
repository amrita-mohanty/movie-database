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
		var upcomingloaded = 0;
	
		function populateTables(){
			//alert("populateTables()");
			 $('#loading').show();
			getInTheatreMovieList();
			getUpcomingMovieList();
		}
	
		function getInTheatreMovieList(){
			//alert("Inside searchCallback() method");
			
			var apikey = "kxv87aj2arknftqf6ywpj2v5";
			var baseUrl = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?";

			// construct the uri with our apikey
			var moviesSearchUrl = baseUrl + 'apikey=' + apikey + "&page_limit=10";
			
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
        	//alert("Inside inTheatreCallback() method");
            $('inTheatreMovieListTable').append('Found ' + data.total + " movies");
            //alert("'Found ' + data.total");
            var movies = data.movies;
            $.each(movies, function(index, movie) {
                $('#inTheatreMovieListTable').append(
                '<tr><td class="ajaxfilmlisttitle"><h3><a href="movieDetails.jsp?movie_id=' + movie.id +
                '">' + movie.title +
                '</td><td class="ajaxfilmlistinfo">' + movie.mpaa_rating +
                '</td><td>' + movie.ratings.critics_score + '</td></tr>');
            });
            
            popularloaded = 1;
            if (popularloaded > 0 && upcomingloaded > 0) {
	            $('#loading').hide();
            }
        };
        
        function getUpcomingMovieList(){
			//alert("getUpcomingMovieList()");
			
			var apikey = "kxv87aj2arknftqf6ywpj2v5";
			var baseUrl = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?";

			// construct the uri with our apikey
			var moviesSearchUrl = baseUrl + 'apikey=' + apikey + "&page_limit=10";
			
			$(document).ready(function() {

			  // send off the query
			  $.ajax({
			    url: moviesSearchUrl,
			    dataType: "jsonp",
			    success: upcomingCallback
			  });
			});
		}
		
		// receives the results
        function upcomingCallback(data) {
        	//alert("Inside upcomingCallback() method");
            $('upcomingMovieListTable').append('Found ' + data.total + " movies");
            //alert("'Found ' + data.total");
            var movies = data.movies;
            $.each(movies, function(index, movie) {
                $('#upcomingMovieListTable').append(
                '<tr><td class="ajaxfilmlisttitle"><h3><a href="movieDetails.jsp?movie_id=' + movie.id +
                '">' +  movie.title +
                '</td><td class="ajaxfilmlistinfo">' + movie.mpaa_rating +
                '</td><td>' + movie.release_dates.theater + '</td></tr>');
            });
            
            upcomingloaded = 1;
            if (popularloaded > 0 && upcomingloaded > 0) {
	            $('#loading').hide();
            }
        };
	
	
	</script>
	
	

</head>
<body onload="populateTables()">
	<h1>Movie Dashboard</h1>
	<span id="loading" style="display:none"><h2><font color="green">Loading...</font></h2></span>
	<table width="100%">
		<tr>
			<td width="45%">
				<h3>In Theaters</h3>
				<table id="inTheatreMovieListTable" border="1"  cellpadding="0" cellspacing="0">
					<tr>
						<th> Title </th>
						<th> Rating </th>
						<th> Score </th>
					</tr>
				</table>
			</td>
			<td width="45%">
				<h3>Upcoming Movies</h3>
				<table id="upcomingMovieListTable" border="1" width="45%" cellpadding="0" cellspacing="0">
					<tr>
						<th> Title </th>
						<th> Rating </th>
						<th> Date </th>
					</tr>
				</table>
			</td>
		</tr>
	
	</table>
</body>
</html>