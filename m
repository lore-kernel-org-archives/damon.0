Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8A337B97;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387012; cv=none; b=mT+ZuR/zYewj5r+IulspBTSw9CtGNlwQqEYQFZCTPDlcnoxela6cNg5OqPAn0oU/ydORXVAzgjD1pDC+N6za6sNKEQa8YD3I9a+aRevn5sTIaOGFGmG3N4EIGLTAIDVut5lTckGFAuYpFmMpxQaNzLJL3q1hXnXIxHAqhlkS4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387012; c=relaxed/simple;
	bh=zFDrPDtcwfulSyFJOaJh2lietZw1gfebL6litU0OglA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxRlwSpT5KgHrFnowodtP6rq5QtP71z6mVxQACyigR/QqN/Vsd4y/LTlPdj2YLQzEJDnKje453Wo+CabwilDsQATK1VY07iAX/3NeV+JacmYU01dRNb+ZSKsLCp5JAk35klVQ/YIOb2eig2iXbApdQYLF0kt+p75FmUUNIvwOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd9OgLsT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd9OgLsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A768C2BCB4;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387012;
	bh=zFDrPDtcwfulSyFJOaJh2lietZw1gfebL6litU0OglA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nd9OgLsTu3ecaX5TcXHYptFLk841w3Y6SNtOGO/WiO3U5igWi7VKyhQGO+0xY/IZN
	 CB1lRMIvdtpVfffuXIwuEoEAOEJrnomYD6d/Y9qNcWbdwcZtBUkqVxccMqOAdUdkYD
	 DAe7rt6WxIetT6oStd5OPJRULSsWArXOSzyoHwDWXHeHiOJMTp+66u5FfatpQamtVy
	 jFGNA7UirHT7L9w2YY07scAmlguyKpWM1yXN7kwb0LFhSs0rnztQlQsTRxhK/wYU76
	 s3HNbVT9S6htzjOSyrA2Exvb6Jg44UZMlxWlXzaesVddxPIqenY4heH0E/jPhNBMyD
	 Wq+6dZgV8XiRA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 04/10] mm/damon/core: add damon_nr_regions() debug_sanity check
Date: Sun,  1 Mar 2026 09:43:19 -0800
Message-ID: <20260301174327.76849-5-sj@kernel.org>
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

damon_target->nr_regions is introduced to get the number quickly without
having to iterate regions always.  Add a sanity check for that under
CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 92eac5eb96026..2b5aed89d449d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -545,8 +545,27 @@ void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx)
 	damon_free_target(t);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_nr_regions(struct damon_target *t)
+{
+	struct damon_region *r;
+	unsigned int count = 0;
+
+	damon_for_each_region(r, t)
+		count++;
+	WARN_ONCE(count != t->nr_regions, "t->nr_regions (%u) != count (%u)\n",
+			t->nr_regions, count);
+}
+#else
+static void damon_verify_nr_regions(struct damon_target *t)
+{
+}
+#endif
+
 unsigned int damon_nr_regions(struct damon_target *t)
 {
+	damon_verify_nr_regions(t);
+
 	return t->nr_regions;
 }
 
-- 
2.47.3
