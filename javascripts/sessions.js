
function set(key,value){
    if (typeof(Storage) !== "undefined") {
        // Store
        sessionStorage.setItem(key, value);
        // Retrieve
      } else {
        sessionStorage.setItem("ID", "None");
      }
}

function show(){
    console.log(sessionStorage);
}