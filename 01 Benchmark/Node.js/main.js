const { Worker, isMainThread } = require('node:worker_threads');
if (isMainThread) {
    var args = process.argv.slice(2);
    const numThreads = args[0] || 1;

    console.log(`Starting ${numThreads} Threads in Node.js!`);
    for (let i = 0; i < numThreads; i++) new Worker(__filename);
} else {
    fibonacci(1000);
}

function fibonacci(n, memo = {}) {
    if (n <= 1) return n;
    if (memo[n]) return memo[n];

    memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo);
    return memo[n];
}
