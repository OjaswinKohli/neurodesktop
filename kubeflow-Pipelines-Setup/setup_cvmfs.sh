#================================================================================================
# Set up CVMFS
#================================================================================================
# helm install cvmfs ./cern/cvmfs-csi/deployments/helm/cvmfs-csi -n kubeflow
helm install cvmfs-csi oci://registry.cern.ch/kubernetes/charts/cvmfs-csi -n kubeflow
kubectl apply -f cvmfs_kubeflow.yaml
 
# Delete and recreate cvmfs nodeplugin pod
CVMFS_NODEPLUGIN_POD=$(kubectl get pods -n kubeflow  --no-headers -o custom-columns=":metadata.name" | grep cvmfs-csi-nodeplugin-)
until [ -n "${CVMFS_NODEPLUGIN_POD}" ]
do
  sleep 2
  CVMFS_NODEPLUGIN_POD=$(kubectl get pods -n kubeflow --no-headers -o custom-columns=":metadata.name" | grep cvmfs-csi-nodeplugin-)
done
kubectl delete pod $CVMFS_NODEPLUGIN_POD -n kubeflow
 
