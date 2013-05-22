function pack_machines_js() {
    payment = $('input[name="order[payment]"]:checked').val();
    delivery = $('input[name="order[delivery_method]"]:checked').val();
    if ((delivery == 'Paczkomaty InPost') && ((payment == 0) || (payment == 2))) {
        result = 10.0;
        $("#pack_machine_div").show();
        $("#payment_1_div").hide();
    } else if ((delivery == 'Paczkomaty InPost') && (payment == 1)) {
        result = 13.0;
        $("#pack_machine_div").show();
        $("#payment_1_div").hide();
    } else if (payment == 1) {
        result = 10.5;
        $("#pack_machine_div").hide();
        $("#payment_1_div").show();
    } else {
        result = 0;
        $("#pack_machine_div").hide();
        $("#payment_1_div").show();
    }
    $("#order_delivery_payment_label").text(((Math.round(result * 100) / 100).toFixed(2) + " zł").replace('.', ','));
    $("#order_delivery_payment").val((Math.round(result * 100) / 100).toFixed(2));
}

$(function () {
    $(".calculations").change(function () {
        pack_machines_js();
    });
});
$(function () {
    $('#slideshow').cycle({
        fx: 'fade',
        speed: 700,
        timeout: 5000,
        pager: '#nav',
        pagerEvent: 'mouseover',
        pause: true,
        slideExpr: 'img',
        next: '#next',
        prev: '#prev'
    });
});
$(function () {
    $('.sort-select').change(function () {
        $(this).closest('.sort-form').submit();
    });
});

function initTooltip() {
    $(function () {
        $('.help').tooltip({
            delay: 3,
            track: true,
            showURL: false,
            showBody: " # "
        });
    });
}

initTooltip();