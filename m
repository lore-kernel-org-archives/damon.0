Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9CF370AD0;
	Tue,  7 Jul 2026 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399154; cv=none; b=I6ggAhhc4EEjo7iK8hIAuoaq0qKVH7u5JZuXahWShuus4TSVIVFeU/Z0rKRV60xZCk6q1f4Wpt1cLshr6CzPYlXjRo2cIJzEwNkfjnrdlYZtk/pQJVq35C++vHdT183SIHt2xOhKNUk7RwyU1/XLwoq3ke7lcDl9fPtGpCs8Hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399154; c=relaxed/simple;
	bh=b14HA7gblrYPyKxeU6/uEYLXkDHaGcxC8w+RaEWGZXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEz//rF9BkIOvyzuFoyWnxGXor3x1itFqY1UntZgQvPSVcbyyl1gKCQW8TqOdp4kIcR8jZIXWGYslJJCHQkM82QBZyBK8cJVMrS+0NjyxnXzkuF8l/4rEWpNugRt1kSmsS4oraIOzUQIJz18nKLZaQx4obZndggem/+HIqJp+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWdxOzio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWdxOzio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143FB1F00A3A;
	Tue,  7 Jul 2026 04:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399153;
	bh=of1I7i7VNy1H4HcbkZacjpj2gDgZKYHy4CXBT3cnzFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWdxOzioIELdvRfke6rCvGWUZw1AiBWozI4tuyAAqCyO9Impze1PvMdazc8wwPa9K
	 8uwNbmLaJ1knO4sUgxS6VUbUH/ORiSwLRDXJSEu0d9cocw9r9Q1HALpWwSxN7n6RCJ
	 sUib5lLoXtN/zFcvf++7cRTRYIYpgzPZS6GR5IW4ZU5bZdNtaoyaEhFDxodMz5qFzE
	 SCtrLZOdPi7P2LBzW3pm2TfAwSes9+K9OCj5wHZ+J3WpJYfC800l+x8f5FluVMjj8y
	 ZP0ju4KzGNRKX47eNsnD58a4HR0aHDXvyvwtRt7B0oZUINemNmOHZ0q7xL/LNgPVnn
	 VZwAIkkzt5IHw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/6] mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()
Date: Mon,  6 Jul 2026 21:38:26 -0700
Message-ID: <20260707043828.97900-7-sj@kernel.org>
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
