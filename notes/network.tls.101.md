---
id: zwofsxhobba61yxnbczl47f
title: '101'
desc: TLS presentation materials
updated: 1696178945268
created: 1661594067015
---

# Presentation

## TLS 101

- it will be actual basics of TLS, **mix of thoery and pratice**
- it's 101 for two reasons, one is we have 60+ minutes and 2nd by no means I consider myself an **expert** on **crypthgraphy, TLS, HTTP and PKI** and these are founding blocks for topics we are covering today

## My take on TLS

- talk about TLS **protocol history** and why it's relevant
- I think PKI context is important in TLS context 
- Theoretical and practical showcase how TLS 1.2 works, specifically focus is on TLS 1.2
- I will talk about possible problems that may cause TLS to "malfunction"
- and will present some TLS related off-topics
- TLS 1.3 is the newest version of protocol, so I will try to highlight what distigueshes it from v1.2.

## TLS - why bother

- TLS is de facto an internet standard to secure the communication between servers and clients on the internet
- It was designed to allows client/server applications to establish communication channel that ensures:
  - private communication (prevent eavesdropping),  
  - authentication of at least one party
  - message tampering
  - replay attacks (you don't know the content but you reply it)

### Demo
 - go to Chrome https://letmegooglethat.com/ the most basic usage of TLS, 
   - click on padlock icon
   - F12 quick tour

## TLS - OSI (Open Systems Interconnection) layers

- TLS fits somewhere between Session (as TLS is a stateful Protocol as we can see later) and Presentation layer (provides encryption support)
  - TLS is that it is application protocol independent. You can relay on TLS and have your own protocol on top of it and I think some companies do it. 
  - this is possible as TLS was designed to be application layer independent
- Higher-level protocols can layer on top of the TLS protocol transparently. 
  - TLS is and Internet standard For example that of web servers, FTP servers, and Email servers. 
  - Now I know HTTPS name is a lie :), it's not even protocol name, it's two protocols combined HTTP over TLS or SSL in the past.

## TLS history - versions

 - Few honorable mentions on TLS history, as I always feel safe when I know why things are named the way they are
 - All started witl SSL 1.0 in company called Netscape, company behind famous browser Netscape Navigator, it never made to Production.
 - But SSL 2.0 did and SSL 3.0 also did. 
 - TLS 1.0 (Microsoft refused to use SSL name to just troll Netscape through IETF - Internet Engineering Task Force that published RFC), it was during browser wars IE vs Netscape

- Deprecating SSL 3.0 - RFC 7568
- All TLS versions below 1.2 have security issues
  - but sometime client or server are required to use it to maintain backward compatiblity on the web.

## PKI - Authentication

- I'm sure PKI has plenty of scenarios to apply, but TLS uses it main for Authentication
  - Confirms identity of the server
  - of if both client and server identity must be confirmed then we are talking mTLS
- CA must issue certificate to Server
- Client must trust CA 

## Demo mTLS 

Server can request client authentication if mutual authentication is configured. It’s called mTLS. It’s also supported by Linkerd when pods are communicating with each other through the sidecar proxy.


- linerkd service setup with CA root cert and key
- https://excalidraw.com/ - draw source-api talking to content-api through service mesh container
- in linkerd there is a component that issues certificates for pods when they are brought to live
- mTLS ensures this way we have secure (encrypted) and identity confirmed communication between pods

- show that traffic skips service mesh for selected ports
- show linkerd components in linkerd namespace

## Demo certificate chain

- go to https://api.example.com/ and open F12 browser (Chrome Dev Tools)
  - show cert chain
- cert testing websites
  -  go to https://www.digicert.com/help/ and provide api.example.com
     -  show expiry dates
  - show more detailed analysys
    - https://www.ssllabs.com/ssltest/analyze.html?d=api.example.com&latest 
- openssl to show certs
```bash
openssl help #look how complex this tool is
sudo openssl s_client -connect api.example.com:443 -tls1_2
```
    - show certs in the output

- go to /etc/ssl/cert to confirm that Ubuntu installation has let's encrypt CA installed
```bash
ls -l |  grep -i X1
openssl x509 -in ISRG_Root_X1.pem -nocert -text -subject
openssl x509 -in ISRG_Root_X1.pem -nocert -text -subject | tail -n 1
```
  -  On Windows issuer CA cert must be installed in Trusted Certificates Authorities 

## X.509 certificates formats

1. On the top left corner, an X.509 certificate is written using the ASN.1 notation. 
2. It is then transformed into bytes that can be signed via the DER encoding.
3. As this is not text that can easily be copied around and be recognized by humans, it is base64 encoded. 
   1. The last touch wraps the base64 data with some handy contextual information using the PEM format.
   2. If you decode the base64 content surrounded by the BEGIN CERTIFICATE and END CERTIFICATE, you end up with a Distinguished Encoding Rules (DER) encoded certificate.

### Binary (DER) certificate
- Contains an X.509 certificate in its raw form, using DER ASN.1 encoding.
	
### ASCII (PEM) certificate(s)
- Contains a base64-encoded DER certificate, with -----BEGIN CERTIFICATE----- used as the header and -----END CERTIFICATE----- as the footer
  
### PKCS #12 (PFX) key and certificate(s)
- A complex format that can store and protect a server key along with an entire certificate chain. It’s commonly seen with .p12 and .pfx extensions. This format is commonly used in Microsoft products, but is also used for client certificates
PKCS #8 key

## Demo certificate details

### Export api.example.com cert (PEM) + R3 intermediate cert (DER)
  - open Chrome and go to https://api.example.com
  - Press F12 and click 'View Certificate' on Security tab
  - Go to 'Details' tab
  - Select api.example.com cert and export as PEM (Base64 encoded ASCII, single cert)
  - Select R2 and export as DER
 
### View their metadata

```bash
openssl x509 -text -in api.example.com.pem -noout
openssl x509 -in R3 -text -noout
```

- The Basic Constraints extension is used to mark certificates as belonging to a CA, giving them the ability to sign other certificates.
- The Key Usage (KU) and Extended Key Usage (EKU) extensions restrict what a certificate can be used for. 
- The Subject Alternative Name extension is used to list all the hostnames for which the certificate is valid.
- The Subject Key Identifier and Authority Key Identifier extensions establish unique subject and authority key identifiers, respectively. The value specified in the Authority Key Identifier extension of a certificate must match the value specified in the Subject Key Identifier extension in the issuing certificate. 

### Convertsion between PEM (ASCII and base64)  and DER (binary)
```bash
openssl x509 -inform DER -in R3 -outform PEM -out R3.pem
openssl x509 -in R3.pem -text -noout
```

## How  basic TLS 1.2 handshake works

### TLS handshake phases

- Negotiation of the protocol version and selecting the set of algo for key exchange.
- Authentication - confirms at least one party identity
- Key exchange - get keys for encrypting the traffic and establish session
- Session resumption - avoid redoing handshake
- Once a handshake has taken place, and symmetric keys have been derived, both the client and the server can send each other encrypted application data. 
  - Also TLS ensures that such messages cannot be replayed nor reordered.

### TLS Handshake

Source: https://www.comparitech.com/blog/information-security/tls-encryption/

1. The **master secret** is the base for deriving the keys used to both encrypt and check the integrity of data transmitted between the two parties.
2. The **Client Hello message** is met with a **Server Hello message**. This response contains the session ID, protocol version, cipher suite and compression (if any is being used) that the server selected from the client’s list. It also includes a different random number.
3. It depends on the **cipher suite** that has been selected, but the server will generally follow this by sending a Certificate message for authentication. This validates its identity and contains its public key.
4. If **ephemeral Diffie-Hellman** or **anonymous Diffie-Hellman** key exchanges are being used, then this is followed by a Server Key Exchange message. Other key exchange methods skip this part. When the server has finished with its side of the negotiation, it sends a Server Hello Done message.
5. Now it’s the client’s turn again. Depending on the chosen cipher suite, it will send a **Client Key Exchange message**. This can contain a public key or a premaster secret, which is encrypted with the **server’s public key**.
6. Both parties then use the **random numbers** and the **premaster secret** to come up with a **master secret**. **Keys** are derived from the **master secret**, which are then used to authenticate and encrypt the communications.
7. The client then sends a **Change Cipher Spec message**. This tells the server that the following messages will now be **authenticated and encrypted** (although sometimes encryption may not be used).
8. The client then follows this up with a **Finished message**, which is encrypted and also contains a **Message Authentication Code (MAC)** for authentication. The server decrypts this message and verifies the MAC. If any of these processes fail, then the connection should be rejected.
9. Now it’s the server’s turn to send a **Change Cipher Spec message**, as well as a **Finished message** with the same content as above. The client then also tries to decrypt and verify the contents. If this is all completed successfully, the handshake is finished. At this point, the application protocol is established. Data can then be exchanged securely in the same way as the Finished message from above, with authentication and optional encryption.
10. Once a secure connection has been established by the **TLS handshake**, the application protocol is used to protect the transmitted data. It can be configured to use a wide range of algorithms to suit different scenarios.

### TLS layers

Source: https://www.ietf.org/rfc/rfc2246.txt

The protocol is  composed of two layers: 
- the TLS Record Protocol 
- and the TLS Handshake Protocol

The TLS Record Protocol provides connection security that has two
basic properties: 
-  The connection is private.  Symmetric cryptography is used for    data encryption (e.g., AES [AES], RC4 [SCH], etc.).  The keys for this symmetric encryption are generated uniquely for each  connection and are based on a secret negotiated by another    protocol (such as the TLS Handshake Protocol).
- The connection is reliable.  Message transport includes a message integrity check using a keyed MAC.  Secure hash functions (e.g., SHA-1, etc.) are used for MAC computations.  The Record Protocol   can operate without a MAC, but is generally only used in this mode  while another protocol is using the Record Protocol as a transport for negotiating security parameters. A message authentication code (MAC) is a cryptographic checksum on data that uses a session key to detect both accidental and intentional modifications of the data

## Demo TLS handshake anatomy

```bash
# start tcp capture
sudo tcpdump -w /var/tmp/demo-tls-capture.dmp
# http call
curl --tls-max 1.2 -v "https://api.example.com" | jq
# open captured traffic 
sudo wireshark &
# get destination ip
host api.example.com
# filter tcpdump output in wireshak
ip.dst==20.71.87.189
# pick the tcp stream number
tcp.stream eq ?
```

## Demo protocol version mismatch
### api.example.com supports TLS 1.2 and 1.3
```bash
curl --tls-max 1.3 https://api.example.com
curl --tls-max 1.2 https://api.example.com
curl --tls-max 1.1 https://api.example.com
```

### api.stripe.com doesnot support TLS 1.3
```bash
curl --tlsv1.3 https://api.example.com
# force TLS 1.3
curl --tlsv1.3 https://api.stripe.com
# verbose 
curl -v --tlsv1.3 https://api.stripe.com
curl --tlsv1.2 https://api.stripe.com
```

### Demo Cipher suites 

- List cipher suites using nmap and compare api vs stripe
```bash
nmap --script ssl-enum-ciphers -p 443 api.example.com
nmap --script ssl-enum-ciphers -p 443 api.stripe.com
```
- TLS test lab website 
  - https://www.ssllabs.com/ssltest/analyze.html?d=api.example.com&latest


## Side notes

TLS introduces encryption and authentication, so for example Fiddler on Windows (Fiddler Everywhere on Linux/Mac) registered root certificate and intercepted encrypted calls.

On Linux I found it more challanging. 

## Demo how to TLSit data but still view it

### curl key log recording

```bash
# create ssl key log file (set in in .bashrc)
rm /home/maks/.ssl-key.log
vim ~/.bashrc
export SSLKEYLOGFILE=/home/maks/.ssl-key.log
touch /home/maks/.ssl-key.log

# start tcp capture
sudo tcpdump -w /var/tmp/demo-tls-capture-decrypt.dmp
# http call through curl that supports SSLKEYLOGFILE
curl --tls-max 1.2 -v "https://api.example.com" | jq
# open captured traffic 
sudo wireshark &

# configure wireshark to use /home/maks/.ssl-key.log which allows to decipher these
# Edit=>Preferences=>Protocols=>TLS=> (Pre)-Master-Secret-log filename

# open /var/tmp/demo-tls-capture-decrypt.dmp with wireshark 
# anc check if traffic got decrypted
```

### go key log writer 

```go
package main

import (
	"crypto/tls"
	"log"
	"net/http"
	"os"
)

func main() {
	w, e := os.OpenFile("./keylog", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0660)
	if e != nil {
		log.Fatalf("err %v", e)
	}

	client := &http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{
				KeyLogWriter: w,

				Rand:               zeroSource{}, // for reproducible output; don't do this.
				InsecureSkipVerify: true,         // test server certificate is not trusted.
			},
		},
	}
	resp, err := client.Get("https://api.example.com")
	if err != nil {
		log.Fatalf("Failed to get URL: %v", err)
	}
	resp.Body.Close()

}

// zeroSource is an io.Reader that returns an unlimited number of zero bytes.
type zeroSource struct{}

func (zeroSource) Read(b []byte) (n int, err error) {
	for i := range b {
		b[i] = 0
	}

	return len(b), nil
}
```

## Demo TLS fingerprinting

### curl vs curl improved 

JA3 Fingerprint is calculated from 
- TLSVersion,
- Ciphers,
- Extensions,
- support_groups(previously EllipticCurves),
EllipticCurvePointFormats,


```bash
curl -v -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0" https://acc.dk/hc/da | grep 403

# returns 403

docker run --rm lwthiker/curl-impersonate:0.5-chrome curl_chrome101 https://acc.dk/hc/da
```

## TLS 1.3

TLS 1.3
- Key exchange is shortened means less roundtrips
- Rest of the handshake is encrypted after exchanging public keys

# References

- [How does TLS work](https://freecontent.manning.com/how-does-tls-work/)
- [TLS Handshake Explained - Computerphile(video)](https://www.youtube.com/watch?v=86cQJ0MMses&ab_channel=Computerphile)
- [TLS Encryption](https://www.comparitech.com/blog/information-security/tls-encryption/)
- [RFC Deprecating SSL 3.0](https://www.rfc-editor.org/rfc/rfc7568.html)
- [TLS 1.2 RFC](https://www.rfc-editor.org/rfc/rfc5246)
- [POODLE vulnerability](https://security.googleblog.com/2014/10/this-poodle-bites-exploiting-ssl-30.html)
- [Certificates convertions](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/key-and-certificate-conversion.html) 
- [Certificates metadata](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/examining-public-certificates.html)
- [TLS fingerpint protection](https://scrapfly.io/blog/how-to-avoid-web-scraping-blocking-tls/)
    - article lists few go libraries that can help solve the problem.
- [scrape-ninja-bypassing-cloudflare-403](https://pixeljets.com/blog/scrape-ninja-bypassing-cloudflare-403-code-1020-errors/)