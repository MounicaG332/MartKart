const express = require('express');
const router = express.Router();
const paymentController = require('../controllers/paymentController');

router.get('/product', paymentController.renderProductPage);
router.post('/createOrder', paymentController.createOrder);

module.exports = router;
