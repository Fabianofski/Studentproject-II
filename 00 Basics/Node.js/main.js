const { Worker, isMainThread, workerData } = require('node:worker_threads}');
if (isMainThread) {
    /* This is the main thread */
    new Worker(__filename, { workerData: 'Hello from the Worker Thread!' });
} else {
    console.log(workerData);
}