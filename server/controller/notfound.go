package controller

import (
	"app/dto"
	"net/http"

	"github.com/gin-gonic/gin"
)

func NotFound(ctx *gin.Context) {
	ctx.JSON(http.StatusNotFound, dto.Response{
		Message: "Missing Route 🤔",
	})
}
