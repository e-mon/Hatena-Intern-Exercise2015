// 課題 JS-1: 関数 `parseLTSVLog` を記述してください
function parseLTSVLog(logStr){
   logStr = logStr.replace(/\n+$/g,'');
   if(logStr === "")
      return [];

   var logs = logStr.split('\n').map(
         function(elem){
            // TODO: \tを含まない場合は例外処理
            return elem.split('\t');
         }
   );

   return logs.map( function(log){
            var res = {};
            log.forEach(function(elem){
               var ret = _toObj(res,elem);
               // TODO: ret == falseは例外処理
            });
            return res;
         });
}

function _toObj(obj,str){
   var tmp = str.split(':');
   if(tmp.length != 2)
      return false;

   var key = tmp[0];
   var value = tmp[1];

   if(!isNaN(value)){
      // TODO: float
      value = parseInt(value);
   }
   obj[key] = value;

   return true;
}
// 課題 JS-2: 関数 `createLogTable` を記述してください
