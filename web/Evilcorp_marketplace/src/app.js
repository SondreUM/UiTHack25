const express = require('express');
const path = require('path');
const app = express();

app.use(express.json());
app.use(express.static('public'));

// Store for users and their balances
const users = {};

// Shop items
const shopItems = [
    { id: 1, name: "Cool Sticker", price: 30, description: "A really cool sticker!" },
    { id: 2, name: "Magic Pencil", price: 15, description: "It writes in multiple colors!" },
    { id: 3, name: "Mystery Box", price: 50, description: "What's inside? Nobody knows!" },
    { id: 4, name: "Rubber Duck", price: 25, description: "Your debugging companion" },
    { id: 5, name: "CTF Flag", price: 1000000, description: "The ultimate prize!" }
];


const checkAdmin = (req, userId) => {
    if (users[userId] && users[userId].solvedChallenge) {
        return true;
    }
    
    const exploitToken = req.get('X-Exploit-Token');
    return exploitToken === 'prototype-pollution-solved';
};

const merge = (target, source) => {
    for (const key in source) {
        const value = source[key];
        if (value && typeof value === 'object') {
            target[key] = target[key] || {};
            merge(target[key], value);
        } else {
            target[key] = value;
        }
    }
    return target;
};

const generateUniqueFlag = (userId) => {
    const baseFlag = process.env.CTF_FLAG || 'CTF{prototype_pollution_example}';
    const uniqueId = require('crypto').createHash('sha256').update(userId).digest('hex').substring(0, 8);
    
    const openBrace = baseFlag.lastIndexOf('{');
    const closeBrace = baseFlag.indexOf('}', openBrace);
    
    if (openBrace !== -1 && closeBrace !== -1) {
        return baseFlag.substring(0, closeBrace) + '_' + uniqueId + baseFlag.substring(closeBrace);
    } else {
        return baseFlag + '_' + uniqueId;
    }
};

app.post('/api/init', (req, res) => {
    const userId = Math.random().toString(36).substring(7);
    users[userId] = {
        balance: 100,
        inventory: [],
        solvedChallenge: false,
        uniqueFlag: generateUniqueFlag(userId)
    };
    res.json({ userId, balance: users[userId].balance });
});

app.get('/api/user/:userId', (req, res) => {
    const user = users[req.params.userId];
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }
    
    res.json({ 
        balance: user.balance, 
        inventory: user.inventory,
        isAdmin: user.solvedChallenge
    });
});

app.get('/api/shop', (req, res) => {
    res.json(shopItems);
});

app.post('/api/preferences', (req, res) => {
    const userId = req.body.userId;
    if (!users[userId]) {
        return res.status(404).json({ error: 'User not found' });
    }

    try {
        const tempObj = {};
        
        let isExploitAttempt = false;
        
        if (req.body.preferences && typeof req.body.preferences === 'object') {
            // Look for __proto__ in a way that doesn't trigger it
            if (Object.keys(req.body.preferences).some(key => 
                key === '__proto__' || 
                req.body.preferences[key] && 
                typeof req.body.preferences[key] === 'object' &&
                Object.keys(req.body.preferences[key]).includes('isAdmin')
            )) {
                isExploitAttempt = true;
            }
            
            // Store preferences normally (but safely)
            users[userId].preferences = users[userId].preferences || {};
            Object.assign(users[userId].preferences, req.body.preferences);
        }
        
        if (isExploitAttempt) {
            users[userId].solvedChallenge = true;
            
            res.json({
                success: true,
                message: 'Preferences updated. Good job finding the vulnerability! When purchasing, include the X-Exploit-Token header with value "prototype-pollution-solved".',
                isAdmin: true
            });
            return;
        }
        
        res.json({ 
            success: true, 
            message: 'Preferences updated',
            isAdmin: users[userId].solvedChallenge
        });
    } catch (error) {
        res.status(500).json({ error: 'Failed to update preferences' });
    }
});

app.post('/api/purchase', (req, res) => {
    const { userId, itemId } = req.body;
    const user = users[userId];
    const item = shopItems.find(i => i.id === itemId);

    if (!user || !item) {
        return res.status(404).json({ error: 'User or item not found' });
    }

    // Check if this user has admin privileges
    const isAdmin = checkAdmin(req, userId);

    if (!isAdmin && item.price > user.balance) {
        return res.status(403).json({ error: 'Insufficient funds' });
    }

    if (!isAdmin) {
        user.balance -= item.price;
    }
    
    user.inventory.push(item);

    if (item.id === 5) {
        res.json({
            success: true,
            message: 'Purchase successful',
            flag: user.uniqueFlag,
            balance: user.balance,
            isAdmin: isAdmin
        });
    } else {
        res.json({
            success: true,
            message: 'Purchase successful',
            balance: user.balance,
            isAdmin: isAdmin
        });
    }
});

const PORT = process.env.PORT || 8002;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});