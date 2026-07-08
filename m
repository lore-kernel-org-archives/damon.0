Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3221C3B9DA9;
	Wed,  8 Jul 2026 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478947; cv=none; b=oZsNk+jSZgTGgRfaPfyXQyel06whGj4BvLzdfEG0I9A2eilsSsuRHpE3JIuyMlscSUHjEPsRNclWYN8HfCj6iWSgEtBnqr9Rkq3XCI6dKto5uEI59WwFeoK0Ec/kUzcs5MEAG3WWhnhBOjY2jPl1V9OGqgghNIa6fmakDDoNTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478947; c=relaxed/simple;
	bh=AZMJUdVmjm3VM/8AMZAZNtwCMKErBw44WDwuaV8n29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWTqgUnA1Th59sw+w2D6p6SQYIHh7Sgb/zsqEqQqcwRiNPMRxWlPRifxRydDLzoAMB1u0I4Ug6BA5rnqN0kkneZ8IK9NN3oicKWXtGagUhgGKiVF92fcpU3toYrQx6d76YDdfZVY7TRNLbefGfy165gnzgiJIpPBrrI3AP/Zzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQBxiWMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQBxiWMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70EF1F00A3A;
	Wed,  8 Jul 2026 02:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478946;
	bh=FjsCU14SCNwzNXGXZ9ta5DksRZeNC0xj5z1tjd9bQ8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQBxiWMn5csztPVWxR312BoeH8CAJetZe9cV+cunf/pwgo1/exVkg1GkhoSd1pbkm
	 jlFXGA9IKrAGYGEccyfCgeeAg0nMGYwOA7bwkPmDcu92d+hFKFglvS+beTN5aGxHJm
	 nBA27K2XaOHiA4ywfwo8FutH+gRPNZX0VA573iDhHcH/3B50Y9LGXCWc9EWk8fg3V/
	 cypcKhNEbPS2AAa3fq4laHviOS2FVYzm2WCVjcsobvogTbl+R+sBDiB0gCLQ3B+8eO
	 8hm0PqJhaOwFV3uLRoSAWQzH2gvKSpnVP0DBcXL2V/TRJeU5d/2bksNQNAAsRrDEpy
	 jBxdlvT+kPuyw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 7/7] mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()
Date: Tue,  7 Jul 2026 19:48:53 -0700
Message-ID: <20260708024855.116614-8-sj@kernel.org>
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
