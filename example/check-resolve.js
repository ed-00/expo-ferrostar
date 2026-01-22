const path = require('path');
try {
    const pkgPath = require.resolve('expo-ferrostar/package.json', { paths: [process.cwd()] });
    console.log('Resolved to:', pkgPath);
    const pkg = require(pkgPath);
    console.log('Keywords:', pkg.keywords);
} catch (e) {
    console.error('Resolution failed:', e.message);
}
