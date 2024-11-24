const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const path = require('path');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const Razorpay = require('razorpay');
const crypto = require('crypto'); // Required for generating random receipt and verifying signature

const app = express();
const port = 3090;

const razorpayInstance = new Razorpay({
    key_id: 'rzp_test_EUId8Agf5IT88P',
    key_secret: 'jGi6D4M6OhipW8os5jBmD9H3'
});

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.use(cookieParser());
app.use(cors());

// MySQL connection setup
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Mouni@1729',
    database: 'martkart'
});

connection.connect(err => {
    if (err) {
        console.error('Error connecting to the database:', err);
        process.exit(1); // Exit if there's a connection error
    }
    console.log('Connected to the database');
});

// Serve the home.html file at the "/home" URL
app.get('/home', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'Homemain.html'));
});

// Serve the index.html file at the root URL
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

// Endpoint to handle user registration
app.post('/register', (req, res) => {
    const { username, password, phone_number } = req.body;

    // Hash the password before storing it in the database
    bcrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) {
            console.error('Error hashing password:', err);
            return res.json({ success: false, message: 'Error registering user' });
        }

        const query = 'INSERT INTO users (User_Name, password, Phone_Number) VALUES (?, ?, ?)';
        connection.query(query, [username, hashedPassword, phone_number], (err, result) => {
            if (err) {
                console.error('Database Error:', err);
                if (err.code === 'ER_DUP_ENTRY') {
                    return res.json({ success: false, message: 'Username already exists' });
                }
                return res.json({ success: false, message: 'Error registering user' });
            }
            res.json({ success: true, message: 'User registered successfully' });
        });
    });
});

// Endpoint to handle user login
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    const query = 'SELECT * FROM users WHERE User_Name = ?';
    connection.query(query, [username], (err, results) => {
        if (err) {
            console.error('Database Error:', err);
            return res.status(500).json({ message: 'Database error' });
        }

        if (results.length === 0) {
            console.log('No user found with that username');
            return res.status(401).json({ message: 'Invalid username or password' });
        }

        const user = results[0];

        bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err) {
                console.error('Error comparing passwords:', err);
                return res.status(500).json({ message: 'Error checking password' });
            }

            if (isMatch) {
                // Set user_id cookie
                res.cookie('user_id', user.User_ID, { maxAge: 24 * 60 * 60 * 1000 }); // Store user_id in a cookie

                // Insert login record into the Login table
                const loginQuery = 'INSERT INTO Login (User_ID) VALUES (?)';
                connection.query(loginQuery, [user.User_ID], (loginErr) => {
                    if (loginErr) {
                        console.error('Database Error (Login table):', loginErr);
                        return res.status(500).json({ message: 'Database error while logging login' });
                    }

                    res.json({ success: true, message: 'Login successful', role: user.role });
                });

            } else {
                res.status(401).json({ message: 'Invalid username or password' });
            }
        });
    });
});

// Endpoint to fetch products
app.get('/products', (req, res) => {
    const query = 'SELECT * FROM products';
    connection.query(query, (err, results) => {
        if (err) {
            console.error('Database Error:', err);
            return res.status(500).json({ message: 'Database error' });
        }
        res.json(results);
    });
});

// Endpoint to fetch product details along with images
app.get('/product/:id', (req, res) => {
    const productId = req.params.id;

    const productQuery = 'SELECT * FROM products WHERE Product_ID = ?';
    const imagesQuery = 'SELECT image_URL FROM product_images WHERE Product_ID = ?';

    connection.query(productQuery, [productId], (err, productResults) => {
        if (err) {
            return res.status(500).json({ error: 'Database error' });
        }

        if (productResults.length === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }

        connection.query(imagesQuery, [productId], (err, imageResults) => {
            if (err) {
                return res.status(500).json({ error: 'Database error' });
            }

            const product = productResults[0];
            product.images = imageResults.map(row => row.image_URL);

            res.json(product);
        });
    });
});

// Endpoint to save address
app.post('/save-address', (req, res) => {
    const { fullName, address_line, city, state, postal_code, country } = req.body;
    const LoginID = req.cookies.user_id; // Use the correct cookie name

    const query = 'INSERT INTO addresses (fullName, address_line, city, state, postal_code, country, Login_ID) VALUES (?, ?, ?, ?, ?, ?, ?)';
    connection.query(query, [fullName, address_line, city, state, postal_code, country, LoginID], (err, result) => {
        if (err) {
            console.error('Database Error:', err);
            return res.status(500).json({ message: 'Database error' });
        }
        res.json({ success: true, message: 'Address saved successfully' });
    });
});

// Endpoint to create Razorpay order
app.post('/create-order', async (req, res) => {
    const options = {
        amount: 10000, // amount in the smallest currency unit (paise)
        currency: 'INR',
        receipt: crypto.randomBytes(10).toString('hex'),
        payment_capture: 1 // auto capture
    };

    try {
        const order = await razorpayInstance.orders.create(options);
        res.json(order);
    } catch (error) {
        res.status(500).send(error);
    }
});

// Endpoint to process order
app.post('/process_order', (req, res) => {
    const { paymentMethod, amount } = req.body;
    const userId = req.cookies.user_id; // Get userId from the cookie

    if (!userId) {
        return res.status(401).json({ message: 'User not authenticated' });
    }

    const status = 'Pending';
    const createdAt = new Date();

    const order = { Login_ID: userId, status: status, Total_Price: amount, created_at: createdAt, Payment_Method: paymentMethod };
    const sql = 'INSERT INTO orders SET ?';
    connection.query(sql, order, (err, result) => {
        if (err) {
            return res.send('Error occurred: ' + err.message);
        }
        const orderId = result.insertId;
        res.redirect(`/order_confirmation?order_id=${orderId}`);
    });
});

// Order confirmation
app.get('/order_confirmation', (req, res) => {
    const orderId = req.query.order_id;
    const sql = 'SELECT * FROM orders WHERE Order_ID = ?';
    connection.query(sql, [orderId], (err, results) => {
        if (err) {
            return res.send('Error occurred: ' + err.message);
        }
        if (results.length > 0) {
            const order = results[0];
            res.send(`
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Order Confirmation</title>
                    <link rel="stylesheet" href="paymentcss.css">
                </head>
                <body>
                    <div class="container">
                        <h1>Order Placed Successfully</h1>
                        <p>Order ID: ${order.Order_ID}</p>
                        <p>Payment Method: ${order.Payment_Method}</p>
                        <p>Order Status: ${order.status}</p>
                        <p>Total: ${order.Total_Price}</p>
                        <p>Created At: ${order.created_at}</p>
                    </div>
                </body>
                </html>
            `);
        } else {
            res.send('Order not found.');
        }
    });
});
// Endpoint to create Razorpay order for UPI payments
app.post('/create-order', async (req, res) => {
    const { amount } = req.body;

    const options = {
        amount: amount * 100, // Convert to smallest currency unit (paise)
        currency: 'INR',
        receipt: crypto.randomBytes(10).toString('hex'),
        payment_capture: 1 // Auto capture
    };

    try {
        const order = await razorpayInstance.orders.create(options);
        res.json(order);
    } catch (error) {
        console.error('Razorpay Order Creation Error:', error); // Log the error
        res.status(500).json({ success: false, message: 'Failed to initiate payment. Please try again.' });
    }
});

// Confirm Order and Store in Database for COD
app.post('/confirm-order', (req, res) => {
    const { orderID, totalPrice, paymentMethod, addressID, cartItems } = req.body;
    const userID = req.cookies.user_id; // Get user_id from cookies

    if (!userID) {
        return res.status(401).json({ success: false, message: 'User not authenticated' });
    }

    // Insert into orders table
    const insertOrderQuery = `
        INSERT INTO orders (Order_ID, Login_ID, created_at, Total_Price, Shipping_Address, Payment_Method)
        VALUES (?, ?, NOW(), ?, ?, ?)
    `;

    connection.query(insertOrderQuery, [orderID, userID, totalPrice, addressID, paymentMethod], (err, orderResult) => {
        if (err) {
            console.error('Database Error (orders):', err); // Log the error
            return res.status(500).json({ success: false, message: 'Failed to confirm order. Please try again.' });
        }

        // Insert each cart item into order_item table
        const insertOrderItemQuery = `
            INSERT INTO order_item (Order_ID, Product_ID, Quantity, Unit_Price)
            VALUES ?
        `;

        const orderItems = cartItems.map(item => [orderID, item.Product_ID, item.Quantity, item.Unit_Price]);
        connection.query(insertOrderItemQuery, [orderItems], (err, orderItemResult) => {
            if (err) {
                console.error('Database Error (order_item):', err); // Log the error
                return res.status(500).json({ success: false, message: 'Failed to confirm order. Please try again.' });
            }

            res.json({ success: true, message: 'Order confirmed successfully' });
        });
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on port http://localhost:${port}`);
});
