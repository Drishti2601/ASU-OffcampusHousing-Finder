// Import packages
const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');
const session = require('express-session');
require('dotenv').config();

const app = express();

// Database connection
const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
});

// Middleware
app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
}));

// Middleware to check if user is logged in
function isAuthenticated(req, res, next) {
    if (req.session.userId) {
        return next();
    }
    res.redirect('/login');
}

// Routes

// Home page
app.get('/', (req, res) => {
    res.render('index');
});

// Register page
app.get('/register', (req, res) => {
    res.render('register', { error: null, success: null });
});

// Handle registration
app.post('/register', async (req, res) => {
    const { firstname, lastname, email, phone, password, major, year } = req.body;
    
    try {
        // Hash password
        const hashedPassword = await bcrypt.hash(password, 10);
        
        // Insert into database
        await pool.query(
            `INSERT INTO Student (FirstName, LastName, Email, PhoneNumber, Password, Major, CurrentYear)
             VALUES ($1, $2, $3, $4, $5, $6, $7)`,
            [firstname, lastname, email, phone, hashedPassword, major, year]
        );
        
        res.render('register', { error: null, success: 'Registration successful! Please login.' });
    } catch (error) {
        console.error(error);
        res.render('register', { error: 'Email already exists or invalid data', success: null });
    }
});

// Login page
app.get('/login', (req, res) => {
    res.render('login', { error: null });
});

// Handle login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    
    try {
        const result = await pool.query(
            'SELECT StudentID, FirstName, Password FROM Student WHERE Email = $1',
            [email]
        );
        
        if (result.rows.length === 0) {
            return res.render('login', { error: 'Invalid email or password' });
        }
        
        const user = result.rows[0];
        const passwordMatch = await bcrypt.compare(password, user.password);
        
        if (!passwordMatch) {
            return res.render('login', { error: 'Invalid email or password' });
        }
        
        // Set session
        req.session.userId = user.studentid;
        req.session.userName = user.firstname;
        res.redirect('/search');
    } catch (error) {
        console.error(error);
        res.render('login', { error: 'Server error' });
    }
});

// Logout
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/');
});

// Search page
app.get('/search', isAuthenticated, (req, res) => {
    res.render('search', { 
        apartments: [], 
        userName: req.session.userName,
        searchValues: {
            max_rent: '',
            bedrooms: '',
            max_distance: ''
        },
        totalCount: 0,
        currentCount: 0
    });
});

// Handle search
app.post('/search', isAuthenticated, async (req, res) => {
    let { max_rent, bedrooms, max_distance } = req.body;
    
    // Set defaults for empty fields
    max_rent = max_rent && max_rent !== '' ? max_rent : 5000;
    bedrooms = bedrooms && bedrooms !== '' ? bedrooms : 0;
    max_distance = max_distance && max_distance !== '' ? max_distance : 10;
    
    // Store search criteria in session
    req.session.searchCriteria = {
        max_rent: max_rent,
        bedrooms: bedrooms,
        max_distance: max_distance
    };
    
    try {
        const result = await pool.query(
            `SELECT 
                p.PropertyName,
                p.DistanceFromCampus,
                au.UnitID,
                au.UnitNumber,
                au.Bedrooms,
                au.Bathrooms,
                au.MonthlyRent,
                au.SquareFeet
            FROM Property p
            JOIN ApartmentUnit au ON p.PropertyID = au.PropertyID
            WHERE au.MonthlyRent <= $1
              AND au.Bedrooms >= $2
              AND p.DistanceFromCampus <= $3
              AND au.IsAvailable = TRUE
            ORDER BY au.MonthlyRent, p.DistanceFromCampus
            LIMIT 20`,
            [max_rent, bedrooms, max_distance]
        );
        
        // Get total count
        const countResult = await pool.query(
            `SELECT COUNT(*) as total
            FROM Property p
            JOIN ApartmentUnit au ON p.PropertyID = au.PropertyID
            WHERE au.MonthlyRent <= $1
              AND au.Bedrooms >= $2
              AND p.DistanceFromCampus <= $3
              AND au.IsAvailable = TRUE`,
            [max_rent, bedrooms, max_distance]
        );
        
        res.render('search', { 
            apartments: result.rows, 
            userName: req.session.userName,
            searchValues: {
                max_rent: max_rent,
                bedrooms: bedrooms,
                max_distance: max_distance
            },
            totalCount: parseInt(countResult.rows[0].total),
            currentCount: result.rows.length
        });
    } catch (error) {
        console.error(error);
        res.render('search', { 
            apartments: [], 
            userName: req.session.userName,
            searchValues: {
                max_rent: '',
                bedrooms: '',
                max_distance: ''
            },
            totalCount: 0,
            currentCount: 0
        });
    }
});

// Load more apartments
app.post('/load-more', isAuthenticated, async (req, res) => {
    const { offset } = req.body;
    const criteria = req.session.searchCriteria;
    
    if (!criteria) {
        return res.json({ apartments: [], hasMore: false });
    }
    
    try {
        const result = await pool.query(
            `SELECT 
                p.PropertyName,
                p.DistanceFromCampus,
                au.UnitID,
                au.UnitNumber,
                au.Bedrooms,
                au.Bathrooms,
                au.MonthlyRent,
                au.SquareFeet
            FROM Property p
            JOIN ApartmentUnit au ON p.PropertyID = au.PropertyID
            WHERE au.MonthlyRent <= $1
              AND au.Bedrooms >= $2
              AND p.DistanceFromCampus <= $3
              AND au.IsAvailable = TRUE
            ORDER BY au.MonthlyRent, p.DistanceFromCampus
            LIMIT 20 OFFSET $4`,
            [criteria.max_rent, criteria.bedrooms, criteria.max_distance, offset]
        );
        
        res.json({ 
            apartments: result.rows,
            hasMore: result.rows.length === 20
        });
    } catch (error) {
        console.error(error);
        res.json({ apartments: [], hasMore: false });
    }
});

// Apartment details
app.get('/apartment/:id', isAuthenticated, async (req, res) => {
    try {
        const result = await pool.query(
            `SELECT 
                p.PropertyName,
                p.StreetAddress,
                p.City,
                p.State,
                p.DistanceFromCampus,
                p.BuildingAmenities,
                p.PetPolicy,
                au.UnitID,
                au.UnitNumber,
                au.Bedrooms,
                au.Bathrooms,
                au.SquareFeet,
                au.MonthlyRent,
                au.SecurityDeposit,
                au.LeaseLength,
                au.UnitAmenities,
                au.Utilities,
                au.AvailableDate
            FROM Property p
            JOIN ApartmentUnit au ON p.PropertyID = au.PropertyID
            WHERE au.UnitID = $1`,
            [req.params.id]
        );
        
        if (result.rows.length === 0) {
            return res.redirect('/search');
        }
        
        res.render('details', { apartment: result.rows[0], userName: req.session.userName });
    } catch (error) {
        console.error(error);
        res.redirect('/search');
    }
});

// Save to favorites
app.get('/save-favorite/:id', isAuthenticated, async (req, res) => {
    try {
        await pool.query(
            'INSERT INTO Favorite (StudentID, UnitID) VALUES ($1, $2)',
            [req.session.userId, req.params.id]
        );
        res.redirect('/favorites');
    } catch (error) {
        console.error(error);
        res.redirect('/favorites');
    }
});

// View favorites
app.get('/favorites', isAuthenticated, async (req, res) => {
    try {
        const result = await pool.query(
            `SELECT 
                p.PropertyName,
                au.UnitNumber,
                au.Bedrooms,
                au.MonthlyRent,
                p.DistanceFromCampus,
                f.FavoriteID,
                au.UnitID
            FROM Favorite f
            JOIN ApartmentUnit au ON f.UnitID = au.UnitID
            JOIN Property p ON au.PropertyID = p.PropertyID
            WHERE f.StudentID = $1
            ORDER BY f.DateSaved DESC`,
            [req.session.userId]
        );
        
        res.render('favorites', { favorites: result.rows, userName: req.session.userName });
    } catch (error) {
        console.error(error);
        res.render('favorites', { favorites: [], userName: req.session.userName });
    }
});

// Remove from favorites
app.get('/remove-favorite/:id', isAuthenticated, async (req, res) => {
    try {
        await pool.query(
            'DELETE FROM Favorite WHERE FavoriteID = $1 AND StudentID = $2',
            [req.params.id, req.session.userId]
        );
        res.redirect('/favorites');
    } catch (error) {
        console.error(error);
        res.redirect('/favorites');
    }
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});