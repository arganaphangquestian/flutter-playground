package dto

type Register struct {
	Name       string `form:"name" json:"name" binding:"required"`
	Email      string `form:"email" json:"email" binding:"required"`
	Password   string `form:"password" json:"password" binding:"required"`
	RePassword string `form:"repassword" json:"repassword" binding:"required"`
}
