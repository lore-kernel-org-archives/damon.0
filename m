Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB33C10BE;
	Wed, 24 Jun 2026 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310829; cv=none; b=O9U2mRw+zHVw4Osij3PNLbhe0DJFGQLg5GdJVcpBPVVK2OLVK3jFbOWbjB+XentiAKn3llOjAaCPN1UKyE6xmE/CKV18WTl3oPEiVdK5kY3g08zhsAVP/qFUEiasFmuDLE6w9mlmbrlcHxq4/YRFKsfmMvdfHlQrvwgzXKaBcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310829; c=relaxed/simple;
	bh=GJjLTxKaRXaEZdo4Beou/OmiB+Azam+jACqiK1n4EPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1j89O2RaVNWmEae7D/wqh1GQZYBBXP6VnKLmV42Af/motq9IJRUjur52P7B3GBhEh3D8q9WeumpxhYWrwJHFkj3tlyHmwC3omF3d+RsySXgEsgl9kiBBq9f/62q4VmQaISwQ68oVwp1Ez7fYHykJx7VXtJ7Td2KiORVfUx9xgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV7kwimj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV7kwimj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90691F00A3A;
	Wed, 24 Jun 2026 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310828;
	bh=P5Ko9Sc3WGq6lwgzFKNv7VvLXkmRDvSBGDfYu8mlh0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gV7kwimj1WKYV7qMH66p+t25aGoxfZs35uM+els+I0AdC/TvGRQ/EpfJqqQ1JxbzW
	 TQtaAjoRDuaVPKAoCfw4+6uFB6+yLGCxpS4kEXxntV15cyIazkm1AfCAnhpFI9Gc0d
	 ubyKApDR1stgfuouIYECZCIAR3O2peTYkpMYq2Dt8ynhJh8KdhhBJw7kwMX25QkepS
	 yzhgL8RMg9vxdVIFn5eJZ2LXov9vJ4DwgTeka9rBq2+D3uUccUfo1o+O3uhehGJKQB
	 +OnvRtjl90Wtg9thhc5VrO1S8yH8e3xmu/bK0Bp6Q5oVEWGStBzW26pRYDVky7z8ta
	 Z/WEiqh48XjVA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/11] selftests/damon/sysfs.sh: test multiple probe dirs creation
Date: Wed, 24 Jun 2026 07:20:00 -0700
Message-ID: <20260624142008.87180-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
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
