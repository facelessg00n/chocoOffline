
Httpd can be run within docker to host the icons required for the chocolatey GUI.

Install docker as per instructions on their website. Also take note of the new liscensing conditions for Docker if they are applicable to your organisation.

---

### VS-Code

In the terminal run `docker pull httpd` to pull down the httpd image.
[httpd - Official Image | Docker Hub](https://hub.docker.com/_/httpd)

Create and open a new folder, this is where your icons and basic website index will reside.

As per the example files create the following

1. Dockerfile
2. index.html
3. images folder

Place your required icons into the image folder.
[[Icons]]

Modify the index.html as you see fit

Copy the below into your Dockerfile.

`FROM httpd:2.4`
`MAINTAINER no@thankyou.com`
`COPY index.html /usr/local/apache2/htdocs/`
`COPY ./images/ /usr/local/apache2/htdocs/images`
`EXPOSE 80`

In the terminal run `docker build  -t icon-server:v1 .`

`icon-server` is the name of the docker container and the version number is 1. `.` Will cause it to be built in the current directory.

You can now run the container by one of 2 methods.

---

### GUI

Open the Docker GUI and select the image and then press run, Select optional settings, name your container, then enter 8080 into the ports. This will prevent port conflicts. Press run
If you navigate to localhost:8080 your index HTML should be displayed.
If you navigate to `localhost:8080/images` you should see an index of your uploaded icons.

In the docker GUI you can then navigate to the containers tab and see your now running container. If you select the 3 dots symbol and "view details" you will be able to see requests made to the server.

---

### Command line
