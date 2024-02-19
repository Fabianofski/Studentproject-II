var args = Bun.argv.slice(2);
const numThreads = args[0] || 1;
console.log(`Starting ${numThreads} Threads in Bun!`);

for (let i = 0; i < numThreads; i++)
    new Worker(new URL('./worker.js', import.meta.url).href);
