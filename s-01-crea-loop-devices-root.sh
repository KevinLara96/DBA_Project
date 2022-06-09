# @Autor Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
# @Fecha 02/05/2022
# @Descripcion Script para crear dos loop device

# Creacion de directorio donde se encotraran los archivos
# para crear los loop device
cd /unam-bda
mkdir pf-disk-images
cd pf-disk-images

# Creacion de archivos con puros ceros
dd if=/dev/zero of=disk1.img bs=100M count=10
dd if=/dev/zero of=disk2.img bs=100M count=10
dd if=/dev/zero of=disk3.img bs=100M count=10

# Comprbacion de la creacion de los archivos
du -sh disk*.img

# Creacion de los loop device asociandolos con su respectivo archivo 
losetup -fP disk1.img
losetup -fP disk2.img
losetup -fP disk3.img

#Confirmar la creacion de los loop device
losetup -a

# Da formato para que los archivos creados anteriormente
# puedan ser montados
mkfs.ext4 disk1.img
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img

#Creacion de los directoroios donde los loop device seran montados
mkdir /unam-bda/d11
mkdir /unam-bda/d12
mkdir /unam-bda/d13

##Loop devices para BDA.
#echo "Modificando el archivo fstab. Contraseña sudo para montar los discos:"
#echo "/unam-bda/pf-disk-images/disk1.img         /unam-bda/d01   auto    loop 0 0" >> /etc/fstab
#echo "/unam-bda/pf-disk-images/disk2.img         /unam-bda/d02   auto    loop 0 0" >> /etc/fstab
#echo "/unam-bda/pf-disk-images/disk3.img         /unam-bda/d03   auto    loop 0 0" >> /etc/fstab

#mount -a
#df -h | grep "/*unam-bda/*"

