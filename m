Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEB33F37A;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115676; cv=none; b=avIyBwvSwen7++nusbK8MGJz86kdcSXmYCX++72iY1QWFvBvxFPqIR2nBus5UahIZgVyb93clZR4i2lsv9+yPdQ7OfokHzGz48LiGr37EPZALqnqprMzGokOF0T6GyAEcKhy56xlpKmbgbqqBhym40Ys95O4dJmDwdDFqtVQUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115676; c=relaxed/simple;
	bh=ypF4xKp6F1pbIquY3/unFTj0ZaJ4QsmqDevrapmiqYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9mnHL9vwXoYrPQ1rCnCEPnsy4Wys8YQHPTt3eAKI8QrgTHAZacd0z6e11Vgfw0T/Kn94dJJRLTjlZQcKSxdiIK6xdTp5G/ClK48koTXEA41t7Eqqj8tQAj20xMeqR00ZaDMZQJ3t2dyYxZTXg2lJFWChQBENcEOJadMuQe9cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPBqAj1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPBqAj1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E350C2BCB4;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774115676;
	bh=ypF4xKp6F1pbIquY3/unFTj0ZaJ4QsmqDevrapmiqYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPBqAj1UYUg3nMWYne8Sya+MKgu4V7EeGKLthl0o51iCB0NAPgs7sQgaXh4Xw8fds
	 2SU98NaNJ6MzubLEcUwGsVNIrEl9fomH6UIR1GjgcAr0qzkjoKQCVU3SbfxYkY2vZ/
	 uf2IwjhSs2FLSovNyLMfQUDal9VQijGA5yBmyICBzrzdUi/jhDx/WSjrYUnfLhsc3c
	 D0pPtbGN+xU9+tIGrC28zdpiWLbAFzGViZZ1ZbQB7/Z96r9ZVuZAw9JzvYt0FBTEXj
	 82ykqjvPVIW7xc+YYHt+LiyuD28YP5oqnjg/0115RkfzVYi01+0926YFH+/QpJMhFr
	 WpIlklGViaYsA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Sat, 21 Mar 2026 10:54:26 -0700
Message-ID: <20260321175427.86000-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321175427.86000-1-sj@kernel.org>
References: <20260321175427.86000-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

damon_sysfs_repeat_call_fn() calls damon_sysfs_upd_tuned_intervals(),
damon_sysfs_upd_schemes_stats(), and
damon_sysfs_upd_schemes_effective_quotas() without checking
contexts->nr.  If nr_contexts is set to 0 via sysfs while DAMON is
running, these functions dereference contexts_arr[0] and cause a NULL
pointer dereference.  Add the missing check.

For example, the issue can be reproduced using DAMON sysfs interface and
DAMON user-space tool (damo) [1] like below.

    $ sudo damo start --refresh_interval 1s
    $ echo 0 | sudo tee \
            /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts

[1] https://github.com/damonitor/damo

Link: https://patch.msgid.link/20260320163559.178101-3-objecting@objecting.org
Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ddc30586c0e61..6a44a2f3d8fc9 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1620,9 +1620,12 @@ static int damon_sysfs_repeat_call_fn(void *data)
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return 0;
+	if (sysfs_kdamond->contexts->nr != 1)
+		goto out;
 	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
 	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
 	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
+out:
 	mutex_unlock(&damon_sysfs_lock);
 	return 0;
 }
-- 
2.47.3
