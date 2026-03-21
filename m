Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3E3537DE;
	Sat, 21 Mar 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116835; cv=none; b=YPyumgxaZ6uGEjUZeNzC7nWh2ozMFDpNBu1v9jU3DN02ram3aV0sp/XhbzHyUUjGBrHB9+plOyn3+GRx2YKN0/ruq6mrBOMDoQtwZTko6EBWMBGnGZgCsjovzggjCKKvO8Y1xIrypXgK+HKSn4KLTV7d0QxBIGmSva0tMgobLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116835; c=relaxed/simple;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Grxi9e1e5604nodqtK0YfMOQKGiL8BpeHFFDWGp2C87yW5VmPuBOra1PQUf+WSacZMd6iXGetlbiBWML/XtlB5G2zqAvbP0ctSPoPLdKa6OVEQ5i7FKzkozYfMT6c92Ktaj7J5mRB2zq6bEE4z2Y5++mUTDkvLHdGbJOO8eJ2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kor2iOVN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kor2iOVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7D0C2BCB2;
	Sat, 21 Mar 2026 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116835;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kor2iOVNzoHJxwalPA3UN6OFYDWwAC1kmeN820N7EAGmtJnCbIv6S4kDN9nIHOG05
	 mpYVKOolGzmcFs+MQ44P3fHba8boPFpAwMewe93AYnPZvtbDOPf5HZwZF3/xCA/pg+
	 gq7dOC+FaboQe69izaNjXYEtINgs564L+7b4VTobLG+9+DRlU/L0mwXjT0dsCXka8N
	 ZB9rA6ATE776eUg/zNe/6FvZmda0ffITAfmlzcOYThubf8PF4VmcriVZ5sH07ZZrfv
	 oBSBqz4LpJ2yhBe+RT9MwWtZ8O7YwKRXnWdKgtlGh+KzQ9BI/4On207Wd5PKORu/Gx
	 0vnXK4HbEXneQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
Date: Sat, 21 Mar 2026 11:13:39 -0700
Message-ID: <20260321181343.93971-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend sysfs.py tests to confirm damon_ctx->pause can be set using the
pause sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3aa5c91548a53..e6d34ba05893f 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -190,6 +190,7 @@ def assert_ctx_committed(ctx, dump):
     assert_monitoring_attrs_committed(ctx.monitoring_attrs, dump['attrs'])
     assert_monitoring_targets_committed(ctx.targets, dump['adaptive_targets'])
     assert_schemes_committed(ctx.schemes, dump['schemes'])
+    assert_true(dump['pause'] == ctx.pause, 'pause', dump)
 
 def assert_ctxs_committed(kdamonds):
     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-- 
2.47.3
