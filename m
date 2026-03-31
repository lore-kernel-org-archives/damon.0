Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44716285C9D;
	Tue, 31 Mar 2026 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934583; cv=none; b=KWilGvg4nvRAwpjO8SQkC7amdQpwBZ0gGdShpJhajwju9ASJO/XspVtT5ogHoZ4VEjIZNfzzPypFTOMmvoJnQuDNSmHMxedW94/+LveuVM+DF61KMuKQhwM7oZO4sq4CVZuknzxcIJMUlFstU4SOEOq35TgW7RnPYWeT4Px5+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934583; c=relaxed/simple;
	bh=HR6uly8zpqdWi4k+uLHdzgPRJ1/shkKgt3v0ktDQl4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZthwDaY0WRBmbZttPsEetylFS6zg6ItqkxnwhEmdyAbw18xFTfLhRyMGDAdnhWso6soQ6FP3JlkLShcajVPbjjSlRVK1rWsEkqvDTBbry8MlJSHYv8Jyde5INzAwrWD1eIFMzO33B2apJVK0U98Dai8aCEdZZgxwBnYtZfyj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQQzB/cv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQQzB/cv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0842C19423;
	Tue, 31 Mar 2026 05:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774934582;
	bh=HR6uly8zpqdWi4k+uLHdzgPRJ1/shkKgt3v0ktDQl4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQQzB/cvl3Nh/PjUrN0AIJQKSMbIAru9BcpNcy/RrVigSFRd/pBf/CRs1olJ6u47G
	 r0vOdGh4c+tGI6DRbT2rPl23wXSm4YeCvPdYUcsxkG2WUxr7Un5RLfcTL7r89ooAaM
	 YDdIrtJ6PxfQ1po1ylfnicXlVw/IweSCcB7tQRbDUlj5vN0CyF3zlMf+rYXRIFocJH
	 bXmkj0+jhdAHrLMdQJLK2sOATFXrQAoJqjNRxhg92hpfahBmWUlho4ltxoGYm6UHBw
	 UlSoHancfkVDt5LynnNZK475ToJxNuVRVRIhDLntnLMmqrv9fVJQXAmtT8WEHzJL89
	 nn7rjoV6Bld+g==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Mon, 30 Mar 2026 22:22:59 -0700
Message-ID: <20260331052259.68754-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026033007-talon-immature-91a3@gregkh>
References: <2026033007-talon-immature-91a3@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

Patch series "mm/damon/sysfs: fix memory leak and NULL dereference
issues", v4.

DAMON_SYSFS can leak memory under allocation failure, and do NULL pointer
dereference when a privileged user make wrong sequences of control.  Fix
those.

This patch (of 3):

When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
param_ctx is leaked because the early return skips the cleanup at the out
label.  Destroy param_ctx before returning.

Link: https://lkml.kernel.org/r/20260321175427.86000-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20260321175427.86000-2-sj@kernel.org
Fixes: f0c5118ebb0e ("mm/damon/sysfs: catch commit test ctx alloc failure")
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7fe000eb32904758a85e62f6ea9483f89d5dabfc)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dec9f5d0d512..3d410f9213ed 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1476,8 +1476,10 @@ static int damon_sysfs_commit_input(void *data)
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	test_ctx = damon_new_ctx();
-	if (!test_ctx)
+	if (!test_ctx) {
+		damon_destroy_ctx(param_ctx);
 		return -ENOMEM;
+	}
 	err = damon_commit_ctx(test_ctx, param_ctx);
 	if (err)
 		goto out;
-- 
2.47.3

