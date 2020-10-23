//go:generate protoc --go_out=user_service --go_opt=paths=source_relative --go-grpc_out=user_service --go-grpc_opt=paths=source_relative --proto_path ../proto/user_service ../proto/user_service/user.proto

package proto
