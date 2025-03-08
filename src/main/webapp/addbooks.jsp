<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="container">
<nav class="navbar navbar-expand-lg" style="background-color: #FFF0F5;">
    <div class="container-fluid">
        <a class="navbar-brand" href="addbooks.jsp"><i class="bi bi-book"></i> Add Books</a>
        <a class="navbar-brand" href="user.jsp"><i class="bi bi-people"></i> Manage Users</a>
        <a class="navbar-brand" href="books.jsp"><i class="bi bi-collection"></i> Books</a>
        <a class="navbar-brand" href="admin.jsp"><i class="bi bi-receipt"></i> Transaction History</a>
    </div>
</nav>
<div class="container mt-4">
  <div class="card shadow p-4" style="max-width: 500px; margin: auto;">
    <h3 class="text-center mb-3">Add Books</h3>
<form class="was-validated" action="AddBooks" method="post"  enctype="multipart/form-data">
      <div class="mb-3">
        <label for="validationText" class="form-label">Title</label>
        <input name="bookname" type="text" class="form-control" id="validationText" placeholder="Enter Title of the Book" required>
        <div class="invalid-feedback">
         	Enter Title
        </div>
</div>
    
    <p>
      <div class="mb-3">
        <label for="validationEmail" class="form-label">Author</label>
        <input name="author" type="text" class="form-control" id="validationEmail" placeholder="Enter Author" required>
        <div class="invalid-feedback">
         	Enter the Author's Name
        </div>
</div>
    
 <div class="mb-3">
        <label for="validationPassword" class="form-label">Category</label>
        <input name="category" type="text" class="form-control" id="validationPassword" placeholder="Enter Category" required>
        <div class="invalid-feedback">
         	Enter the Category
        </div>
      </div>
 <div class="mb-3">
        <label for="validation" class="form-label">Available Book Count</label>
        <input name="count" type="number" class="form-control" id="validation" placeholder="Available books" required>
        <div class="invalid-feedback">
         	Enter the Available Count
        </div>
    </div>
     <div class="mb-3">
            <label for="validation" class="form-label">Book Image</label>
    
<input type="file" name="book_image" accept="book_images/*" required class="form-control" id="validation" placeholder="Enter image">
<div class="invalid-feedback">
         	Enter the Book Image
        </div>
</div>
     <div class="mb-3">
    <button value="Register" class="btn btn-primary" type="submit">Add Book</button>
  </div>
</form>
</div>
</div>
</body>
</html>