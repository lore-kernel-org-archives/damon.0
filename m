Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD4372045;
	Tue,  7 Jul 2026 04:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399147; cv=none; b=fgVWYqlyjKrvJYb4hZ/hvyKm2+MB2QVuB5h67H3it+bTW8Ts7xXDAjEZeDJzZFB3r3fuiSM1mnBcRT9AISYNQDcnCEh9IzfxdjAh6a7JRuXs2W/Tt2vFkSRMrmkg1DPgUOTtlnMckH6SXIObRIiy1SHsIgqROxHPJlAKZtJ1h3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399147; c=relaxed/simple;
	bh=ag/S80pUBX0cJ0sy1fk60k/QmFTUIzlMhxbf8rie7OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwfx/IEfaeOIzxQLA+syC7BtCiPxmuBhd8KvygbXVR/76y/Lm8mxUiMwkULx9fsHUNC2jC/kJ82dK76uAuC7kUYjObGMuofVoxd78uwyI0xCdWjPU+ajp3I0R1I2X7rp7x5WkdrQI89X/UvK6ovJgGtp9IR5pmgZhXlwtHslDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvvPYXoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvvPYXoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC21F00A3A;
	Tue,  7 Jul 2026 04:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399146;
	bh=y2nS4ty/xjd06Q+OF1q+BaFHGwsWJWpLHsAguRnNOTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WvvPYXoHwGLaMwU/YDDfvMgJnz2YbmwsK/bjmEGclsQa3iY3bRjKfo8TVWQcGUfQK
	 N7ftzC8QZfaV6/L9blemJObEPZhrfA1q2ipR1eXVGAAoDFvUFi1PZFD4hnHSQqhKdG
	 P6mYRbYmdg9iP8WC/iBRgG3auxwurNIkaDTvqC1lhRu76TJWEUW85Cx/YDnOy8HP2x
	 kMk5eXyui20Ml2kjj6hU8nEfBVn5jxe0Wz0D7qrjVymBXASvjcvJJ9RDscO073r5gW
	 aKwKRorR89NeWU7fztVXfV1/S2QZy+yU6tV7w0E4uLobm+00wyuwwUrBK56t7j9wOP
	 /Bw2NYGGrjURw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/6] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Mon,  6 Jul 2026 21:38:24 -0700
Message-ID: <20260707043828.97900-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707043828.97900-1-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
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
