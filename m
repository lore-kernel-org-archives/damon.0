Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD722652D;
	Sat, 12 Jul 2025 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353216; cv=none; b=e9k1+wXh9lgOMIAFRRJ38PFW2YUDNZxIBC/q4VHKfcwGEiVSNlkiq1e1MZx3lY+cx1yBWD2MKBWjQZShEQqMSUz9X3hMOEnVX3M5xb63FMR9r4r6er6xBd2lRkS6tZgbW/ePusX81OxGZbWv2QYDvS6ePbQFVfs8oGl6vqu8KjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353216; c=relaxed/simple;
	bh=SptuOd03XywpvQiMEZUPNF5dCaw77lP6zwsmYKtYbTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQO1CBV+8GbXwU3s/rJ+8VG71U1oEPz8GNXWR+CCvtyXx3/Y5gRVFIRXUZX/Ow/l/9mqE1PfITx6g5L3acbs+MiZnXvedGrLZLcZnmzzKcLN74vSWgF6K3iUU0mXN7/gRqtazTrbaJXCZfwcHDu4wYHpoBPNAmaTNWO9FRAxzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQSKUBSW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQSKUBSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5373FC4CEF6;
	Sat, 12 Jul 2025 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752353216;
	bh=SptuOd03XywpvQiMEZUPNF5dCaw77lP6zwsmYKtYbTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQSKUBSWj7FE+BZxkssA7T1mqK6ihBu5tZunnOUDyBPn263atqFNj3tnXfZPzNghg
	 0lLnzar8exVzdM0OMDrXbJOX5yguhctT0z3hAqhln7S2xbMDnnIvm1ionsTVNO4GcQ
	 KDfUhRzZ04BF37p1t+fDt/ORQeHv5TFZE/7jLa2jQ5guGZyysSg2pFksub94/rGAy9
	 2lFbSvJbSt3JNeYn3uPFDvYNZfTxr0kXG9aNydGKk9MdJD/UUX4/Mu1QmKJl++P0bZ
	 /UotQA9xo9avwGst7iZONhMjMm3kz6QuYlNDLUw9NqQc8KmC3r8zCXrsLHdSEIOHHF
	 ZKzAJbCGVRR6w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/sysfs: implement refresh_ms file internal work
Date: Sat, 12 Jul 2025 13:46:47 -0700
Message-Id: <20250712204650.155988-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712204650.155988-1-sj@kernel.org>
References: <20250712204650.155988-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only minimum file operations for refresh_ms file is implemented.
Further implement its designed behavior, the periodic essential files
content update,  using repeat mode damon_call().

If non-zero value is written to the file, update DAMON sysfs files for
auto-tuned monitoring intervals, DAMOS stats, and auto-tuned DAMOS quota
values, which are essential to be monitored in most DAMON use cases.
The user-written non-zero value becomes the time delay between the
update.  If zero is written to the file, the periodic refresh is
disabled.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 4296dc201f4d..6d2b0dab50cb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1509,6 +1509,32 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	return ctx;
 }
 
+static int damon_sysfs_repeat_call_fn(void *data)
+{
+	struct damon_sysfs_kdamond *sysfs_kdamond = data;
+	static unsigned long next_update_jiffies;
+
+	if (!sysfs_kdamond->refresh_ms)
+		return 0;
+	if (time_before(jiffies, next_update_jiffies))
+		return 0;
+	next_update_jiffies = jiffies +
+		msecs_to_jiffies(sysfs_kdamond->refresh_ms);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return 0;
+	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
+	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
+	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
+	mutex_unlock(&damon_sysfs_lock);
+	return 0;
+}
+
+static struct damon_call_control damon_sysfs_repeat_call_control = {
+	.fn = damon_sysfs_repeat_call_fn,
+	.repeat = true,
+};
+
 static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_ctx *ctx;
@@ -1533,6 +1559,9 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		return err;
 	}
 	kdamond->damon_ctx = ctx;
+
+	damon_sysfs_repeat_call_control.data = kdamond;
+	damon_call(ctx, &damon_sysfs_repeat_call_control);
 	return err;
 }
 
-- 
2.39.5
