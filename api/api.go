package api

import (
	"fmt"
	"net/http"
	"time"
)

func Get() error {
	c := &http.Client{
		Timeout: 5 * time.Second,
	}

	req, err := http.NewRequest("GET", "https://the-domain/content/181246090", nil)
	req.SetBasicAuth("foo", "bar")
	if err != nil {
		return err
	}

	resp, err := c.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	fmt.Printf("http resp: %s", resp.Status)
	// body, err := ioutil.ReadAll(resp.Body)
	return nil
}
