// 課題 JS-1: 関数 `parseLTSVLog` を記述してください
function parseLTSVLog(logStr){
   logStr = logStr.replace(/\n+$/g,'');
   if(!logStr)
      return [];

   return logStr.split('\n').map(LTSVparser);
}

function LTSVparser(log){
   var obj = {};
   log.split(/\t/).forEach(function (field){
      var parsed = zipObj(field);
      obj[parsed[0]] = parsed[1];
   });
   return obj;
}

function zipObj(str){
   var FORMAT_PATTERN = /([^:]+):(.*)/
   var matched = FORMAT_PATTERN.exec(str);
   if(!matched)
      return false;

   var key = matched[1].trim();
   var value = matched[2];

   if(!isNaN(value)){
      value = Number(value);
   }

   return [key,value];
}
// 課題 JS-2: 関数 `createLogTable` を記述してください
function createLogTable(elem, logs){
   var tbody = document.createElement('tbody');
   var columns = [];
   logs.forEach(function(log){
      columns = columns.concat(Object.keys(log));
      tbody.appendChild(createTableContents(log));
   });

   columns = columns.filter(function(x,i,self){
       return self.indexOf(x) == i;
   });
   var thead = createTableHeader(columns);
   var table = document.createElement('table');
   table.appendChild(thead);
   table.appendChild(tbody);

   elem.appendChild(table);
}

function createTableHeader(columns){
   var elem = document.createElement('tr');
   var tableHeader = document.createElement('thead');
   columns.forEach(function(column){
      var head = document.createElement('th');
      head.innerHTML = column;
      elem.appendChild(head);
   });
   tableHeader.appendChild(elem);
   return tableHeader;
}

function createTableContents(log){
   var elem = document.createElement('tr');
   Object.keys(log).forEach(function(key){
      var td = document.createElement('td');
      td.innerHTML = log[key];
      elem.appendChild(td);
   });

   return elem;
}

