<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Bootstrap 3, from LayoutIt!</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script> 
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/js/bootstrap-editable.min.js"></script> 
 <script>
$(document).ready(function() {
    $('#username').editable({
     type: 'text',
    pk: this.data-pk,
    url: '/post',
    title: 'Enter username'
    });
});
</script>
  </head>
  <body>

    <div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<img alt="Bootstrap Image Preview" src="https://www.psegliny.com/appImages/PSEGLI/PSEGLI_Logo.jpg">
		</div>
	</div>
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<table class="table">
				<thead>
					<tr>
						<th>
							#
						</th>
						<th>
							Product
						</th>
						<th>
							Payment Taken
						</th>
						<th>
							Status
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							1
						</td>
						<td>
							TB - Monthly
						</td>
						<td>
							01/04/2012
						</td>
						<td>
							<a href="#" id="username" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">superuser</a>

						</td>
					</tr>
					<tr class="active">
						<td>
							1
						</td>
						<td>
							TB - Monthly
						</td>
						<td>
							01/04/2012
						</td>
						<td>
							Approved
						</td>
					</tr>
					<tr class="success">
						<td>
							2
						</td>
						<td>
							TB - Monthly
						</td>
						<td>
							02/04/2012
						</td>
						<td>
							Declined
						</td>
					</tr>
					<tr class="warning">
						<td>
							3
						</td>
						<td>
							TB - Monthly
						</td>
						<td>
							03/04/2012
						</td>
						<td>
							Pending
						</td>
					</tr>
					<tr class="danger">
						<td>
							4
						</td>
						<td>
							TB - Monthly
						</td>
						<td>
							04/04/2012
						</td>
						<td>
							Call in to confirm
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-2">
		
		</div>
	</div>
</div>

    <!-- <script src="http://localhost:8080/customersearchportal/resources/js/jquery.min.js"></script> 
     <script src="http://localhost:8080/customersearchportal/resources/js/bootstrap.min.js"></script>
    <script src="http://localhost:8080/customersearchportal/resources/js/scripts.js"></script>  -->
  </body>
</html>