function shrinkNav() {
    if ($(".navbar").offset().top > 50) {
        $(".navbar-fixed-top").addClass("top-nav-collapse");
    } else {
        $(".navbar-fixed-top").removeClass("top-nav-collapse");
    }
}

function scrollNavClick(event) {
    var $href = $(this).attr('href');
        var $there = $($href)
        
        // If we are not on a page with those anchors, go to home page.
        if ($there.length === 0) {
            window.location="/"+$href;
            event.preventDefault();
            return false;
        }

        // Otherwise scroll nicely to anchor.
        $('html, body').stop().animate({
            scrollTop: $($href).offset().top
        }, 800, 'easeInOutExpo');
    
        event.preventDefault();
}

//jQuery to collapse the navbar on scroll
$(window).scroll(shrinkNav);

//jQuery for page scrolling feature - requires jQuery Easing plugin
// Normally on document ready, but with turbolinks you change the event.
document.addEventListener("turbolinks:load",function(){
    $('a.page-scroll').bind('click', scrollNavClick);

    // Add on for collapsing nav bar on click
    $('.navbar-collapse a').bind('click', function(){
        $(".navbar-collapse").collapse('hide');
    });
})
