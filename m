Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACE337B8F;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387012; cv=none; b=bIm7hxnDGnyXC38hCgrOmZBwQhGn5YuiQNUMfWXY6/H76RBF6jT723Pk7OgTVl99vI177Aa/7Lu1usOJ8wOIRsAdxRa6BJQJVDn6Pb/HXCKT+CM4sGian8leD3ZJZBlvoGFLsRCWDhCVmV+Zfmt0hnqkerkh2eMsbur0vFgzG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387012; c=relaxed/simple;
	bh=h0Fe5csr3sldzD6TLO83VPiRoEMNSXNoD5pNU6aZzIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELdXBLhruJ6umwY1XBOQhtSWiOG4TqrdE8Zy91UUzFsCGVXV/ajfQbeRaVOJDPI+uT7XGw8GvYlepFBSevG+Se83vGMZ60dud0YdGpEW2hh/hrj0n00Ypi5Onzu//EjQc+lqNf/7flgSk44+ryp63kdfCJ1AXyXeUCThrU4/uPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO29yu2E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO29yu2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC9CC2BCB2;
	Sun,  1 Mar 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387012;
	bh=h0Fe5csr3sldzD6TLO83VPiRoEMNSXNoD5pNU6aZzIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lO29yu2ESlUHUzzR1nxvpCUFW3x9kKowPe+dexg3bbPFDyTPyO1qAg5OlX63GVDZJ
	 6QX+67cOGEcsKE/cM/xng61jC257qS2nQr8mAcDiSo3rGdV4S64yuB/TfZAlsG1t/6
	 FRUxCmpee3sP7q1l8PPnjz88byam8eUUxpahEtKo3v1BNgexzauiThP7xbWlE2Cyig
	 TiapquwJwPYGpazfGQ2LUtRaJ8UwgkQRoqb7YVE3sNU1I2oAUh0tfz0Iytyl2Zqs53
	 66WyiSxAO/9BFrtpN3hcC/7Y2MFNIJQgeYLLTun6fIU+C5SS8Lb3kpWJy3sfXZxHIR
	 GOb29K2ZilHng==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 03/10] mm/damon/core: add damon_del_region() debug_sanity check
Date: Sun,  1 Mar 2026 09:43:18 -0800
Message-ID: <20260301174327.76849-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_del_region() should be called for targets that have one or more
regions.  Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0c1353164ec81..92eac5eb96026 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -152,8 +152,21 @@ void damon_add_region(struct damon_region *r, struct damon_target *t)
 	t->nr_regions++;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_del_region(struct damon_target *t)
+{
+	WARN_ONCE(t->nr_regions == 0, "t->nr_regions == 0\n");
+}
+#else
+static void damon_verify_del_region(struct damon_target *t)
+{
+}
+#endif
+
 static void damon_del_region(struct damon_region *r, struct damon_target *t)
 {
+	damon_verify_del_region(t);
+
 	list_del(&r->list);
 	t->nr_regions--;
 }
-- 
2.47.3
