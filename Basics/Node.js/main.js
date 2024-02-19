const { Worker, isMainThread, workerData } = require('node:worker_threads');
const { parentPort } = require('worker_threads');
if (isMainThread) {
    const worker = new Worker(__filename, {
        workerData: 'Hello from the Worker Thread!',
    });
    worker.on('message', (message) => {
        console.log(message);
    });
} else {
    parentPort.postMessage(workerData);
}
