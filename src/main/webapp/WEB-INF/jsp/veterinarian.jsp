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
                <div class=" col-md-2 mb-2" >

                    <button class="btn btn-primary" onclick="add()">Add Veterinarian</button>
                </div>

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
                    <div class="form-group">
                        <label>Name</label>
                        <input type="hidden" id="modalveterid"  />
                        <input type="hidden" id="submittype"  />
                        <input type="text" class="form-control" id="modalvetername">
                    </div>
                    <div class="form-group">
                        <label>Gender</label>
                        <select class="form-control" id="modalgender">
                            <option value="0">Male</option>
                            <option value="1">Female</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <input type="text" class="form-control" id="modaldesc">

                    </div>
                    <div class="form-group">
                        <label>On Leave</label>
                        <div class="row col-md-12">
                        <input type="date" placeholder="" class="form-control col-md-6" id="leavestart">
                        <input type="date" placeholder="" class="form-control  col-md-6" id="leaveend">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Working Schedule</label>
                       <table  class="table" id="modalschedule">
                           <tr>
                               <td>Monday</td>
                               <td>  <input type="time" placeholder="" class="form-control" id="mon_s"></td>
                               <td> <input type="time" placeholder="" class="form-control" id="mon_e"></td>
                           </tr>
                           <tr>
                               <td>Tuesday</td>
                               <td> <input type="time" placeholder="" class="form-control " id="tue_s"></td>
                               <td> <input type="time" placeholder="" class="form-control " id="tue_e"></td>
                           </tr>
                           <tr>
                               <td>Wednesday</td>
                               <td> <input type="time" placeholder="" class="form-control " id="wed_s"></td>
                               <td> <input type="time" placeholder="" class="form-control " id="wed_e"></td>
                           </tr>
                           <tr>
                               <td>Thursday</td>
                               <td> <input type="time" placeholder="" class="form-control" id="thu_s"></td>
                               <td> <input type="time" placeholder="" class="form-control" id="thu_e"></td>
                           </tr>
                           <tr>
                               <td>Friday</td>
                               <td> <input type="time" placeholder="" class="form-control " id="fri_s"></td>
                               <td> <input type="time" placeholder="" class="form-control " id="fri_e"></td>
                           </tr>
                           <tr>
                               <td>Saturday</td>
                               <td> <input type="time" placeholder="" class="form-control " id="sat_s"></td>
                               <td> <input type="time" placeholder="" class="form-control " id="sat_e"></td>
                           </tr>
                           <tr>
                               <td>Sunday</td>
                               <td> <input type="time" placeholder="" class="form-control " id="sun_s"></td>
                               <td> <input type="time" placeholder="" class="form-control " id="sun_e"></td>
                           </tr>

                       </table>
                    </div>
                </div>
                <div class="modal-footer border-top-0 d-flex justify-content-center">
                    <button type="button" class="btn btn-success" onclick="submit()" >Submit</button>
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
            url: "${apirooturl}/dashveter/vet/${user.getVetID()}",
            method: "get",
            data: "",
            asyc:true,
            beforeSend: function(xhr) {
                // here it is
                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                console.log(data)
                for(var i =0; i<data.length; i++){
                    if(data[i].leaveStartDate != null){

                        var startdate = new Date(data[i].leaveStartDate);
                        data[i].leaveStartDate =  convertdatetime_date(startdate)

                    }

                    if(data[i].leaveEndDate!= null){

                        var enddate = new Date(data[i].leaveEndDate);
                        data[i].leaveEndDate =  convertdatetime_date(enddate)

                    }

                }
                $('#dataTable').DataTable({
                    data: data,
                    columns: [
                        { title: "veterid", data: "veterID" },
                        { title: "Name", data: "veterName" },
                        { title: "Description", data: "veterDescription" },
                        { title: "Leave Start", data: "leaveStartDate" },
                        { title: "Leave End", data: "leaveEndDate" },
                        { title: "Action", data: null }
                    ],
                    columnDefs: [
                        {
                            targets: 0,
                            visible: false,
                            searchable: false
                        },
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


function edit(e){
    var currentRow = $(e).closest("tr");

    var tbdata = $('#dataTable').DataTable().row(currentRow).data();

    $.ajax({
        url: "${apirooturl}/dashveter/" + tbdata.veterID,
        method: "get",
        data: "",
        asyc:true,
        beforeSend: function(xhr) {
            // here it is
            xhr.setRequestHeader(header, token);
        },
        success: function(data) {

            var startdate = new Date(Date.parse(data.leaveStartDate));
            var enddate = new Date(Date.parse(data.leaveEndDate));

            startdate = convertdatetime_date(startdate)
            enddate = convertdatetime_date(enddate)
            $("#modalveterid").val(data.veterID)
            $("#modalvetername").val(data.veterName);
            $("#modalgender").val(data.gender);
            $("#leavestart").val(startdate);
            $("#leaveend").val(enddate);
            $("#modaldesc").val(data.veterDescription);
            $("#submittype").val("edit");
            for(var x=0; x<data.scheduleList.length; x++){
                var time_s = new Date(data.scheduleList[x].startTime);
                var time_e = new Date(data.scheduleList[x].endTime);
                console.log(time_s)
                console.log(time_e)
                time_s = convertdatetime_time(time_s);
                time_e = convertdatetime_time(time_e);
                if(data.scheduleList[x].dayOfWeek == 1){
                    $("#mon_s").val(time_s);
                    $("#mon_e").val(time_e);
                }
                if(data.scheduleList[x].dayOfWeek == 2){
                    $("#tue_s").val(time_s);
                    $("#tue_e").val(time_e);
                }
                if(data.scheduleList[x].dayOfWeek == 3){
                    $("#wed_s").val(time_s);
                    $("#wed_e").val(time_e);
                }
                if(data.scheduleList[x].dayOfWeek == 4){
                    $("#thu_s").val(time_s);
                    $("#thu_e").val(time_e);
                }
                if(data.scheduleList[x].dayOfWeek == 5){
                    $("#fri_s").val(time_s);
                    $("#fri_e").val(time_e);
                }
                if(data.scheduleList[x].dayOfWeek == 6){
                    $("#sat_s").val(time_s);
                    $("#sat_e").val(time_e);
                }
                if(data.scheduleList[x].dayOfWeek == 7){
                    $("#sun_s").val(time_s);
                    $("#sun_e").val(time_e);
                }
            }
        }

    });
    $("#ModalLabel").text("Edit Veterinarian");
    $("#form").modal('toggle');
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
        var  hour = date.getHours()  /*-7*/ ;
         var    min  = date.getMinutes() /*- 30*/;

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


function submit(){
    var name = $("#modalvetername").val();
    var gender = $("#modalgender").val();
    var veterid = $("#modalveterid").val();
    var leavestart = $("#leavestart").val();
    var leaveend = $("#leaveend").val();
    console.log(leavestart);
    var desc = $("#modaldesc").val();
    var schedulelist = [];
    var start = 1;
    $('#modalschedule tr').each(function(){
        if($(this).find("td input[id*='_e']").first().val() != "" && $(this).find("td input[id*='_s']").first().val() != ""){

            var scheduleobj = {};
            scheduleobj["createdBy"] = "${user.getUserID()}";
            scheduleobj["updatedBy"] = "${user.getUserID()}";

            console.log($(this).find("td input[id*='_e']").first().val() )

            scheduleobj["dayOfWeek"] = start;
            var endtime = "1970-01-01T" + $(this).find("td input[id*='_e']").first().val() + ":00";
            var starttime = "1970-01-01T" + $(this).find("td input[id*='_s']").first().val() + ":00";

            scheduleobj["endTime"] = new Date(endtime)
            scheduleobj["startTime"] = new Date(starttime)
            start++;
            schedulelist.push(scheduleobj);
        }
    })
    console.log(schedulelist)
    var url = "";
    var type = $("#submittype").val();
    if(type == "add"){
        url = "${apirooturl}/dashveter/add/" + ${user.getVetID()};
    }else if (type == "edit"){
        url = "${apirooturl}/dashveter/edit";
    }
    console.log(url)
    $.ajax({
        url: url ,
        method: "post",
        data: JSON.stringify({
            gender : gender,
            leaveEndDate: leaveend,
            leaveStartDate: leavestart,
            veterDescription: desc,
            veterName: name,
            scheduleList:schedulelist,
            veterID: veterid,
            updatedBy: "${user.getUserID()}"
        }),
        contentType: "application/json",
        beforeSend: function(xhr) {
            // here it is
            xhr.setRequestHeader(header, token);
        },
        success: function(data) {
            console.log(data);
            alert(data);
            location.reload();
        },
        error: function(data) {

        }

    });
}
function add(){
    $("#modalvetername").val("");
    $("#modalgender").val("");
    $("#modalveterid").val("");
    $("#leavestart").val("");
    $("#leaveend").val("");
    $("#modaldesc").val("");
    $("#mon_s").val("");
    $("#mon_e").val("");
    $("#tue_s").val("");
    $("#tue_e").val("");
    $("#wed_s").val("");
    $("#wed_e").val("");
    $("#thu_s").val("");
    $("#thu_e").val("");
    $("#fri_s").val("");
    $("#fri_e").val("");
    $("#sat_s").val("");
    $("#sat_e").val("");
    $("#sun_s").val("");
    $("#sun_e").val("");
    $("#ModalLabel").text("Add Veterinarian");
    $("#submittype").val("add");
    $("#form").modal('toggle');
}
</script>
</body>

</html>