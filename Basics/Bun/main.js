const worker = new Worker(new URL('./worker.js', import.meta.url).href);
worker.onmessage = (evt) => {
    console.log(evt.data);
};
