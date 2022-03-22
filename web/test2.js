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

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}