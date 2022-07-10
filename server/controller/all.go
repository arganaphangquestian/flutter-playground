package controller

import (
	"app/dto"
	"app/repository"
	"net/http"

	"github.com/gin-gonic/gin"
)

func All(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, dto.Response{
		Success: true,
		Message: "get all user data",
		Data:    repository.DATABASE,
	})
}
