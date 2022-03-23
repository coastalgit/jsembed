/*
async function doDelayedUpdate(timerVal) {
  let promiseA = new Promise((resolve, reject) => {
    let wait = setTimeout(() => {
      clearTimeout(wait);
      resolve('Timer complete');
    }, timerVal);
  });
    await promiseA.then(() => _doUpdate);

  return promiseA;
}

_doUpdate = () => {

}
*/

function updateDOM(inVal){
    const currentDate = new Date();
    document.getElementById("testid").innerHTML = inVal+' : '+currentDate.toTimeString();
}
