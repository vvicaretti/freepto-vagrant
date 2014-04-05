# Doc references
# http://docs.vagrantup.com/v2/boxes/format.html

OUTPUT_DIR="output-freepto-libvirt/"
BUILDS_DIR="builds/libvirt"

echo "Starting image conversion..."

qemu-img convert -c -O qcow2 ${OUTPUT_DIR}/freepto-dev.qcow2 ${BUILDS_DIR}/box.img

echo "Creating box file..."

cat > ${BUILDS_DIR}/Vagrantfile << END
Vagrant.configure("2") do |config|
        config.vm.provider :libvirt do |libvirt|
          libvirt.disk_bus = 'ide'
        end
end
END

cat > ${BUILDS_DIR}/metadata.json << END
{"provider":"libvirt","format":"qcow2","virtual_size":21}
END

cd ${BUILDS_DIR}
tar czf freepto-libvirt.box metadata.json Vagrantfile box.img

# clean
rm -i metadata.json
rm -i Vagrantfile
rm -i box.img
