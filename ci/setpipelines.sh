echo Setting pipeline for razorpagesmovie...
fly -t csalis sp -n -p razorpagesmovie -c ci/service.yml -l ci/pwsdev.yml -v service-name=razorpagesmovie
