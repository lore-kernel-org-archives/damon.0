Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34A422558;
	Tue,  7 Jul 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432256; cv=none; b=asr2PgbvNp9aJ53kL4TjhNX8OeAxJXw8ASeXf5Jzn0nu7my3PCyBzzHZEkxM18uWfMc96DzcRN7NKXQ9zaIJy5zZfn3ikL232eCeGTV6cyYxvyznJeJtIR79BTjIQsLMGZKkZuvsXPecALSzYctCGG4H5arL1NTcOH8RadLtFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432256; c=relaxed/simple;
	bh=ag/S80pUBX0cJ0sy1fk60k/QmFTUIzlMhxbf8rie7OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUmd/AE4Mg/SVIIrWSLLTH63uwyay0SIJ12799X1eBtOHOwfBw6UGzdWxhBjcp20zEnGJ/6/ydXy80v7MiUqTkc5GtQ+FHOR1TTNHrrCiBHK89uBZJnxZUpDEuJfjzOzsuDgcGawBcx86JPeXEhAAmygy8GT/tii3LNSHBu/9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqgM6oHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqgM6oHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8581F00AC4;
	Tue,  7 Jul 2026 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432252;
	bh=y2nS4ty/xjd06Q+OF1q+BaFHGwsWJWpLHsAguRnNOTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqgM6oHl9dZNqM6aypSOWyCxzCWUqOWcz0OmsFZqyPoPxU6pSNT5yuSjrs2W+iXbe
	 nMZgVHymJxKVkcy9yVLlGNCANbP3UHXunTAXb/EfQqS7OVbQDrVn5yaL5Mdgg0K111
	 wFMgsUCfiGCQeTzk6IGTgHj0GcXZd31SrxojgyswLf1DEjdgFTcRd50WEcCDECZ6ZH
	 ygiQX8rkMDixhgJQ01cPl+kL/kDExO1lEi1SEQG3Tho65XbZ0pJK9WTDZbXfqAviLz
	 Vo0JxbPU7a/n2QB0R3Lsw7hXcH7iCPx9Wy2z3r07ajEHUzU6dgiiAobTMWM4fmdbR7
	 +ZsZMlRb+xdqA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Tue,  7 Jul 2026 06:50:34 -0700
Message-ID: <20260707135038.90068-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135038.90068-1-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
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
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 718268df27fa7..cda318806b65b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -890,7 +890,7 @@ static unsigned int damon_sample_count_to_bp(
 	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
 }
 
-static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
+static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr_accesses,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
 	return damon_sample_bp_to_count(
@@ -902,10 +902,10 @@ static void damon_update_monitoring_result(struct damon_region *r,
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
