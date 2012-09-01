      function show_hide(id)
      {
          if(document.getElementById(id).style.display == 'none')
              document.getElementById(id).style.display = 'block'
          else
              document.getElementById(id).style.display = 'none'
      }

      function rate_up(id)
      {
          new Ajax.Request("/products/rate/" + id + "/1",   
              {     
                    method:'get',     
                    onSuccess: function(transport){       
                        var response = transport.responseText || "no response text";       
                          $('#ratecomment_' + id).remove();
                          $(response).insertBefore($('#last_' + id));
//                        alert("Success! \n\n" + response);     
                    },     
                    onFailure: function(){ /*alert('Something went wrong...')*/ }   
              }
          );
      }

    function rate_down(id)
    {
          new Ajax.Request("/products/rate/" + id + "/0",   
              {     
                    method:'get',     
                    onSuccess: function(transport){       
                        var response = transport.responseText || "no response text";       
                          $('#ratecomment_' + id).remove();
                          $(response).insertBefore($('#last_' + id));
//                        alert("Success! \n\n" + response);     
                    },     
                    onFailure: function(){ /*alert('Something went wrong...')*/ }   
              }
          );
      }

function keyRestrict(e, validchars) 
{
     var key='', keychar='';
     key = getKeyCode(e);
     if (key == null) return true;
     keychar = String.fromCharCode(key);
     keychar = keychar.toLowerCase();
     validchars = validchars.toLowerCase();
     if (validchars.indexOf(keychar) != -1)
        return true;
     if ( key==null || key==0 || key==8 || key==9 || key==13 || key==27 )
        return true;
     return false;
}
function getKeyCode(e)
{
     if (window.event)
        return window.event.keyCode;
     else if (e)
        return e.which;
     else
        return null;
}

function charCount(id,Div,num)
{
    var str=document.getElementById(id).value;
    if((num-str.length)<0)
    {
        document.getElementById(id).value=str.substring(0,num);str=document.getElementById(id).value;
    }
    var left_char=num-str.length
    document.getElementById(Div).innerHTML=left_char+" characters are left";
}
