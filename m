Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4F252F62;
	Sun, 12 May 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542624; cv=none; b=D4Z2UHpqB+KN4rAIQ/5PLWexGEN9IKJe61LKQtpN89WmC9gxlVSKT+IWOhDonCvDUJB2xLhZb05xyTMzRdBS35imD5KLM9rDuaqE0/M10jLwrhtBqvyPGe4N7QjbnI2DZji9IcWNv+ISmw8HmMfUqoZeVQRblnqM+uUdcmNVnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542624; c=relaxed/simple;
	bh=uU0i+7VRHwnLzmsgFart/FdYz1FyWcfTrlJwgj1wLXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLOSt9+rsJ5QksXmNyUvrbdJGAXugeXbRyyPvCh8cLaZaDKMZ2LBeXn1Vaso8Fcy5S0MeqfoW2IoDH6UUETPlfHTlw7+1Q2L6h/e8il030/J9X91QtqbtArLAwwHQ2wvqoHuADxegKMndk2K73t50QZfPzJSoJly8ht7INyYM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6l3DmWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6l3DmWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BA2C116B1;
	Sun, 12 May 2024 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715542623;
	bh=uU0i+7VRHwnLzmsgFart/FdYz1FyWcfTrlJwgj1wLXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6l3DmWiydgP0NCLJj1UuD9gUii+CJo1Lz8Nttns5L737tG96vubosSPx07CxVI5D
	 LHL2N3WpDvMNSRhitK0IUhJGLqFT8TQr93XSR72I1rg+c9hIxAv1x4Xc9RomlhFG96
	 M2BK0wmkH5SAVuxj8dxYuLcpV92z0Sf0579l8x2xcgPEZErxYf/uBD58dYVEcgYDEe
	 HLmCLsbGhvRBV/pJXARjMT6uxcIfKIUTJK/BSBCr01drUp/RCnku/RO/kpKv6lpdF1
	 gd3aw7wFgDE2rHdr4jWd6zLyknqG0ExTPfkTNEKWNTQVnve326rH6M4G2IEqANuk09
	 wRn+E1JBQfGpg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC IDEA v2 3/6] mm/page_reporting: implement a function for reporting specific pfn range
Date: Sun, 12 May 2024 12:36:54 -0700
Message-Id: <20240512193657.79298-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512193657.79298-1-sj@kernel.org>
References: <20240512193657.79298-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a function for reporting pages of specific pfn range, for
non-free pages reporting use case.  The use case will be implemented by
following commits.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/page_reporting.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61d8c..e14f2e979f16 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -349,6 +349,33 @@ static void page_reporting_process(struct work_struct *work)
 static DEFINE_MUTEX(page_reporting_mutex);
 DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
+#ifdef CONFIG_ACMA
+
+int page_report(unsigned long pfn, unsigned long nr_pages)
+{
+	struct page_reporting_dev_info *prdev;
+	struct scatterlist sgl;
+	int err;
+
+	rcu_read_lock();
+
+	prdev = rcu_dereference(pr_dev_info);
+	if (!prdev || !prdev->report) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	sg_init_table(&sgl, 1);
+	sg_set_page(&sgl, NULL, nr_pages << PAGE_SHIFT, 0);
+	sgl.dma_address = PFN_PHYS(pfn);
+
+	err = prdev->report(prdev, sgl, 1);
+	rcu_read_unlock();
+	return err;
+}
+
+#endif
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
-- 
2.39.2

