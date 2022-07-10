package controller

import (
	"app/dto"
	"app/middleware"
	"net/http"

	"github.com/gin-gonic/gin"
)

func Me(ctx *gin.Context) {
	user := middleware.GetUser(ctx)
	if user == nil {
		ctx.JSON(http.StatusForbidden, dto.Response{Message: "can't get any profile"})
		return
	}
	ctx.JSON(http.StatusOK, dto.Response{
		Success: true,
		Message: "get profile",
		Data:    user,
	})
}
