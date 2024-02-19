const numThreads = Deno.args[0] || 1;

console.log(`Starting ${numThreads} Threads in Deno!`);
for (let i = 0; i < numThreads; i++)
    new Worker(new URL('./worker.js', import.meta.url).href, {
        type: 'module',
    });
