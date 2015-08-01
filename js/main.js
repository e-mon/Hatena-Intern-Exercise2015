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

   var key = matched[1];
   var value = matched[2];

   if(!isNaN(value)){
      value = Number(value);
   }

   return [key,value];
}
// 課題 JS-2: 関数 `createLogTable` を記述してください
