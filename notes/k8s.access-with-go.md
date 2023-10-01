---
id: ydsnzie81w789l15nmgmyfu
title: Access with Go
desc: ''
updated: 1696179136063
created: 1665660547676
---

```go
package main

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"log"
	"path/filepath"
	"strings"
	"time"

	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
	"k8s.io/utils/env"

	"github.com/go-resty/resty/v2"
	_ "k8s.io/client-go/plugin/pkg/client/auth"
)

// current k8s context is retrieved from user home directory kubeconfig
// check pod logs
// k --context xyz logs po/pod -c container | tail -n 10


var (
	writerPodName = "pod-name"
	podNamespace  = "default"
)

func main() {
	home := homedir.HomeDir()
	kubeconfig := filepath.Join(home, ".kube", "config")

	// use the current context in kubeconfig
	// kubectl config current-context
	config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
	if err != nil {
		panic(err.Error())
	}

	client := resty.New()

	for {
		podLogsSince := metav1.NewTime(time.Now().UTC())

		requestBody := fmt.Sprintf("..")

		resp, err := client.R().
			SetHeader("Content-Type", "application/json").
			SetBody(requestBody).
			SetAuthToken(env.GetString("INTERNAL_TOKEN", "")).
			Post("http://localhost:8080/abc")

		if err != nil {
			panic(fmt.Errorf("request to writer failed: %w", err))
		}

		if resp.StatusCode() != 204 {
			panic(fmt.Errorf("request to writer failed with http code: %d", resp.StatusCode()))
		}

		for {
			podLogs, err := getPodLogs(config, &podLogsSince)
			if err != nil {
				panic(fmt.Errorf("getting pod logs failed: %w", err))
			}

			if strings.Contains(podLogs, fmt.Sprintf("...:")) {
				// ....
			}

			//wait for 10s to check writer processing
			time.Sleep(time.Second * 10)
		}
	}
}

func getPodLogs(config *rest.Config, since *metav1.Time) (string, error) {
	podLogOpts := v1.PodLogOptions{
		Container: "container-name",
		SinceTime: since,
	}
	// create the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err.Error())
	}

	req := clientset.CoreV1().Pods(podNamespace).GetLogs(writerPodName, &podLogOpts)
	podLogs, err := req.Stream(context.Background())
	if err != nil {
		return "", fmt.Errorf("error in opening stream: %w", err)
	}
	defer podLogs.Close()

	buf := new(bytes.Buffer)
	_, err = io.Copy(buf, podLogs)
	if err != nil {
		return "", fmt.Errorf("error in copy information from podLogs to buf: %w", err)
	}
	str := buf.String()

	return str, nil
}

```