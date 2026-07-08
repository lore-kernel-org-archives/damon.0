Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAF3B8D4F;
	Wed,  8 Jul 2026 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478946; cv=none; b=Rxz0y8ufhjjWmgn/7aLs/yuzi52E4oU+v7X1xc7R8VZU94BKXLkzBUgjwsKv0Ed6f/DFAh3nzphgtBlVAV+bqOgYITXFnUk0R9z6kU4t/WQE3IYjcl1CcPnuC2u37pbxSEYDSKzU7VpSRUg9wKGWG4F+9/GWo6Zt2H7Kip2VfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478946; c=relaxed/simple;
	bh=CA3rHKuklf1XaqHmiBcK4sSwz3W5ikEzu9SH+kxW3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilzSeNk/CpBfazUjiVJc1gDIiHACUTXD9O/+CX3X13iyKp80Aqe9NiLEQSPqb05B9eFLZhQGBt9aYnmNGs1p+szNuxRz991CPKIeoHhvOZKSDHlONZ9tLVh4rrFGjtgxWFKqNUQEEyHOuwHvo4lvJGed9Rpk3v9bSFhwe9NwVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfL+YIcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfL+YIcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA71F00AC4;
	Wed,  8 Jul 2026 02:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478945;
	bh=rYlq3Lp1htxNcYc9q0Uy+3l1xL/3ejGhpOTnhJctTfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UfL+YIcWndxSNHboQ601wL3Fv99hU+twcCWNkYprhfI0RE1bG7BvYOfWpc7RckcqW
	 W+NRmg4n1w+oyR/YPFTK3bCgvgRJYA49Prc7G2+tnXyxw+PDF1Q1EaCMB7Se3fI8Pn
	 /79HCOMd0gehsSmzeZJvClaaTL98cdvhH2OCootY2BqeK3pWObKNaXPRzYhh0b/J65
	 mOHK/HCC6lHcpKRWZHGbyE1gn7ua/M0mfiDP4YhWmK4bmNUk/dNkSiDQd33PZwt66I
	 RwZgZ8bS0eeHTMeeIeVthYoiB+6BPlP9Kkx9pHQyB9r3AzhFoOg3E+MQ0YS83eXyA3
	 O3YKFOVG8gVCA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Tue,  7 Jul 2026 19:48:51 -0700
Message-ID: <20260708024855.116614-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708024855.116614-1-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_for_new_attrs() can be used for not only nr_accesses
but also any positive sample count, like probe_hits.  Rename to be able
to be used for such general uses without confusion.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 718268df27fa7..800ff6b6d2473 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -890,22 +890,21 @@ static unsigned int damon_sample_count_to_bp(
 	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
 }
 
-static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
+static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
 	return damon_sample_bp_to_count(
-			damon_sample_count_to_bp(nr_accesses, old_attrs),
-			new_attrs);
+			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
 }
 
 static void damon_update_monitoring_result(struct damon_region *r,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
 		bool aggregating)
 {
-	r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
+	r->last_nr_accesses = damon_nr_samples_for_new_attrs(
 			r->last_nr_accesses, old_attrs, new_attrs);
 	if (!aggregating)
-		r->nr_accesses = damon_nr_accesses_for_new_attrs(
+		r->nr_accesses = damon_nr_samples_for_new_attrs(
 				r->nr_accesses, old_attrs, new_attrs);
 	else
 		/*
-- 
2.47.3
