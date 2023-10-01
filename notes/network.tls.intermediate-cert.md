---
id: slyvzdq3i1ayu1pmgzizmoy
title: Intermediate Cert
desc: ''
updated: 1671439569826
created: 1671439564341
---

```go
package main

import (
	"crypto/tls"
	"fmt"
	"log"
	"net/http"
	"time"

	"filippo.io/intermediates"
)

func main() {
	tr := http.DefaultTransport.(*http.Transport).Clone()
	tr.TLSClientConfig = &tls.Config{
		// Set InsecureSkipVerify to skip the default validation we are
		// replacing. This will not disable VerifyConnection.
		InsecureSkipVerify: true,
		VerifyConnection:   intermediates.VerifyConnection,
	}

	c := &http.Client{Transport: tr, Timeout: 1 * time.Minute}
	r, err := c.Get("https://talentgarden.org/en/")
	if err != nil {
		log.Fatal(err)
	}
	defer r.Body.Close()
	fmt.Println(r.StatusCode)
}
```