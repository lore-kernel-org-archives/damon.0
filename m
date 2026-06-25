Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069742F7F14;
	Thu, 25 Jun 2026 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364096; cv=none; b=Wxx8wy6Q8YtdO82a1ddXI2f/a8W51vzTgsz4dxkmvDZFFreKTbRQ4UR11Mj2wFcKu2Guh0RT1HTDiXocTgLs9c15rVckYW2yQS3oPqwdqs0WdJE8i1ktYXBN0gmYWpy3UwcADr0VkMw/iBhA/PGszEGEZdn2APnhTWQ/Ez3IDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364096; c=relaxed/simple;
	bh=MqS+ZHG2zkT+o5XBFF2sr1VtC8YNDSVJ+53UKoyp7I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXXJMyvgnLnCwPtXiXxrrllQvspV35FL2ZNHtCKJ1CObmEmJMZX03+BwgCNlk2p4UMfR22zYx7KpUnS0ny7uOdYJpGkYmt7HCrLLLRwFYNyIhyztGj3QRwswe9A+hCSMpZmtRYnginbUjlWD7xLfv5XnSA/NKRyp3q84eFbPUGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVhawKbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVhawKbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF30E1F00A3D;
	Thu, 25 Jun 2026 05:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364094;
	bh=61iW0clYSHE8gzHIMRcuF9jxdl/Em5VRtXAIIrwedXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVhawKbpCGZoP530+IaNcaMO6FdWyaE17WQTJdXc41vAEw94WUo4G0hZxy9h2p+fI
	 k4YZjLzvWzNEPpmK0rN1MaY5m5y1d+PG8ZnEZp419ZUfuHuTqI67vwsMV4Nta18dKY
	 pzeNEqp/ZOCf/1gNeKZfyq68Feg2rn2p84Qtk6JYgsNubfWJ8ucrkLyCY52vxAdkLs
	 kjA65+/QL12t8twWO8cvZLg4nOS6rOEBDv3nB6+SIKOObLYAppwk3k76yIfkcnNaM5
	 5ExUVyOu2qAX+NR62dh5QOJkKpO5oPlelGBy/tnYvbQMKwvuZT5I+YJHOw2PGLdv3r
	 lnQP3m104NcTg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 04/11] selftests/damon/sysfs.sh: test multiple probe dirs creation
Date: Wed, 24 Jun 2026 22:07:47 -0700
Message-ID: <20260625050756.91115-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625050756.91115-1-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs essential file operations test (sysfs.sh) was extended to
test DAMON probes sysfs directory, by commit 14885da09b0f
("selftests/damon/sysfs.sh: test probes dir").  Unlike other DAMON sysfs
files, it is testing only a single directory case.  Extend it for
multiple directories.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 78f4badb5bebb..0f2ef462a6b6a 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -346,8 +346,13 @@ test_probes()
 	ensure_write_succ "$probes_dir/nr_probes" "1" "valid input"
 	test_probe "$probes_dir/0"
 
+	ensure_write_succ "$probes_dir/nr_probes" "2" "valid input"
+	test_probe "$probes_dir/0"
+	test_probe "$probes_dir/1"
+
 	ensure_write_succ "$probes_dir/nr_probes" "0" "valid input"
 	ensure_dir "$probes_dir/0" "not_exist"
+	ensure_dir "$probes_dir/1" "not_exist"
 }
 
 test_monitoring_attrs()
-- 
2.47.3
