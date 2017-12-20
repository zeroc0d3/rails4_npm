var usersTable = {};

function createUsersTable() {
  usersTable = $('#users-table').dataTable({
    "destroy": true,
    "sDom": '<"top"fi>rt<"bottom"lp><"clear">',
    "sPaginationType": "simple_numbers",
    "bJQueryUI": false,
    "bProcessing": false,
    "bServerSide": true,
    "bPaginate": true,
    "bFilter": false,
    "bInfo": true,
    "responsive": true,
    "processing": false,
    "bStateSave": true,
    "bDeferRender": true,
    "sAjaxSource": $('#users-table').data('source'),
    "columnDefs": [
      {
        orderable: false,
        targets: [5]
      }
    ],
    "order": [
      [
        4,
        'desc'
      ]
    ],
    "fnbStateSave": function (oSettings, oData) {
      // localStorage.setItem( 'DataTables', JSON.stringify(oData) );
      localStorage.setItem('DataTables_' + window.location.pathname, JSON.stringify(oData))
    },
    "fnStateLoad": function (oSettings) {
      return JSON.parse(localStorage.getItem('DataTables'));
      // JSON.parse(localStorage.getItem('DataTables_' + window.location.pathname))
    }
  })
}

function filterUsers() {
  var filter_global = $('#users_global_filter').val();
  var filter_vendor = $('#users_vendor_filter').select2('val');
  var date_start = $('#users_date_start').val();
  var date_end = $('#users_date_end').val();

  var end_point = '/manage/users';
  var filter_search = '?keyword=' + filter_global + '&vendor_id=' + filter_vendor + '&start_date=' + date_start + '&end_date=' + date_end;

  usersTable.DataTable().clear().ajax.url(end_point + filter_search).draw();
}

function clearUsersFilter() {
  $('#users_global_filter').val('');
  $('#users_vendor_filter').val('');
  $('#users_date_start').val('');
  $('#users_date_end').val('');
  createUsersTable();
}

$(document).ready(function () {
  createUsersTable();
});