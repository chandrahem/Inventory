function ss() {
   
    $('#MarksTable').jtable({
        title: 'Marks Detail',
        paging: true,
        selecting: true,
        pageSize: 10,
        sorting: false,
        columnResizable: false,
        columnSelectable: false,
        actions: {
            listAction: '/Customer/GetStudentMarks',

        },
        fields: {

            CustomerCode: {
                title: 'Roll Number',
                width: '15%'
            },
            CustomerBarCode: {
                title: 'Student Name',
                width: '45%'
            }
        }
    });
    $('#MarksTable').jtable('reload');
}