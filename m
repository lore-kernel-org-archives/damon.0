Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4626A0C7;
	Sun, 15 Mar 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608425; cv=none; b=Ev+Ap1L3i4OraIPR3lLO4QV5/EJabrnIr/Qkef+QfaQcTWgdg5k6OsjCNySHiTHDeI+3UfYDvtW3JKeGnl/mbW3P4yapi/QO3rTv9pffvAsw/4vma/IdHs8yhr/RG77GcZQTHtSB1kB5ciD0Ftk7shfjtqJ0rH1JuToI1aZoxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608425; c=relaxed/simple;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAxGGbZ/C7eZRnG94K4CE5m1+LD/SHcOuMHYnOH3/5sD73T1ylOwaaclo7SMKWXyb+K8XBl+4dxli2N2rfrlNn+sIMBVJrjdGwu5/KTh7XOzYRBFf5WjLA+mcObZqsPKmC/OoHas5bv/hZNQIbvXyC67bLSnUWNbF3QiFcfmwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4UCZ0nv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4UCZ0nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF3C4CEF7;
	Sun, 15 Mar 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608425;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4UCZ0nv3gBgH8YiNIiRnB2qR3Ee9C8eNMYwibb6/8blLcIw3t8PCOrL9Isdi/2R9
	 rb8aByVgzVs2R5FADMzd1/m6NkxE4rfrP7s3fYiEWCmKsDEffQHiMDBJFomoxcZ8Y5
	 RZrMYxOensQkz8KytCvJtzwsRSLG+7JVnTeT4kLPkC28tGtjgkzcEgyzJl4yvSW9L3
	 o3uLy8DdNvD9TLyv2ovNm1oVLKMsmJLIApQZyrBCu9TylUd178/K5wlY6jfbrL2owW
	 SG85E/IEF5217827ZHWe/33YVaXNKpvwKOjiPgH2HJoWw417Kq0jYQDaCh1cEWP8vr
	 W1UfcZPSE4eww==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
Date: Sun, 15 Mar 2026 14:00:08 -0700
Message-ID: <20260315210012.94846-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
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
