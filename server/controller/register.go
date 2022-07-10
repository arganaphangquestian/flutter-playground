package controller

import (
	"app/dto"
	"app/entity"
	"app/repository"
	"net/http"

	"github.com/gin-gonic/gin"
	nanoid "github.com/matoous/go-nanoid/v2"
	"golang.org/x/crypto/bcrypt"
)

func Register(ctx *gin.Context) {
	var register dto.Register
	if err := ctx.ShouldBind(&register); err != nil || register.Password != register.RePassword {
		ctx.JSON(http.StatusBadRequest, dto.Response{
			Message: "failed to register",
		})
		return
	}
	id, _ := nanoid.New()
	hash, _ := bcrypt.GenerateFromPassword([]byte(register.Password), bcrypt.DefaultCost)
	user := entity.User{ID: id, Name: register.Name, Email: register.Email, Password: string(hash)}
	repository.DATABASE = append(repository.DATABASE, user)
	ctx.JSON(http.StatusOK, dto.Response{
		Success: true,
		Message: "register successfully",
		Data:    user,
	})
}
