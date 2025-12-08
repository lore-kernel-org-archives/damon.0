Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72731A554;
	Mon,  8 Dec 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175395; cv=none; b=AeA5TIaFiUT4lKser5kPYNew0bcglJRNeVclZ53OEp2qOcfTCJNglIwQk2TvkKaSNlXWxWaKIS6PysUj9p70xQhgDywgjDCMLiOSC7aP+TSCttQoOGV2f+LkUU0s1S+Y6HN5EG83gpV7kXx8xWlzop5OBwc9PW3AOjskGAzLMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175395; c=relaxed/simple;
	bh=kFi2QDyr9gKqWX13ZWpeGzoNVnWkjkenFzPE2s60nLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmM0EeKNbc1KTbmwPkKZiTpBnSKqPf2xiQ7eWYIPZE6yETln8IIjZ7V5phI/m/UqTzOLsKm9+SflEwbc9nUM9GJdpt9Dp33sOFGq/ntBus5XSPCrQ31DFNjbyXf532XK6qJljZwkk7DKIJVXpcE9o1RgLuQ3aZEkn3dAC7xLnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJbqzxQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJbqzxQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74180C19422;
	Mon,  8 Dec 2025 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175394;
	bh=kFi2QDyr9gKqWX13ZWpeGzoNVnWkjkenFzPE2s60nLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJbqzxQ3L/kD9luw3CSq8MIwgYAnTHw91s3JR6CQxPmXpWLZDk9ucr52+clZQuhB4
	 NPONyYD1/kreuAywtWnRDE8VgpdBCJWBg4QYHlRImB7iid3jVey8RsDS3PRnBgLSlE
	 bBD8C6Y8uyKD5vA2xbaYihb9+wTBEPj7j5pc7Q6CJGSgO19ln82nPsM/qv0n0Dxbwq
	 s9uHC4Kw17oKl1ssnFBk/gwkiCI5Fm7bvaxxebxjNleC1964qm3R9Iz6rcqIBp7VjF
	 XxhxBmyInnw+Ud9km5Gp7nIosOoMDcLIbfDGy7sKPcU8CJ7jPpEvVRhIUEA1wvVFf9
	 M0sudPLy74hHg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 04/37] mm/damon/core: implement damon_report_page_fault()
Date: Sun,  7 Dec 2025 22:29:08 -0800
Message-ID: <20251208062943.68824-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a DAMON core API for reporting page fault events to DAMON.  It
is a wrapper of damon_report_access().

This is a temporal hack.  In future versions that will have no RFC tag,
only damon_report_access() may be used.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ++++++++++
 mm/damon/core.c       | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b9359c76a6f1..b8ebb2aa02c8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1017,6 +1017,13 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 void damon_report_access(struct damon_access_report *report);
+#ifdef CONFIG_MMU
+void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
+#else
+static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
+{
+}
+#endif
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
@@ -1027,6 +1034,9 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 static inline void damon_report_access(struct damon_access_report *report)
 {
 }
+static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
+{
+}
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 89305d42e116..296117d5e7f7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1579,6 +1579,23 @@ void damon_report_access(struct damon_access_report *report)
 	mutex_unlock(&damon_access_reports_lock);
 }
 
+#ifdef CONFIG_MMU
+void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
+{
+	struct damon_access_report access_report = {
+		.size = 1,	/* todo: set appripriately */
+	};
+
+	if (huge_pmd)
+		access_report.addr = PFN_PHYS(pmd_pfn(vmf->orig_pmd));
+	else
+		access_report.addr = PFN_PHYS(pte_pfn(vmf->orig_pte));
+	/* todo: report vmf->address as virtual address */
+
+	damon_report_access(&access_report);
+}
+#endif
+
 /*
  * Warn and fix corrupted ->nr_accesses[_bp] for investigations and preventing
  * the problem being propagated.
-- 
2.47.3
