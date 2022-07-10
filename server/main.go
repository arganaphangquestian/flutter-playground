package main

import (
	"fmt"
	"log"

	"app/controller"
	"app/middleware"
	"app/repository"

	"github.com/gin-gonic/gin"
)

const (
	PORT = 8000
)

func init() {
	repository.InitData()
}

func main() {
	app := gin.New()
	auth, err := middleware.Middleware()
	if err != nil {
		log.Fatal("there is something wrong with your auth middleware")
	}
	app.NoRoute(controller.NotFound)
	// All User
	app.GET("/all", controller.All)
	// Register
	app.POST("/register", controller.Register)
	// Login
	app.POST("/login", auth.LoginHandler)
	// Logout
	app.POST("/logout", auth.LogoutHandler)
	// Refresh Token
	app.POST("/refresh-token", auth.RefreshHandler)
	// Protected Routes
	userGroup := app.Group("/user")
	userGroup.Use(auth.MiddlewareFunc())
	{
		userGroup.GET("/me", controller.Me)
	}
	// Run Server
	app.Run(fmt.Sprintf("0.0.0.0:%d", PORT))
}
