$(document).ready(() => {

    // Mengirim request GET
    $.getJSON("get_faq_content/", (data) => {

        $.each(data, (key, value) => {
            append_e = append_element(value);
            $("#show_question").append(append_e);
        });
    });

    // Mengirim request POST ketika tombol search diklik
    $("#submit_search").click(() => {
        if ($("#search_bar").val() != "") {
            $("#show_question").empty();

            search_input = $("#search_bar").val();
            csrftoken = Cookies.get('csrftoken');

            data_send = {
                'search': search_input,
                'csrfmiddlewaretoken': csrftoken
            }

            $.post('search/', data_send, (data) => {
                $.each(data, (key, value) => {
                    append_e = append_element(value);

                    $("#show_question").append(append_e);
                });
            });
        }
        else {
            $("#show_question").empty();
            $.getJSON("get_faq_content/", (data) => {

                $.each(data, (key, value) => {
                    append_e = append_element(value);
                    $("#show_question").append(append_e);
                });
            });
        }
    })

});

// Fungsi untuk mengatur tampilan Question yang mau ditampilkan
append_element = (x) => {
    result = 
    "<div class=\"list-group w-100\" >"+
        "<a href=\""+x.pk+"/\"   class=\"list-group-item list-group-item-action\">"+
            "<div class=\"d-flex w-100 justify-content-between\">"+
                "<h5 class=\"mb-1\">"+x.fields.question+"</h5>"+
            "</div>"+
        "</a>"+
    "</div>"

    return result
}      
