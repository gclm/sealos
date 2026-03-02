#!/bin/bash

# 0. Install MinIO Operator
bash scripts/minio-operator.sh

# 1. Create MinIO instance
bash scripts/minio.sh

# 2. Run ObjectStorage controller
sealos run tars/objectstorage-controller.tar -e cloudDomain=${cloudDomain}

# 3. Run ObjectStorage frontend
sealos run tars/objectstorage-frontend.tar -e cloudDomain=${cloudDomain}

# 4. Run ObjectStorage monitor service
sealos run tars/objectstorage-service.tar -e cloudDomain=${cloudDomain}
