Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78077371897;
	Sun, 21 Jun 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078166; cv=none; b=TO9auC1J/IRjgFDeY6s7dD4xedForj9JypZLkrObDCNPBeOsjiE/OrlwYUxScXouK4x4r/eeU8YA9NyJ1GyzVwQU7ge/+nisEBiSoCuZ+QDhyn417LwYOc+HtWT01qKPuR+9OUOigLJdc1T03z1CVDFKgurY//g8q+m/x7RV4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078166; c=relaxed/simple;
	bh=50xxId7h5vuvUJ9wLvfwu221Tn1AbB2vC5bP0vZNzls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3fV3hqQIXFYNtpv2etsagolysbcEjEzNzrpjRehJ3EdOOX4LyJO+XCKD/ZwmqjTOEdmoB0X/XOggqVeYnosvPAPzkaBF5sSrkcjcK6+r9Or+je2NXldIVmQEr8UeLouAh0CLrAGyVwYB3deeTNYLrxbz9qdIrBEhIl7hKORyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4A1txxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4A1txxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3B31F000E9;
	Sun, 21 Jun 2026 21:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078165;
	bh=lL7MHFsV5uVbpGE1PaL3gylfP3s1otTosgqDG8rU960=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4A1txxwMvBfs++g0T5ekr+cWkOtMglqGA+8dqeDI7JhTpgvdYtyQMXEMxfwBHTsE
	 QldGqBauTEPzL+uH+Mq1fJAo+OFRjix9eDmS4kMXzZUXzx+VBBYDiaFr1/7W5gblv6
	 lGfG8JrgO0w/OTK7LyRT6+uL6I5ZjqgsNnFxmHGgvucvPHH+7EYQ5UbH1i/hd/3YyA
	 aLZmkYZTWDJ/CM7MdnxXX3a1UGI5jvRdO8PEDF4gBiZ51iTmUTY/ClPQm0tVZwnhyx
	 mifdTH87aVbbjBUmovsuMCklPTRogD0SllDK9ceEDuxyUDIj8dEcHOe7O4XqIlwyYX
	 ahk2rnJcSl/CQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/3] mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
Date: Sun, 21 Jun 2026 14:42:30 -0700
Message-ID: <20260621214231.13449-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621214231.13449-1-sj@kernel.org>
References: <20260621214231.13449-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface exposes damon_region->probe_hits via probe hit
files.  Because the counters are completed only at the end of the
aggregation interval, users can show incomplete values if they requested
the file content update (update_schemes_tried_regions command) in the
middle of an aggregation interval.  Set the value as the pseudo moving
sum value of the counter, similar to that for nr_accesses.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 30a007bcf82f4..06ebf381c32b6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -112,7 +112,8 @@ static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
 		struct damos_sysfs_probe *sys_probe;
 		int err;
 
-		sys_probe = damos_sysfs_probe_alloc(region->probe_hits[i]);
+		sys_probe = damos_sysfs_probe_alloc(
+				damon_probe_hits_mvsum(i, region, ctx));
 		if (!sys_probe) {
 			damos_sysfs_probes_rm_dirs(probes);
 			return -ENOMEM;
-- 
2.47.3
