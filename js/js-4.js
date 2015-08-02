function search(){
   var elem = document.getElementById('table-container');
   var text = document.getElementById('log-input').value;
   var key = document.getElementById('column').value;
   var value = document.getElementById('search-value').value;
   
   elem.innerHTML = "";
   logs = parseLTSVLog(text).filter(function(log){
       if (key === "" || value === ""){
           return true;
       }else{
           return filter(key, value, log);
       }
   });
   createLogTable(elem, logs);
}

function filter(key, value, log){
    if(!isNaN(log[key])){
        text = String(log[key]);
    }else{
        text = log[key];
    }
    if(~text.indexOf(value)){
        return true;
    }else{
        return false;
    }
}

document.getElementById('search-value').addEventListener("input",search,false);
