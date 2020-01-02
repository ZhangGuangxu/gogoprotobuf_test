package main

import (
	"log"
	"sync"

	"github.com/ZhangGuangxu/gogoprotobuf_test/internal/gogoslick_out/tutorial"

	proto "github.com/gogo/protobuf/proto"
)

var tutorialTestPool = &sync.Pool{
	New: func() interface{} {
		return &tutorial.Test{}
	},
}

func main() {
	test := tutorialTestPool.Get().(*tutorial.Test)
	test.Label = "hello"
	test.Type = tutorial.FOO_value["X"]
	test.Reps = []int64{1, 2, 3}
	// test := &tutorial.Test{
	// 	Label: "hello",
	// 	Type:  tutorial.FOO_value["X"],
	// 	Reps:  []int64{1, 2, 3},
	// }
	data, err := proto.Marshal(test)
	if err != nil {
		log.Fatal("marshaling error: ", err)
	}
	log.Println("data: ", data)

	newTest := tutorialTestPool.Get().(*tutorial.Test)
	//newTest := &tutorial.Test{}
	err = proto.Unmarshal(data, newTest)
	if err != nil {
		log.Fatal("unmarshaling error: ", err)
	}
	log.Println("newTest object: ", newTest)

	// Now test and newTest contain the same data.
	if test.GetLabel() != newTest.GetLabel() {
		log.Fatalf("data mismatch %q != %q", test.GetLabel(), newTest.GetLabel())
	}

	tutorialTestPool.Put(test)
	tutorialTestPool.Put(newTest)
	// etc.
}
