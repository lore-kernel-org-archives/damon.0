Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58542255B;
	Tue,  7 Jul 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432257; cv=none; b=Zd76MiajedH32xfShuflztUZ2C4h96R8em8eSUAaKNUxyZoyNGRiBVTG7Se5WICdY7QbJEO/dzDbP5ADer6BtsUpcayvB5IFIjnO+dtmQOEH2M/KwtAa1fLrSosC3miIlPJ5wP+91/OebUIA2coQSF5vqzTK2vbK4cXr0fNXXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432257; c=relaxed/simple;
	bh=b14HA7gblrYPyKxeU6/uEYLXkDHaGcxC8w+RaEWGZXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfRcJFLYg4wxx6pQ7SDHVO81po8zfkflamRNADGsKZxbODv9rsjFIXcjndE4VrIT0+tb85dyw+/VDtNSVwT4I+oLANZAgNQBnWPgyHuwIodh5DDQAyGkJUNjwBNaBUWW2k4LvkZOygQyrAgB0b2j1pzHioYxKWOM4TEu9ZO5w+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjX3EsM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjX3EsM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877081F00ACA;
	Tue,  7 Jul 2026 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432252;
	bh=of1I7i7VNy1H4HcbkZacjpj2gDgZKYHy4CXBT3cnzFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VjX3EsM2q3k/yVDTb4quyBr7dla8OOF2eiAEjfDZVvm5y1fbKAywgE8luHEFR4vX7
	 Bog2C1GMW1QW+vQlw8XW9EfGQFhCcGvK0kS33yuTn9LiBaw4Xz+fJ0yCYCpdWxIpB1
	 Arq8pFkyxdL33w2rKb6m7t8cE1SgcSJvehV0OvfDKOgBBPXinlnt0MqbZ24yimKmmm
	 S/fjhu6lK4TovG5pVhJw/TRaJjHzSpj67ipJlxq+FF7b3P+pPNPFVE5fz0csBJbRD4
	 SV/yfEj1dXrNa7CZabwnujff4MCN18GMuysHrHxyTurvjIe4WMP/RcFKco9WXi3ztE
	 +wsgRQWVfA/BQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 7/7] mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()
Date: Tue,  7 Jul 2026 06:50:36 -0700
Message-ID: <20260707135038.90068-8-sj@kernel.org>
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

If damon_update_monitoring_result() is called at the end of the
aggregation interval, probe_hits is not reset.  That's because the value
will be exposed to the user via damon_region_aggregated trace event.

Meanwhile, damon_probe_hits_mvsum() can be called in this state.  Due to
its logic, it will return a value that is incorrectly high.  This could
happen  if the user requested DAMOS schemes applied regions sysfs files
update exactly in the time sequence.

The impact is minor, but better to avoid.  Check the timing and simply
return the fully aggregated last_probe_hits, like
damon_nr_accesses_mvsum() also does.  It is not 100% accurate since it
is the last interval's aggregation.  But better than the value that is
completely reset.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9a3ff0fe55a61..093da5c0b3693 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -290,6 +290,9 @@ unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
 			ctx->passed_sample_intervals;
 	left_window_bp = mult_frac(left_window, 10000, window_len);
 
+	if (left_window_bp == 10000)
+		return r->last_probe_hits[probe_idx];
+
 	return damon_mvsum(r->probe_hits[probe_idx],
 			r->last_probe_hits[probe_idx], left_window_bp);
 }
-- 
2.47.3
