class Leap < Formula
    desc "A debugger and analyzer for your DNNs.
    Complete documentation is available at https://docs.tensorleap.ai"
    homepage "https://lensorleap.ai"
    url "https://github.com/tensorleap/leap-cli.git",
      tag:      "v0.0.17",
    license "MIT"
  
    livecheck do
      url :stable
      regex(/^v?(\d+(?:\.\d+)+)$/i)
    end
  
    depends_on "go" => :build
  
    def install
  
      ldflags = %W[
        -s -w
        -X github.com/tensorleap/leap-cli/pkg/version.CliVersion=v#{version}
      ]
  
      system "go", "build", "-mod=readonly", *std_go_args(ldflags: ldflags)
  
      generate_completions_from_executable(bin/"leap", "completion")
    end
  
    test do
      assert_match "v#{version}", shell_output("#{bin}/leap --version")
    end
  end
  