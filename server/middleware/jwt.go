package middleware

import (
	"app/dto"
	"app/entity"
	"app/repository"
	"time"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

const (
	REALM  = `"authentication application"`
	SECRET = "789023jkdew89012mn!2pefw012lmas"
)

func Middleware() (*jwt.GinJWTMiddleware, error) {
	identity := "data"
	middleware, err := jwt.New(&jwt.GinJWTMiddleware{
		Realm:       REALM,
		IdentityKey: identity,
		Key:         []byte(SECRET),
		Timeout:     time.Minute,             // SET TO 1 Minute only
		MaxRefresh:  time.Hour * 24 * 30 * 3, // FOR REFRESH TOKEN (30 Days * 3), DEFAULT 0 WHICH MEAN THIS JWT NOT REFRESHABLE
		TokenLookup: "header: Authorization, cookie: jwt",
		TimeFunc:    time.Now,
		Authenticator: func(ctx *gin.Context) (interface{}, error) {
			var login dto.Login
			if err := ctx.ShouldBind(&login); err != nil {
				return nil, jwt.ErrMissingLoginValues
			}
			for _, v := range repository.DATABASE {
				v := v
				err := bcrypt.CompareHashAndPassword([]byte(v.Password), []byte(login.Password))
				if login.Email == v.Email && err == nil {
					return &v, nil
				}
			}
			return nil, jwt.ErrFailedAuthentication
		},
		Authorizator: func(data interface{}, c *gin.Context) bool {
			return true // There is no authorization in this app, other mean there is role based access controll (RBAC) in this app
		},
		PayloadFunc: func(data interface{}) jwt.MapClaims {
			if v, ok := data.(*entity.User); ok {
				return jwt.MapClaims{
					identity: v,
				}
			}
			return jwt.MapClaims{}
		},
		Unauthorized: func(ctx *gin.Context, code int, message string) {
			ctx.JSON(code, dto.Response{
				Message: message,
			})
			return
		},
		LoginResponse: func(ctx *gin.Context, code int, token string, time time.Time) {
			ctx.JSON(code, dto.Response{
				Success: true,
				Message: "login successfully",
				Data: map[string]interface{}{
					"expired_at": time,
					"token":      token,
				},
			})
			return
		},
		LogoutResponse: func(ctx *gin.Context, code int) {
			ctx.JSON(code, dto.Response{
				Success: true,
				Message: "logout successfully",
			})
		},
		RefreshResponse: func(ctx *gin.Context, code int, token string, time time.Time) {
			ctx.JSON(code, dto.Response{
				Success: true,
				Message: "refresh token successfully",
				Data: map[string]interface{}{
					"expired_at": time,
					"token":      token,
				},
			})
			return
		},
		IdentityHandler: func(ctx *gin.Context) interface{} {
			claims := jwt.ExtractClaims(ctx)
			user := claims[identity].(map[string]interface{})
			return &entity.User{
				ID:    user["id"].(string),
				Name:  user["name"].(string),
				Email: user["email"].(string),
			}
		},
	})
	return middleware, err
}

func GetUser(ctx *gin.Context) *entity.User {
	user, ok := ctx.Get("data")
	if !ok {
		return nil
	}
	return user.(*entity.User)
}
