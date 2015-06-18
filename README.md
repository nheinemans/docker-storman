# docker-storman
# Purpose
Create a container running the Adaptec Maxview Storage Manager application and the necessary daemons (cimserver and agent).

With this container, you can manage an Adaptec RAID adapter on the dockerhost. It is based on Centos 6 and Adaptec MSM version 1.08-21375

It should be run with --privileged, in order to have access to the hardware and insert the necessary kernel modules.

# Start Adaptec MSM
Listening on port 8443 (user=root, password=root):

	sudo docker run -d --privileged --user root --name storman -p 8443:8443 nheinemans/storman

# Invoke arcconf CLI
It also contains the arcconf binary, which can be invoked with:

    sudo docker run --privileged --user root --entrypoint=/bin/arcconf nheinemans/storman

Or in an already running container:

    sudo docker exec -it nheinemans/storman /bin/arcconf

# Disclaimer
I'm in no way affiliated to Adaptec and cannot support its products. I just needed an easy method to manage my Adaptec RAID controller.
I tried to keep this image as small as possible. I realize I should have split the 3 daemons into separate containers, however I haven't found time to do so. Also, I don't use MaxCache, so the MaxCache manager is not installed in this image.
