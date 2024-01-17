for (let i = 0; i < 100; i++)
    new Worker(new URL('./worker.js', import.meta.url).href, {
        type: 'module',
    });
