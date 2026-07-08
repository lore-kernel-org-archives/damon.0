Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DD3A7F47;
	Wed,  8 Jul 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518861; cv=none; b=RAid1W7/P45lacPqb+7tbvdxH0uR2x1bGf2D0DyMV6oO+Zve5gzhftSm2kvQ1OJANDmx3oOAnJrB0p0SDe4l5DkDD3rJywps7kKh/3xWwVBlaor3vbuc3aGlZ0Bk+UXfmQUqE255OAHyr0QSagItfYEjk+/lFP/Nr0//60YC1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518861; c=relaxed/simple;
	bh=AZMJUdVmjm3VM/8AMZAZNtwCMKErBw44WDwuaV8n29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOp9SCxbEoZ+CbA8dpGlKFQglmhgqEH0359EI5wyQ0cs6sMA+JXVWv4LERoJ+saftmZKIAZJorZ3579UPRLVcvEqZl63nPCKfEwwLvCxw5SVkCRXrawzQwsc1BUyMvylOhFQf1MHfSgiY0GK99wDo6xa4Lqb3z4xf6bxZaD2OxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/nLD9o/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/nLD9o/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDD91F00ADB;
	Wed,  8 Jul 2026 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518847;
	bh=FjsCU14SCNwzNXGXZ9ta5DksRZeNC0xj5z1tjd9bQ8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/nLD9o/Qjh5tLPHZqt1VNLZ0pYci7WKgWei0fOiiIL7v1uDHsi+1JOGmXBNrP8yb
	 Qor5+oDR4q2k7eAAeiKqlYmxFX/4KaYFrj3khAxKzgyMXpGgjxZ4oXkYd9xJ11f7NU
	 pbON4T27mUBQPijrP08XfiB3jzxwCUOejAyzlTgeOB2Avlq7BAyjHDOpmXETx1reCb
	 Ihj58yCh7axxdgD/EsifvO694uENNrVq4k4zNTLOFgJyKDiHKFmMQE8duZNSHk3B8K
	 gcD5fkpWvgwD/64QMNhyE6rp90INaypFchsMXJlWgP1omWbfeWjhXZ1hYUK5FHx3Jr
	 V2k1nP6Z0/W6Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/7] mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()
Date: Wed,  8 Jul 2026 06:53:57 -0700
Message-ID: <20260708135359.122587-8-sj@kernel.org>
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
