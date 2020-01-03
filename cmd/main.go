package main

import (
	"github.com/ZhangGuangxu/gogoprotobuf_test/internal/gogoslick_out/tutorial"
	"log"

	proto "github.com/gogo/protobuf/proto"
)

func main() {
	test := tutorial.GetTest()
	test.Reset()
	test.Label = "hello"
	test.Type = tutorial.FOO_value["X"]
	test.Reps = []int64{1, 2, 3}
	data, err := proto.Marshal(test)
	if err != nil {
		log.Fatal("marshal error: ", err)
	}
	log.Println("data: ", data)

	newTest := tutorial.GetTest()
	newTest.Reset()
	err = proto.Unmarshal(data, newTest)
	if err != nil {
		log.Fatal("unmarshal error: ", err)
	}
	log.Println("newTest object: ", newTest)

	// Now test and newTest contain the same data.
	if test.GetLabel() != newTest.GetLabel() {
		log.Fatalf("data mismatch %q != %q", test.GetLabel(), newTest.GetLabel())
	}

	tutorial.PutTest(test)
	tutorial.PutTest(newTest)
	// etc.
}
