package data

import (
	"database/sql"
	"errors"
)

var (
	ErrRecordNotFound = errors.New("record not found")
	ErrEditConflict   = errors.New("edit conflict")
)

type Models struct {
	Movies      MovieModel
	Users       UserModel
	Tokens      TokenModel
	Permissions PermissionModel
}

// type Models struct {
// 	Movie interface {
// 		Insert(movie *Movie) error
// 		Get(id int64) (*Movie, error)
// 		Update(movie *Movie) error
// 		Delete(id int64) error
// 		GetAll(title string, genres []string, filters Filters) ([]*Movie, Metadata, error)
// 	}
// }

func NewModels(db *sql.DB) Models {
	return Models{
		Movies:      MovieModel{DB: db},
		Users:       UserModel{DB: db},
		Tokens:      TokenModel{DB: db},
		Permissions: PermissionModel{DB: db},
	}
}
