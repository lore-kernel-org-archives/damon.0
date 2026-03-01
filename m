Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2463382D3;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387012; cv=none; b=Q3xCHqqnKWUbPa99aDGW3oYmHM1kZZQbXUGe3byvZGM2VCn+7QkRD49A9yY6/44/UBuALlFL/+S7kHCmtfqIoAeoyv8n6B4K88ArlrFvYsC+Gl5JMzjZjCSw5G2hWEHt1FNNKgWP38NbfH4lcuK8L68OUXIpTH6lQUpOmzRLR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387012; c=relaxed/simple;
	bh=lNQhvpFnr2Kehya342ovbJrx9ImZU409SPVoAQ9GUWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnLQCQIFwN9psOaq11dxVZiD7lhb0IPEDlCSecPvhP7qd46twUBwF5XfWu/7qUsk6mryzLYAzGZn4Hg6Fg+4zqsLGJm/73PJlunMy6hht9E6uPvUoHKYy2x40MfCwqCkQLMf3GaFMCwzQ/FZSso99BsMlGc6tCFM77bgHhYKi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueWT0qzR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueWT0qzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A51CC2BC87;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387012;
	bh=lNQhvpFnr2Kehya342ovbJrx9ImZU409SPVoAQ9GUWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueWT0qzREt2g1pwPwkGPIZTz9xG0/SvYZc6z93JT6hmlqnNe6AYJ88hvJ0Osz/ALy
	 E+cT8yCe8UfCarWeZrYCVlEnuy3A19e6v/OvcnyE+UXporJywZr9NfE9RrF4eLTJwc
	 etNMcHNx6RjLsli/LHgiwjSsggUKUZYC8mJbm9sH1AXrL+Xdrc6VP6/3eYKN/J/DbQ
	 Q/oYNIDgbSLdlPdq1fllruUohQUJwpI4brKe/a2JUQwOVpWdVWiwzw3Vs+gqkiptw/
	 9+Yu+VaVnQkXvfJLRP48fFbmGZQDd0+bDYAwQdcIQ5af96N0L22jpZ+SQRCgRvs9CV
	 jmYUV4H9kK0Iw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/10] mm/damon/core: add damon_merge_regions_of() debug_sanity check
Date: Sun,  1 Mar 2026 09:43:21 -0800
Message-ID: <20260301174327.76849-7-sj@kernel.org>
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

damon_merge_regions_of() should be called only after aggregation is
finished and therefore each region's nr_accesses and nr_accesses_bp
match.  There were bugs that broke the assumption, during development of
online DAMON parameter updates and monitoring results handling changes.
Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8a3738a17cdd9..93d1577b1ae07 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2505,6 +2505,20 @@ static void damon_merge_two_regions(struct damon_target *t,
 	damon_destroy_region(r, t);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_merge_regions_of(struct damon_region *r)
+{
+	WARN_ONCE(r->nr_accesses != r->nr_accesses_bp / 10000,
+			"nr_accesses (%u) != nr_accesses_bp (%u)\n",
+			r->nr_accesses, r->nr_accesses_bp);
+}
+#else
+static void damon_verify_merge_regions_of(struct damon_region *r)
+{
+}
+#endif
+
+
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -2518,6 +2532,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
+		damon_verify_merge_regions_of(r);
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
-- 
2.47.3
