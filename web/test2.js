function confirmInJS(text) {
    confirm(text)
}

const promiseTimeout = function(timeoutMs, promise){
   //console.log({ js_context: this, 'TIMEOUT:'+timeoutMs });
  // Create a promise that rejects in <ms> milliseconds
  let timeout = new Promise((resolve, reject) => {
    let id = setTimeout(() => {
      clearTimeout(id);
      reject('Timed out in '+ timeoutMs + 'ms.')
    }, timeoutMs)
  })

  // Returns a race between our timeout and the passed in promise
  return Promise.race([
    promise,
    timeout
  ])
}

async function doTimer(timeoutInMs, timerVal){
    //console.log({ js_context: this, 'TIMER:'+timerVal });
    let promiseA = new Promise((resolve, reject) => {
      let wait = setTimeout(() => {
        clearTimeout(wait);
        resolve('Timer complete');
      }, timerVal)
    })

    return promiseTimeout(timeoutInMs, promiseA);
}

function updateLabel(){
    var currentDate = new Date();
    window.updateDartLabel('From JS - '+currentDate.toDateString());
}

function updateElement(){
    var currentDate = new Date();
    window.updateDartElement('testid', 'DT: '+currentDate.toDateString());
}

/*
//direct DOM approach does not work
function updateLabelViaDOM(){
    var currentDate = new Date();
    document.getElementById("testid").innerHTML = currentDate.toDateString();
}
*/


window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}