$(document).ready(() => {
    const myModal = new bootstrap.Modal(
        $('#myModal'), {
            backdrop: 'static'
        }
    );

    const modalEL = $('#myModal');
    
    $('body').on("click", ".modalShow", function(){
        const dataUrl = $(this).attr('data-url');
        $.ajax({
            url: dataUrl
        }).done((data) => {
            modalEL.on("shown.bs.modal", () => {
                modalEL.html(data);

                const frm = $('#myForm');
                frm.attr('action', dataUrl);
                
                frm.on("submit", (e) => {
                    e.preventDefault()
                    
                    $.ajax({
                        type: frm.attr('method'),
                        url: frm.attr('action'),
                        data: new FormData(frm[0]),
                        contentType: false,
                        cache: false,
                        processData: false
                    }).done(function(data){
                        if(data.err_code === 'invalid_form'){
                            e.preventDefault();
                            for(var key in data.err_msg){
                                $(frm).find("#id_"+key).after('<div class="alert alert-danger alert-dismissible fade show" role="alert"><small>'+data.err_msg[key][0]+'</small><button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>');
                            }
                        } else {
                            window.location.reload();
                        }
                    }).fail(function(xhr, textStatus, thrownError){
                        const abc = xhr.responseText
                        const swal_html = xhr.status >= 400 ? '<p class="text-danger">' + abc.replace(/[^a-z0-9:]/gi,' ') + '</p>' : xhr.status == 500 ? '<div class="clearfix"></div>'+abc : false;
                        alert(swal_html)
                    });
                    return false
                });
            });
            myModal.show();
        })
    });

    
}, false);