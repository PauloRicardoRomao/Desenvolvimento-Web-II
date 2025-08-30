const express = require("express");
const multer = require("multer");
const path = require("path");
const router = express.Router();
const produtoController = require("../controllers/produtoController");


conststorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "uploads/");
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage });



router.get("/", produtoController.listar);
router.post("/add", produtoController.criar);

router.get("/delete/:id", produtoController.remover);


module.exports = router;
