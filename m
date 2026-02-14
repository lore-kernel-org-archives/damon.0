Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F82556E;
	Sat, 14 Feb 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771105294; cv=none; b=I9YZVIn6q7Esob7aHy3VuLx+a/9IscIBsmT1t9u1HXimSAt0MaxDSzpF377c1QiGt3sMBEzQ6uSOXIncr6XaIu4LpLkNB1S4WcupyA+Oc3IU6lnGTBmAPxsMgqa82ynVyEAf8Y5oAszadK/EnpCImAoKy6vIYPKwVTScZl5WAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771105294; c=relaxed/simple;
	bh=pjkwKmulTQMrj0f/NejRYLH42ooATAnuXxjLQOaFmfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFydUEDnPUPm7NUAS4XZQHIzK9TfMWC4goCG/RnQ4aN1AsoIkA99QU9VRTuiRZEPEnmOXFHHpfp4XOgceac9C2LSAUWLz266fyCuZgPfQ8Hl8IZr4SfLE2s8njdT9Abqfg7txVCeRcl5TE1Swd/PC/H05mmPgjqO4r29QqLWdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIlYlZF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIlYlZF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0DC16AAE;
	Sat, 14 Feb 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771105294;
	bh=pjkwKmulTQMrj0f/NejRYLH42ooATAnuXxjLQOaFmfM=;
	h=From:To:Cc:Subject:Date:From;
	b=jIlYlZF+4PBNJ7bt04XHmqAWbG0k5pm94I/ik9/XFVg5T9UhMReiebz6qrbNCjikC
	 2VrBquWKBfpb9Wy9KM7Q24Sld5kulGZUULOwxzDwoxy6+d+1SiCPF5aIW21weTa2LV
	 Yltx3HWvDYu+TI7i3NPhEJ/7SnQUmXsRT8BKjvs09BY7YI0svnh4dm6hHDZfKHNjJV
	 j55Qq7pDtKVuS+wS+CSfxxQK7DA4NBt7rATEF6VVe08XrDbABHfMx8fT2UOjcLZo/8
	 3wpnmUzh09Bbba6wsoEuJaIFH2voQemC00BkqAvA2QjKoZBRPdY8CIXExtDgGwkAHj
	 SioomFYV9E26Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: disallow non-power of two min_region_sz
Date: Sat, 14 Feb 2026 13:41:21 -0800
Message-ID: <20260214214124.87689-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core uses min_region_sz parameter value as the DAMON region
alignment.  The alignment is made using ALIGN() and ALIGN_DOWN(), which
support only the power of two alignments.  But DAMON core API callers
can set min_region_sz to an arbitrary number.  Users can also set it
indirectly, using addr_unit.

When the alignment is not properly set, DAMON behavior becomes difficult
to expect and understand, makes it effectively broken.  It doesn't cause
a kernel crash-like significant issue, though.

Fix the issue by disallowing min_region_sz input that is not a power of
two.  Add the check to damon_commit_ctx(), as all DAMON API callers who
set min_region_sz uses the function.

This can be a sort of behavioral change, but it does not break users,
for the following reasons.  As the symptom is making DAMON effectively
broken, it is not reasonable to believe there are real use cases of
non-power of two min_region_sz.  There is no known use case or issue
reports from the setup, either.

In future, if we find real use cases of non-power of two alignments and
we can support it with low enough overhead, we can consider moving the
restriction.  But, for now, simply disallowing the corner case should be
good enough as a hot fix.

Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 925908415a041..55cbf86476006 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1252,6 +1252,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
 
+	if (!is_power_of_2(src->min_region_sz))
+		return -EINVAL;
+
 	err = damon_commit_schemes(dst, src);
 	if (err)
 		return err;

base-commit: 918647226184ca20e5f86ee7d4df3e34c7433799
-- 
2.47.3
