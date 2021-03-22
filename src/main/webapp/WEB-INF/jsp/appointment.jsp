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
                        <h6 class="m-0 font-weight-bold text-primary">Appointment Listing</h6>
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

<!-- Modal -->

<div class="modal fade" id="form" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header border-bottom-0">
                <h5 class="modal-title" id="ModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
                <div class="modal-body">
                    <form>
                    <input type="hidden" id="modalappointid" />
                        <input type="hidden" id="modaltreatmentid" />
                    <table class="table col-md-12">
                        <tr>
                            <td>
                                Appointment Number
                            </td>
                            <td id="modalnumber" colspan="2">

                            </td>
                        </tr>
                        <tr>
                            <td>
                                Customer Name
                            </td>
                            <td id="modalname" colspan="2">

                            </td>
                        </tr>
                        <tr>
                            <td>
                                Treatment
                            </td>
                            <td id="modaltreatment" colspan="2">

                            </td>
                        </tr>
                        <tr>
                            <td>
                                Phone Number
                            </td>
                            <td id="modalphone" colspan="2">

                            </td>
                        </tr>
                        <tr>
                            <td>
                                IC Number
                            </td>
                            <td id="modalic" colspan="2">

                            </td>
                        </tr>
                        <tr>
                            <td>
                                Appointment Date
                            </td>
                            <td id="" colspan="2">

                                <input type="date" onchange="onchange_data(this)" placeholder="" class="form-control col-md-12" id="modaldate"  min='2021-03-21'>
                            </td>
                        </tr>


                    </table>

                    <div class="form-group">
                        <label>Change Slot</label>
                        <table  class="table " id="modalslot">

                        </table>
                    </div>

                    </form>
                </div>
                <div class="modal-footer border-top-0 d-flex justify-content-center">
                    <button type="button" class="btn btn-success" onclick="submit()" >Submit</button>
                </div>
        </div>
    </div>
</div>
<%@ include file="script.jsp" %>

<script>
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    // Call the dataTables jQuery plugin
    $(document).ready(function() {

        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();
        if(dd<10){
            dd='0'+dd
        }
        if(mm<10){
            mm='0'+mm
        }

        today = yyyy+'-'+mm+'-'+dd;
        document.getElementById("modaldate").setAttribute("min", today);

        $.ajax({
            url: "${apirooturl}/dashappointment/${user.getVetID()}",
            method: "get",
            data: "",
            beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                console.log(data)
                $('#dataTable').DataTable({
                    data: data,
                    columns: [
                        { title: "Appointment Number", data: "appointment.appointmentNumber"},
                        { title: "Customer Name", data: "appointment.patientName" },
                        { title: "Treatment", data: "treatment.treatmentName" },
                        { title: "Phone Number", data: "customer.contactNumber" },
                        { title: "IC Number", data: "customer.icNumber" },
                        { title: "Appointment Date", data: "appointmentDateFormat" },
                        { title: "Start Time", data: "appointmentStartTimeFormat" },
                        { title: "End Time", data: "appointmentEndTimeFormat" },
                        { title: "Veter Name", data: "veter.veterName" },
                        { title: "Status", data: "appointmentStatusFormat" },
                         { title: "Action", data: "appointmentDateFormat",
                             render: function(data) {
                                 var now = Date.now();
                                 if(now < new Date(data)) {
                                 return '<div class="col-md-12"> ' +
                                 '<button type="button" class="btn btn-primary btn-sm " style="width: 75px" onclick="edit(this)" style="">Edit</button>  '
                                 +'<button type="button" class="btn btn-danger btn-sm " style="width: 75px;margin-top:2px" onclick="cancel(this)" style="">Cancel</button>  '
                                 +'</div>';

                                 }
                                 else {
                                    return null;
                                 }

                             }, }
                    ],
                    columnDefs: [

                        { orderable: false, searchable: false, targets: -1 } //Ultima columna no ordenable para botones
                    ],

                });
            }

        });



    });

    function cancel(e){
        if (confirm('Are you sure you want to cancel this appointment?')) {


        var currentRow = $(e).closest("tr");

        var tbdata = $('#dataTable').DataTable().row(currentRow).data();
        var appointmentid = tbdata.appointment.appointmentID;
        var appointmentnumber = tbdata.appointment.appointmentNumber;

        //get the real row index, even if the table is sorted
        $.ajax({
            url: "${apirooturl}/dashappointment/appointmentNumber/cancel",
            method: "post",
            data: appointmentnumber,
            contentType: "application/json",
            beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                console.log(data)
                if(data == true){
                    alert(appointmentnumber + " is cancelled");
                    location.reload();
                }else{
                    alert("Fail to cancel!");
                }

            },
            error: function(data) {
                console.log(data);
            },
        });


        }

    }

    function onchange_data(e){

        $.ajax({
            url: "${apirooturl}/dashappointment/" + ${user.getVetID()} +"/" +
                $("#modaltreatmentid").val() +"/" + $(e).val(),
            method: "get",
            data: "",
            beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                var tr=""
                console.log(data)
                for(var x=0; x<data.length; x++){
                    tr += "<tr class='bg-primary text-white'><td colspan='3' style=''>" + data[x].veter.veterName+"</td></tr>";
                    var slots = data[x].availableSlots;
                    if(slots != null){

                        for(var j=0;j<slots.length; j++){

                            var time_s = new Date(slots[j].startTime);
                            var time_e = new Date(slots[j].endTime);

                            time_s = convertdatetime_time(time_s);
                            time_e = convertdatetime_time(time_e);


                            if(slots[j].available){
                                tr += "<tr  class='slotslist'>" +
                                    "<td><input type='radio' name='slotscheck' />" +
                                    "<input type='hidden' value='" + data[x].veter.veterID +"' name='veterid' /></td>" +

                                    "</td>";

                            }else{
                                tr += "<tr>" +
                                    "<td>-</td>";
                            }
                            tr +=
                                "<td><input type='hidden' value='" + slots[j].startTime +"' name='starttime'  /> " + time_s+"</td>" +
                                "<td><input type='hidden' value='" + slots[j].endTime +"' name='endtime' />" + time_e+"</td>" +
                                "</tr>";


                        }

                    }else{
                        tr += "<tr>" +
                            "<td colspan='3'>No working schedule</td>"+
                            "</tr>";
                    }
                }
                $("#modalslot").html(tr);

            },
            error: function(data) {
                console.log(data);
            },
        });
    }

    function fillslot(){

    }

    function edit(e){
        var currentRow = $(e).closest("tr");

        var tbdata = $('#dataTable').DataTable().row(currentRow).data();
        console.log(tbdata);
        $("#modalnumber").text(tbdata.appointment.appointmentNumber);
        $("#modalname").text(tbdata.customer.displayName);
        $("#modaltreatment").text(tbdata.treatment.treatmentName);
        $("#modalphone").text(tbdata.customer.contactNumber);
        $("#modalic").text(tbdata.customer.icNumber);
        $("#modaldate").val(tbdata.appointmentDateFormat);
        $("#modalappointid").val(tbdata.appointment.appointmentID)
        $("#modaltreatmentid").val(tbdata.treatment.treatmentID)
        $("#ModalLabel").text("Edit Appointment");

        $.ajax({
            url: "${apirooturl}/dashappointment/" + ${user.getVetID()} +"/" + tbdata.treatment.treatmentID +"/" + tbdata.appointmentDateFormat,
            method: "get",
            data: "",
            beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                var tr=""
                console.log(data)
                for(var x=0; x<data.length; x++){
                    tr += "<tr class='bg-primary text-white'><td colspan='3' style=''>" + data[x].veter.veterName+"</td></tr>";
                    var slots = data[x].availableSlots;
                    if(slots != null){

                        for(var j=0;j<slots.length; j++){

                            var time_s = new Date(slots[j].startTime);
                            var time_e = new Date(slots[j].endTime);

                            time_s = convertdatetime_time(time_s);
                            time_e = convertdatetime_time(time_e);

                            if(slots[j].startTime == tbdata.appointment.appointmentStartTime && slots[j].endTime == tbdata.appointment.appointmentEndTime){
                                tr += "<tr class='slotslist' >" +
                                    "<td><input type='radio' name='slotscheck' checked /> " +
                                    "<input type='hidden' value='" + data[x].veter.veterID +"' name='veterid' /></td>" +
                                    "<td><input type='hidden' value='" + slots[j].startTime +"' name='starttime' />" + time_s+"</td>" +
                                    "<td><input type='hidden' value='" + slots[j].endTime +"' name='endtime'  />" + time_e+"</td>" +
                                    "</tr>";
                            }else{
                                if(slots[j].available){
                                    tr += "<tr  class='slotslist'>" +
                                        "<td><input type='radio' name='slotscheck' />" +
                                        "<input type='hidden' value='" + data[x].veter.veterID +"' name='veterid' /></td>" +

                                    "</td>";

                                }else{
                                    tr += "<tr>" +
                                        "<td>-</td>";
                                }
                                tr +=
                                    "<td><input type='hidden' value='" + slots[j].startTime +"' name='starttime'  /> " + time_s+"</td>" +
                                    "<td><input type='hidden' value='" + slots[j].endTime +"' name='endtime' />" + time_e+"</td>" +
                                    "</tr>";
                            }

                        }

                    }else{
                        tr += "<tr>" +
                            "<td colspan='3'>No working schedule</td>"+
                            "</tr>";
                    }
                }
                $("#modalslot").html(tr);

            },
            error: function(data) {
                console.log(data);
            },
        });

        $("#form").modal('toggle');
    }

    function submit(){
        var id = $("#modalappointid").val();
        var modaldate = $("#modaldate").val();

        var starttime = $('input[name=slotscheck]:checked').parent().next('td').find('input[name="starttime"]').val();
        var endtime = $('input[name=slotscheck]:checked').parent().next('td').next('td').find('input[name="endtime"]').val();
        var veterid = $('input[name=slotscheck]:checked').next('input').val();
        console.log( $('input[name=slotscheck]:checked').val())
        console.log(starttime)
        console.log(endtime)
        var data = {
            "appointmentStartTime": starttime,
            "appointmentDate" : modaldate,
            "appointmentEndTime": endtime,
            "appointmentID": parseInt(id),
            "veterID":parseInt(veterid),
            //  updatedBy:
        };

        console.log(data)
        $.ajax({
            url: "${apirooturl}/dashappointment/edit",
            method: "post",
            data: JSON.stringify(data),
            contentType: "application/json",
            beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
            success: function(data) {

                console.log(data)

                alert(data);
                if(data == "Appointment edit successfully"){
                    location.reload()
                }
            }

        });
    }



    function convertdatetime_date(date){
        var dd = date.getDate();
        var mm = date.getMonth() + 1;
        var yyyy = date.getFullYear();

        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        var formatdate = yyyy + "-" + mm + "-" + dd;
        return formatdate;
    }

    function convertdatetime_time(date){
        var  hour = date.getHours() -7 ,
            min  = date.getMinutes()-30;
        if(hour < 0){
            hour = 24 + hour;
        }
        if(min < 0){
            min = 60 + min;
        }

        if (hour < 10) {
            hour = '0' + hour;
        }

        if (min < 10) {
            min = '0' + min;
        }


        var displayTime = hour + ":" + min;
        return displayTime;
    }
</script>
</body>
</html>