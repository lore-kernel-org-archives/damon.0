Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B431FCFEE;
	Thu, 17 Jul 2025 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731697; cv=none; b=WwmcNjNj/IEiK1Q0YWbAOnAUKjL5+8IYvxF7wnzdw81b/xdi+L7ogErp7NQAzjweND6wg5HpLZ81Dq5js7qxd4uNvXTdJTGA5/Ae8sPar64SXMP0E1T4wgLA2UZChSc4A6TEq4GGzAUHKR99X9+sn2lBOcLhJgB2fNQQlvK0kOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731697; c=relaxed/simple;
	bh=SptuOd03XywpvQiMEZUPNF5dCaw77lP6zwsmYKtYbTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faczYdlI+wH7NU2BQ/xBy++MapWaVtU4aOcgaBZcMU5xhNQqF0lDDfdB3pQPQ8ynFDjGEXnZ7z+VWDmNwFH07feq+LjGCdJmO/u8Gt3bEwAN48i/Kx1+l5RYntmQ0PFFz4DIH1ynNSIR0mjLWYsT995uU7xsSdOiO4efEVmNa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epeUbFmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epeUbFmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927DCC4CEF4;
	Thu, 17 Jul 2025 05:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752731696;
	bh=SptuOd03XywpvQiMEZUPNF5dCaw77lP6zwsmYKtYbTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epeUbFmQ/7+SSVln4QiwhyN1jZn33rPK4DSg8dSVxBGz87hk/upvmFtYLkVyj5vBq
	 R+l7NeFDJvd5GJLAkTa+BlXOSoO28WutL8vQtQNYJGACPAqhIUN/cMFFSIFb/Z5c+5
	 /uKomWllkvdnojOjc4RZyXY7wKlS5X/lFUiLY3DiPmQg4Tk4X/bwbpiiByP+tl2Gnh
	 RgSwXBQ1we83v60SEVAfBAOAgY9zTJiZT13CZMjDZcayFK7RRU7Po4hywBnheuQ8z6
	 23bzkUToskFOZ+kYVtQd8eVGK/94u/vPTOzYccbA0GWznnPF+SyLpQtROGq1sY2qh6
	 UyF9c7QnpBdfw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/sysfs: implement refresh_ms file internal work
Date: Wed, 16 Jul 2025 22:54:46 -0700
Message-Id: <20250717055448.56976-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717055448.56976-1-sj@kernel.org>
References: <20250717055448.56976-1-sj@kernel.org>
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
