package repository

import (
	"app/entity"

	nanoid "github.com/matoous/go-nanoid/v2"
	"golang.org/x/crypto/bcrypt"
)

var (
	DATABASE = []entity.User{}
)

func InitData() {

	id, _ := nanoid.New()
	hash, _ := bcrypt.GenerateFromPassword([]byte("password"), bcrypt.DefaultCost)
	DATABASE = append(DATABASE, entity.User{ID: id, Name: "John Doe", Email: "johndoe@mail.com", Password: string(hash)})
}
