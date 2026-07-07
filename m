Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEF188713;
	Tue,  7 Jul 2026 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399137; cv=none; b=jYR7ss1eM6H3N28X3iNpgblZkMyRkxA7P6SD41Vp0a8MBKb6i5szFHZUNMBjhfzgGy1kW3DYn1D9gY74JRS5aUIJbl+ePYJJanEwTBrEbz20Fox+/wXja+H7Ni0NT9mZ7Zq7KhLYc/Sr2VYO9VT7sUQEtCyCIxAkbSjkALxi4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399137; c=relaxed/simple;
	bh=AhKZVltV6KBr4Ar1OjtqWWq5A96YhecVbYo9SJ3RPvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4W893k3Uj7kUllmrIBkMrNpnUaT9vAyFFrDfEkPPoH1cPBDLTkDq23Pl2J5b2aBT5b5jK8BEbBAu9G3kTu6YxqJ91ssp772KH4S2teQFu3SnnUMfxcxR7fqh2uRRBcPF9UfGy+kD3qWTh4kMLe7hyRMDTld//VlcKeDXszwObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM6yA0+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM6yA0+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8369E1F000E9;
	Tue,  7 Jul 2026 04:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399136;
	bh=I11t6FBnWMZblAU+RqSXZtxGf/n/Ve62MEApJyBiI2Q=;
	h=From:To:Cc:Subject:Date;
	b=mM6yA0+wSaOwfxOsLro7F5LsVoueGmA/4vXvSnJzHVHAfly0zgDiWK0WAzQh4tHZ5
	 tPhn3yyEtyV+eNCkUXKyFSfQy6VyVBCpcWV2PiBpm9fcmd80GLmF0afk174Uwwgb8t
	 4SBTndzXQYACVIDKy5IfnhEQ1blsv8OSU8YJ356nFWtE1IMjnSXMwvreQc9UDWI3F+
	 iuuYZclEy0tLCjg/zFn0luYPtRnZb7K8tPSR5hea9Cbx//N5WU3Zxhf42CFP7nddlQ
	 381Ui99XvxzozE59snxoHVN68OWO8ujvsMVmtANHI1jRt+m80aBUcKY1vzUfdpdGjv
	 DdnQ16c0bRX4w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/6] mm/damon: update probe hits for runtime parameter commits
Date: Mon,  6 Jul 2026 21:38:20 -0700
Message-ID: <20260707043828.97900-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON users can update DAMON parameters such as sampling and aggregation
intervals at runtime.  For such changes, monitoring results that depend
on the intervals should be properly updated for better accuracy.  For
example, the access frequency counter (nr_accesses) is updated.  The
data attribute monitoring counter (probe_hits) is not being updated,
though.  Do the updates for new parameters.

Patches Sequence
================

Patches 1-4 rename functions that are being used for nr_accesses update,
to be able to be used for probe_hits without confusion.  Patch 5 does
the probe_hits update.  Patch 6 update damon_probe_hits_mvsum() to cover
a corner case from the update for better accuracy.

SJ Park (6):
  mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
  mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
  mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
  mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
  mm/damon/core: update probe hits for new parameter commit
  mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()

 include/linux/damon.h       | 10 +++---
 mm/damon/core.c             | 64 ++++++++++++++++++++++++-------------
 mm/damon/lru_sort.c         |  2 +-
 mm/damon/ops-common.c       |  2 +-
 mm/damon/tests/core-kunit.h | 21 ++++++++----
 5 files changed, 63 insertions(+), 36 deletions(-)


base-commit: 9765c7b820c4f11a416d8bc9d402e1914138f64c
-- 
2.47.3
