self.postMessage('Hello from the Worker Thread!');
self.onmessage = (evt) => {
  console.log(evt.data);
};
self.close();