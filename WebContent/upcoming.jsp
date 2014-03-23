<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Upcoming Movies</title>

	<link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css"/>
	<link rel="stylesheet" href="css/bootstrap-responsive.min.css" type="text/css"/>
	<link rel="stylesheet" href="css/bootstrap.css" type="text/css"/>
	<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
	
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script src="//datatables.net/download/build/nightly/jquery.dataTables.js"></script>
		
	<style type="text/css">
		th{
			background-color: #A9D0F5;	
		}
	</style>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" > </script>
	<script type="text/javascript">
		var example=jQuery.noConflict();
		$(document).ready(function() {
			$('#upcomingMovieListTable').DataTable();
			$('#inTheatreMovieListTable').DataTable();
		});
	</script>
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
        	//alert("Inside inTheatreCallback() method");
            $('inTheatreMovieListTable').append('Found ' + data.total + " movies");
            //alert("'Found ' + data.total");
            var movies = data.movies;
            $.each(movies, function(index, movie) 
            {
                $('#inTheatreMovieListTable').dataTable().fnAddData(
                	[
                		'<a href="movieDetails.jsp?movie_id=' + movie.id + '">' + movie.title,
                		movie.mpaa_rating,
                		movie.ratings.critics_score
                	]
                );
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
			var moviesSearchUrl = baseUrl + 'apikey=' + apikey;
			
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
            	$('#upcomingMovieListTable').dataTable().fnAddData(
                   	[
                   		'<a href="movieDetails.jsp?movie_id=' + movie.id + '">' + movie.title,
                   		movie.mpaa_rating,
                   		movie.release_dates.theater
                   	]
                 );
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
	<div class="container">
		<span id="loading" style="display:none"><h2><font color="green">Loading...</font></h2></span>
		<table width="100%" cellpadding="5%" height="100%">
			<tr>
				<td width="30%" height="100%">
					<h3>In Theaters</h3>
					<table id="inTheatreMovieListTable" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th> Title </th>
							<th> Rating </th>
							<th> Score </th>
						</tr>
						</thead>
					</table>
				</td>
				<td width="30%" height="100%">
					<h3>Upcoming Movies</h3>
					<table id="upcomingMovieListTable" class="table table-striped table-bordered">
						<thead>
						<tr>
							<th> Title </th>
							<th> Rating </th>
							<th> Date </th>
						</tr>
						</thead>
					</table>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>