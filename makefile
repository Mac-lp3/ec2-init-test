
local_dock_tag = "ec2-svc-test"

dock_build_test:
	docker build -t ${local_dock_tag} .

dock_run_test:
	docker run -it ${local_dock_tag} /bin/bash

