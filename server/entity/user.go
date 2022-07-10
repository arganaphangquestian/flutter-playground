package entity

type User struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"-"` // DONT THROW THIS FIELD INTO YOUR RESPONSE
}
