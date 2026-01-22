const { findModulesAsync } = require('expo-modules-autolinking');
const path = require('path');

async function check() {
    const root = '/Users/ed-00/Documents/expo-ferrostar';
    console.log('Searching in:', root);
    const modules = await findModulesAsync({
        projectRoot: root,
        platform: 'ios',
        searchPaths: [root],
        onlyProjectDeps: false,
    });
    console.log('Found modules:', Object.keys(modules));
    if (modules['expo-ferrostar']) {
        console.log('expo-ferrostar config:', JSON.stringify(modules['expo-ferrostar'].config, null, 2));
    } else {
        console.log('expo-ferrostar NOT FOUND');
    }
}

check();
