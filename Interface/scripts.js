$(function () {

    window.addEventListener('message', function(e){
        var item = e.data 
        if (item.display == true) {
            $('#container').show();
        }else {
            var audio = new Audio('sound/close.mp3');
            audio.volume = 0.2;
            audio.play();
            $('#container').fadeOut(300);
        }
    })



    $(document).keyup(function(e) {
        if (e.key === "Escape") { // escape key maps to keycode `27`
            $('#container').fadeOut(300);
            $.post(`https://${GetParentResourceName()}/exit`,false);
        }
    });


    $('#exitbtn').click(function(){
        $.post(`https://${GetParentResourceName()}/exit`,false);
        $('#container').fadeOut(300);
        $('#fName_input').val('');
        $('#lName_input').val('');
    });
    


});


function playsound() {
    var audio = new Audio('sound/open.mp3');
    audio.volume = 0.2;
    audio.play();
}


function confirm() {
    // playsound()
    var success = new Audio('sound/success.mp3');
    var wrong = new Audio('sound/wrong.mp3');


    var pass = true;



    var fnamena = $('#fName_input').val();
    var lnamena = $('#lName_input').val();

    let fristname_text = fnamena.replace(/^\s+|\s+$/gm,'');
    let lasttname_text = lnamena.replace(/^\s+|\s+$/gm,'');

    console.log(fristname_text);
    console.log(lasttname_text);
    



    if (fristname_text !== undefined && lasttname_text !== undefined) {

        if (fristname_text.length < 2) {
            pass = false

            wrong.volume = 0.2;
            wrong.play();

            Swal.fire({
                icon: 'error',
                title: 'คุณต้องใส่ชื่อให้ยาวกว่า 3 ตัวอักษร',
                text: '',
                footer: ''
            })
        } else if (lasttname_text.length < 2) {
            pass = false
            wrong.volume = 0.2;
            wrong.play();
            Swal.fire({
                icon: 'error',
                title: 'คุณต้องใส่นามสกุลให้ยาวกว่า 3 ตัวอักษร',
                text: '',
                footer: ''
            })
        }
        if (fristname_text.length > 20 || lasttname_text.length > 20) {
            pass = false
            wrong.volume = 0.2;
            wrong.play();
            Swal.fire({
                icon: 'error',
                title: 'คุณใส่ชื่อหรือนามสกุลยาวเกิน 20 ตัวอักษร',
                text: '',
                footer: ''
            })
        }

        if (pass) {

            Swal.fire({
                title: `คุณแน่ใจหรือไม่ที่จะเปลี่ยนชื่อเป็น\n${fristname_text} ${lasttname_text}`,
                text: `หากคุณเเน่ใจที่ต้องการเปลี่ยนชื่อคุณต้องเสีย \nบัตรเปลี่ยนชื่อ เพื่อดำเนินการ`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'ตกลง',
                cancelButtonText: 'ยกเลิก'
            }).then((result) => {
                if (result.isConfirmed) {
                    setTimeout(() => {
                        success.volume = 0.2;
                        success.play();
                      }, "500")


                    $.post(`https://${GetParentResourceName()}/success`, JSON.stringify({
                        'fName': fristname_text,
                        'lName': lasttname_text
                    }));


                    console.log(fristname_text,lasttname_text);


                    $.post(`https://${GetParentResourceName()}/exit`,false);
                    $('#container').fadeOut(300);
                    $('#fName_input').val('');
                    $('#lName_input').val('');
                }
            })

        }
    }
}