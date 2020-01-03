package tutorial

import "sync"

var tutorialTestPool = &sync.Pool{
	New: func() interface{} {
		return &Test{}
	},
}

func GetTest() *Test {
	return tutorialTestPool.Get().(*Test)
}

func PutTest(t *Test) {
	tutorialTestPool.Put(t)
}
