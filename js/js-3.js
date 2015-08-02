// 課題 JS-3 の実装をここに記述してください。
function displayLogTable(){
   var elem = document.getElementById('table-container');
   var text = document.getElementById('log-input').value;
   
   elem.innerHTML = "";
   createLogTable(elem, parseLTSVLog(text));
}

document.getElementById('submit-button').addEventListener("click",displayLogTable,false);
