let resourceName = "wessy_autovote";

window.addEventListener("keydown", function(e) {
  var t;
  t = e.which || e.keyCode;
  if ((t == 27)) {
      $.post('http://'+resourceName+'/closemenu', JSON.stringify({}));
  }
})

$(document).ready(function(){
    // LUA listener

    $('#iframe').load(function () {
      var contents = $(this).contents(); // contents of the iframe
      $(contents).find("body").on('keydown', function (e) {
        var t;
        t = e.which || e.keyCode;
        if ((t == 27)) {
            $.post('http://'+resourceName+'/closemenu', JSON.stringify({}));
            
        }
      });
    });

    window.addEventListener('message', function( event ) {
      var steamid = event.data.steamid;
      if (event.data.action == 'vote') {
        let Hud = document.getElementById('content');
        let Hud2 = document.getElementById('iframe');
        Hud.style.opacity = "1.0";
        Hud2.src = 'https://de.top-games.net/rdr/vote/URL_NAME_SERVER?pseudo='+steamid;
      }
      if (event.data.action == 'close') {

        let Hud = document.getElementById('content');
        let Hud2 = document.getElementById('iframe');
        Hud.style.opacity = "0.0";
        Hud2.src = '';

        //Option with catch
        fetch( "https://api.top-games.net/v1/votes/claim-username?server_token=YOUR_SERVER_TOKEN&playername="+steamid)
        .then(async r=> senddata(await r.json()))
        .catch(e=>console.error('Boo...' + e));
        
      }
    });
});

function senddata(p1) {
  $.post('http://'+resourceName+'/claimed', JSON.stringify({claimed:p1.claimed, success:p1.success}));
  //console.log(p1)
}

function closeing() {
  //console.log("closing")
  $.post('http://'+resourceName+'/closemenu', JSON.stringify({}));
}
