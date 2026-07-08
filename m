Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6B3AA50B;
	Wed,  8 Jul 2026 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474383; cv=none; b=UV+Zdo2D3kbvW8pCcDO2vxRO9XSULRb7P2dNYnhJJkK4eUj/L0qrjAztrMyGfnUqyXcM4xVkSxfP6atEcSPPjlspoIPtA4a/77/qqoGYJqV41GL5oM2XDr3jIdiIRqW8IOKlWHR5xNUwwTv0KJfeOngP1kLyyBLLM5X0JqydaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474383; c=relaxed/simple;
	bh=AZMJUdVmjm3VM/8AMZAZNtwCMKErBw44WDwuaV8n29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBnKTqWpjqM8tn921ia5AoY3Vt7Ixa/PLfTDNRecQQq9K/vHey+j8cxaSYek/JBs5hDSJn1XwgSwkmoa209rEh5fWOW7L6TET1uoZ/1QZaI1j3X61GFSBrXsZfPQivM32kw9HK5/kKs6Lsi5XaXaOgGuZvq7rqxmwxkaVY+y+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXtSayPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXtSayPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7431F00AC4;
	Wed,  8 Jul 2026 01:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474381;
	bh=FjsCU14SCNwzNXGXZ9ta5DksRZeNC0xj5z1tjd9bQ8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXtSayPcIrnTvIdhY8+194PjZp5sGsg8Medv91bhy97ot0hoTraDvNj6fY67jTCty
	 1crqQ1KHRomInq0HarD9mAMRIP6O2ltitsb7TrClu3EKRXJXZtsNmUtIqXsKAIc/60
	 9YNCMrGTDpwghpF3Ij+LGyiCDSA8HvxtXN8FGl6vsS+7KdpwEemGxB3mhzFMBdBQox
	 a77Pv25/e/n8oy0/GGaJI+dj58tYYzMMs+3TP6isNqHNsMbucvMVl8zlYrNQCTl9x5
	 SW7YSmh8DN6+1y59qrNK2RaynXKD1tKyZkDOX/VTiUO+UE8czZbjBL0eOajGc+F3of
	 Ez//E7Q0UPrCg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 7/7] mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()
Date: Tue,  7 Jul 2026 18:32:50 -0700
Message-ID: <20260708013252.95888-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708013252.95888-1-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
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
index 15d31285515d6..11473aa1f70f4 100644
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
