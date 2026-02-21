Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3193101DB;
	Sat, 21 Feb 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702595; cv=none; b=eR9WyngRmGVshMlt4JRH0fSw0ucHhuyZMA8qPkqd2jIbeF2amrNfHs6DU5yX/SNHPuPRkHlHe2HFbdT7fQ6AlOp7ID9We0O23uaJLlfM3O8Eky0vX1XGFF+XidIoCPjse5RLTevtd4w6Cs3ozewB7LpY1bSbJsl6FpR+9nqmvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702595; c=relaxed/simple;
	bh=l038CwXEsRXfQGW1aiTP2FYS/HRgWbBchKOVGaSDEes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUd/e8pL/9BzZNTq9vaRgZASPYSBN1FUtxHsr5jOj4y8KFgk5oh6vO2G7oXzeUUmYnp9XtsrbUf/0ZMHEDVLkHU5uvQIA3KWjYaYyJ/sKvHoKzSBjI8Y00MvLbv/bo+Kpzemr5nAbWwfXj3DgHzFxblfmJRn06zTyEoKduG5CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=celEuxFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="celEuxFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92CEC2BC87;
	Sat, 21 Feb 2026 19:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702594;
	bh=l038CwXEsRXfQGW1aiTP2FYS/HRgWbBchKOVGaSDEes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=celEuxFUEJPGHRlpjOEuVXuEbu7+3pNdX2nDOFCvfoCvNKM5OJI51+jQbxLSzLPfs
	 tlN7VD99W/tL/MUmtrjJGG59xgAvzUz62Vy6YWPOBVQMZxq5swA3XfsBwhrNqpuvDG
	 pH5T7u3psglNSpdCk+S3mDI73aW3FdpwAR0fvr7wrTZOV6vww35173qbdJ4AFGZMpK
	 AWlpT/wQUeDu+DVw15l7sHpUJgt0lndxke4bG/uSiLYBxGjPQHbPiyYCc3f7ZsoyVI
	 f/tX82f7XvG9/W22w6egNzvnHXXth2le5XTYK/cU8a5/1307TRhUGNJQJ4mXM6m2RH
	 JVpEfl5Z9OMhg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/10] mm/damon/core: add damon_new_region() debug_sanity check
Date: Sat, 21 Feb 2026 11:36:19 -0800
Message-ID: <20260221193629.19332-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_new_region() is supposed to be called with only valid address
range arguments.  Do the check under DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 602b85ef23597..a7f5748c1fe17 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -109,6 +109,22 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	return err;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_new_region(unsigned long start, unsigned long end)
+{
+
+	if (start < end)
+		return;
+	pr_err("damon_new_region() s called with start %lu >= end %lu!\n",
+			start, end);
+	WARN_ONCE();
+}
+#else
+static void damon_verify_new_region(unsigned long start, unsigned long end)
+{
+}
+#endif
+
 /*
  * Construct a damon_region struct
  *
@@ -122,6 +138,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	if (!region)
 		return NULL;
 
+	damon_verify_new_region(start, end);
+
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
-- 
2.47.3
