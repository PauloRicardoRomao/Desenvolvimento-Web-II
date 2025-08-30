const express = require("express");
const multer = require("multer");
const path = require("path");
const router = express.Router();
const produtoController = require("../controllers/produtoController");


const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/"); // cria a pasta "uploads" na raiz do projeto
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "-" + file.originalname);
  }
});

const upload = multer({ storage });



router.get("/", produtoController.listar);
router.post("/add", upload.single("imagem"), produtoController.criar);

router.get("/delete/:id", produtoController.remover);


module.exports = router;
