<!DOCTYPE html>
<html lang="en">

<%@ include file="header.jsp" %>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <%@ include file="menu.jsp" %>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <%@ include file="topbar.jsp" %>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->

            <div class="container-fluid">


                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Veterinarian Listing</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">

                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

        <!-- Footer -->
        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>Copyright &copy; Your Website 2020</span>
                </div>
            </div>
        </footer>
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="login.html">Logout</a>
            </div>
        </div>
    </div>
</div>
<%@ include file="script.jsp" %>

<script>
    // Call the dataTables jQuery plugin
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    $(document).ready(function() {
        $.ajax({
            url: "${apirooturl}/dashdentist/dental/${user.getDentalID()}",
            method: "get",
            data: "",
            beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                $('#dataTable').DataTable({
                    data: data,
                    columns: [
                        { title: "Name", data: "dentist.dentistName" },
                        { title: "Description", data: "dentist.dentistDescription" },

                        { title: "Action", data: null }
                    ],
                    columnDefs: [

                        {
                            targets: -1,
                            data: null,
                            defaultContent: '<div class="btn-group"> ' +
                                '<button type="button" class="btn btn-primary btn-sm " onclick="edit(this)" style="">Edit</button>  '
                                +'</div>'
                        },
                        { orderable: false, searchable: false, targets: -1 } //Ultima columna no ordenable para botones
                    ],

                });
            }

        });
    });

</script>
</body>

</html>