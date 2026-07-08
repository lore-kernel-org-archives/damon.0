Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C53A784E;
	Wed,  8 Jul 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518862; cv=none; b=JifUl1f25kDnX/H1wG+lHwjZHXnNMvbUgT97twIuTQeLMcIH43zmtPNY7650vENSauzEmSKPmGr7xfozAdtcbuxmeqiEzKlwuTvxw5b8Ykxk3PRASsWyDxJ9LcmYLqYcy6ASqnMMmUA60+MN/6BQ7DP53xRbVKepy7QXZLgszgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518862; c=relaxed/simple;
	bh=CA3rHKuklf1XaqHmiBcK4sSwz3W5ikEzu9SH+kxW3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1xXLf0i+tl1+U4mB955WQTXvVtJp3eNnZY+o4aXMTTL3p0W8TVwb4bZeHgesTUuhR6W1ndAwjN3C0IBe1GQHHhLVunyvWpW1m7tsETLp9B2/X795TQhVlnOTNIzCODkWB4bbADLOAPuIfgFCgCfjk34cyACKwSbHMEGJ2+dU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh26RdOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh26RdOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700C01F00A3E;
	Wed,  8 Jul 2026 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518846;
	bh=rYlq3Lp1htxNcYc9q0Uy+3l1xL/3ejGhpOTnhJctTfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sh26RdOyNx2Ib9/YFRg/SCG7vFZKPp8CLnBNfBAApRjhp+NYVy+NW3x5+Uj4Adpil
	 da41HTo417Vo3ilaw2dAmnPjj7oxn/rLthJOkR8k1kOPeTYPeooLXIcLOEUJu0fnwh
	 +Bp9+AjBlGmFdRW4rGzX9ExHFJXPd/gPHRWhUvfXp8RIpwq07mFSrxkGrCerJWCH9u
	 lFR4OYcELwEx+38K3cZMJ3c//aWW4/BAZhtPmXd/FR15rWOafn7VtprafEQ02QxqPE
	 1x1UarV7M4cxDzUGGMSYlVxCDp1sW0WnXnEZwnKiNaOwlDX6tzwwF/T5z+jKeRgKvd
	 VJZZQ4z0kgvTg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Wed,  8 Jul 2026 06:53:55 -0700
Message-ID: <20260708135359.122587-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708135359.122587-1-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
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
