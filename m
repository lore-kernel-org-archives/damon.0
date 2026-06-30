Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A442668C;
	Tue, 30 Jun 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829062; cv=none; b=rJACOSIa+oH+HxewfPUDVICp7MMSzWTfxZILTp0dQJOCUwsHj8gtu18oC2mu97U7vHEACNrc6QTiSMbFNxFF5lCme0zm27/TTrxJwAu8XKEzEhlsxTKjoQquchOoIUTXx4B7CxHykEU1iCjX2odP21hGwCU/rEj3aDXYMVsuzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829062; c=relaxed/simple;
	bh=I6ByaANwUtX8654SvJO4mujFegibTj5b2MmbrYzPw04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/mkHHN9zxqHIuW67kdil21slrtqsAecd4m9Hy0VDCkIRWTpNpnZ9UrWy0GSTMO8wHyD13lbKdbV5v+x7hgcg9kzNeg1+ROX7cE+M2ey39kKbP7h/BC9irM9zQ95zW5QCSVzlmgZndIJwY5RXieH3xb23/MPsuBe6KID7Elzym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7r7tMI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7r7tMI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ECF1F00A3D;
	Tue, 30 Jun 2026 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829061;
	bh=UL1zPOd9UwMDzVKB7bhTFiDOr3xTMkEdXRFwvMlUiCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E7r7tMI0wjFr1faZzbmUrzQCujOA26oYurN3d5aTw0SGW2guJSrCq21g0YRWbomPR
	 HhQeXpD4yYE8q6UII7rTOKtH1AgkbXHVAt3pVzk3gsxrZs70eGsLrKyuCfh3yYS6NP
	 z9BHPGJt/xKf6aiDAxfpovahhT2XFbc2cj0iNQXds0LSf/24ENmj8aVK7YqAtZh1Im
	 u2Z7oWV8DJYlBfcRJpt9wIlgY+0enYDYnMI936h2EF53cYQF1QG8Wrq983ib8SemIq
	 1V8Zfn2XAdhhogv0rk+GbIuhkNQv025BXZ7MVXyzhiNbUA4uSLB83liU35JUkpaBiE
	 nT9xyz8hnM9Yw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/11] selftests/damon/sysfs.sh: test multiple probe dirs creation
Date: Tue, 30 Jun 2026 07:17:18 -0700
Message-ID: <20260630141726.92246-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 2eaaa5ae3c5ed..d528dfea44c3b 100755
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
