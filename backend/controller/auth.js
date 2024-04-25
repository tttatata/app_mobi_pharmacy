const express = require("express");
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middleware/authmobille");

const Product = require("../model/product");
const Order = require("../model/order");

// SIGN UP
authRouter.post("/signup", async (req, res) => {
    try {
        const { name, email, phone, password } = req.body;

        const existingUser = await User.findOne({ email });
        const existingUserphone = await User.findOne({ phone });
        if (existingUser) {
            return res
                .status(400)
                .json({ msg: "User with same email already exists!" });
        }
        if (existingUserphone) {
            return res
                .status(400)
                .json({ msg: "User with same ephone already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            email,
            phone,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
///signin
//Excercise
authRouter.post("/signin", async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res
                .status(400)
                .json({ msg: "Roongx!" });
        }
        const user = await User.findOne({ email }).select("+password");
        if (!user) {
            return res
                .status(400)
                .json({ msg: "User with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password." });
        }

        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        console.log(token);
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
authRouter.delete("/remove-from-cart/:id", auth, async (req, res) => {
    try {
        const { id } = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                if (user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1);
                } else {
                    user.cart[i].quantity -= 1;
                }
            }
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
authRouter.post("/add-to-cart", auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        if (!user.cart) {
            user.cart = []; // Khởi tạo giỏ hàng nếu nó không tồn tại
        }
        if (user.cart.length == 0) {
            user.cart.push({ product, quantity: 1 });
        } else {
            let isProductFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true;
                }
            }

            if (isProductFound) {
                let producttt = user.cart.find((productt) =>
                    productt.product._id.equals(product._id)
                );
                producttt.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
authRouter.post("/add-address", auth, async (req, res) => {
    try {
        // Tìm người dùng bằng ID từ JWT
        let user = await User.findById(req.user);
        console.log(user);
        console.log(req.body);

        // Thêm địa chỉ mới vào mảng addresses
        const newAddress = {
            country: req.body.country,
            city: req.body.city,
            address1: req.body.address1,
            address2: req.body.address2,
            zipCode: req.body.zipCode,
            addressType: req.body.addressType
        };
        console.log(newAddress);
        const fields = ['country', 'city', 'address1', 'zipCode', 'addressType'];
        const isComplete = fields.every(field => newAddress[field]);

        if (!isComplete) {
            return res.status(400).json({ message: 'Vui lòng nhập đầy đủ thông tin địa chỉ.' });
        }
        // Kiểm tra nếu mảng addresses không tồn tại, khởi tạo nó
        if (!user.addresses) {
            user.addresses = [];
        }

        // Kiểm tra xem địa chỉ với kiểu đã tồn tại hay chưa
        const existingAddress = user.addresses.find(address => {
            return address && address.addressType === newAddress.addressType;
        });
        if (existingAddress) {

            return res.status(400).json({ message: `Địa chỉ với kiểu đã tồn tại.` });
        }


        // Thêm địa chỉ mới vào mảng
        user.addresses.push(newAddress);

        // Lưu người dùng
        user = await user.save();

        // Phản hồi với thông tin người dùng đã cập nhật
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.post("/update-address", auth, async (req, res) => {
    try {
        // Tìm người dùng bằng ID từ JWT
        let user = await User.findById(req.user);

        // Lấy thông tin địa chỉ cần cập nhật từ req.body
        const { addressId, country, city, address1, address2, zipCode, addressType } = req.body;

        // Kiểm tra xem địa chỉ cần cập nhật có tồn tại không
        const addressIndex = user.addresses.findIndex(address => address._id.toString() === addressId);
        if (addressIndex === -1) {
            return res.status(404).json({ message: 'Địa chỉ không tồn tại.' });
        }

        // Cập nhật thông tin địa chỉ
        const updatedAddress = {
            country,
            city,
            address1,
            address2,
            zipCode,
            addressType
        };

        // Kiểm tra thông tin đầy đủ
        const fields = ['country', 'city', 'address1', 'zipCode', 'addressType'];
        const isComplete = fields.every(field => updatedAddress[field]);
        if (!isComplete) {
            return res.status(400).json({ message: 'Vui lòng nhập đầy đủ thông tin địa chỉ.' });
        }

        // Cập nhật địa chỉ trong mảng addresses
        user.addresses[addressIndex] = updatedAddress;

        // Lưu người dùng
        user = await user.save();

        // Phản hồi với thông tin người dùng đã cập nhật
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
authRouter.post("/update-user", auth, async (req, res) => {
    try {
        // Tìm người dùng bằng ID từ JWT
        let user = await User.findById(req.user.id);

        // Lấy thông tin cần cập nhật từ req.body
        const { name, password, phoneNumber, avatar } = req.body;

        // Cập nhật thông tin người dùng
        user.name = name || user.name;
        user.password = password || user.password;
        user.phoneNumber = phoneNumber || user.phoneNumber;

        user.avatar = avatar || user.avatar;


        // Kiểm tra thông tin đầy đủ
        const fields = ['name', 'password', 'phoneNumber', 'avatar'];
        const isComplete = fields.every(field => user[field]);
        if (!isComplete) {
            return res.status(400).json({ message: 'Vui lòng nhập đầy đủ thông tin người dùng.' });
        }

        // Lưu người dùng
        user = await user.save();

        // Phản hồi với thông tin người dùng đã cập nhật
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.post("/create-order", auth, async (req, res) => {
    try {
        // Tìm người dùng bằng ID từ JWT
        let user = await User.findById(req.user);
        // console.log(user)
        const { cart, shippingAddress, totalPrice, paymentInfo } = req.body;
        // console.log(req.body);
        //   group cart items by shopId
        const shopItemsMap = new Map();

        for (const item of cart) {
            const shopId = item.shopId;
            if (!shopItemsMap.has(shopId)) {
                shopItemsMap.set(shopId, []);
            }
            shopItemsMap.get(shopId).push(item);
        }

        const orders = [];
        for (const [shopId, items] of shopItemsMap) { // Sử dụng vòng lặp để tạo nhiều đơn hàng dựa trên shopId
            const order = await Order.create({
                cart: items,
                shippingAddress,
                user: user, // Sử dụng _id của người dùng
                totalPrice, // Tính toán tổng giá cho từng đơn hàng, nếu cần
                paymentInfo,
            });
            orders.push(order);
        }
        console.log("Created orders:", orders);
        res.status(201).json({
            success: true,
            orders,
        });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});
authRouter.post(
    "/create-order", auth, async (req, res) => {
        try {
            const { cart, shippingAddress, user, totalPrice, paymentInfo } = req.body;

            //   group cart items by shopId
            const shopItemsMap = new Map();

            for (const item of cart) {
                const shopId = item.shopId;
                if (!shopItemsMap.has(shopId)) {
                    shopItemsMap.set(shopId, []);
                }
                shopItemsMap.get(shopId).push(item);
            }

            // create an order for each shop
            const orders = [];

            for (const [shopId, items] of shopItemsMap) {
                const order = await Order.create({
                    cart: items,
                    shippingAddress,
                    user,
                    totalPrice,
                    paymentInfo,
                });
                orders.push(order);
            }

            // res.json({

            //     orders,
            // });
        } catch (error) {
            return next(new ErrorHandler(error.message, 500));
        }
    })


module.exports = authRouter;