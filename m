Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A979F3
	for <damon@lists.linux.dev>; Mon, 14 Nov 2022 17:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D419C433D6;
	Mon, 14 Nov 2022 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668448567;
	bh=N9oaQLJ/H/5suT+aYI93l3SxuUN2llh0pwyp5hPH95A=;
	h=From:To:Cc:Subject:Date:From;
	b=VPDdph3yhsmenWyM2ySHp62SlHm6XzYCbqg2d1pxHnfje1jIwGLxYu2frpBwU/nvv
	 5Ui5rUT3h+R+z09f7+AANzOfImaER/8vsVLX1byqpZTOiFwcaXJlApgw/NEQ4AKlV9
	 d0nieJodBldt1DrEzIqgF0TWy84OU+1TOUQKT3kxCVyYv/qLY9B16oALt6fCtTKftU
	 K2sGh53Z/khfGI3Q1pDzQhtJ85pUAARMyQvRgsz6HRzmEKsZWxvGFcY0iMynrYOtlc
	 LVAh3/+wJvhoQYCSylKolVcBiIguTtHib9pp5QliaSzQRTGTX7h9KPQzsBDhsEcLDN
	 epRYjoRIEvLdQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs-schemes: skip stats update if the scheme directory is removed
Date: Mon, 14 Nov 2022 17:55:52 +0000
Message-Id: <20221114175552.1951-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON sysfs interface user can start DAMON with a scheme, remove the
sysfs directory for the scheme, and then ask update of the scheme's
stats.  Because the schemes stats update logic doesn't aware of the
situation, it results in an invalid memory access.  Fix the bug by
checking if the scheme sysfs directory exists.

Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
Cc: <stable@vger.kernel.org> # v5.18
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Note: There are DAMON code refactoring patches in mm-stable.  As the
refactoring changes the code that this fix is touching, while this fix
is for v6.1 hotfix, this patch is based on the latest mainline, not the
mm-unstable.  In other words, this patch cannot cleanly applied on
mm-unstable.  You could get this patch based on latest mm-unstable via
damon/next tree[1], though.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tree/?h=damon/next

 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 9f1219a67e3f..9701ef178a4d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2339,6 +2339,10 @@ static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 	damon_for_each_scheme(scheme, ctx) {
 		struct damon_sysfs_stats *sysfs_stats;
 
+		/* user could removed the scheme sysfs dir */
+		if (schemes_idx >= sysfs_schemes->nr)
+			break;
+
 		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
 		sysfs_stats->nr_tried = scheme->stat.nr_tried;
 		sysfs_stats->sz_tried = scheme->stat.sz_tried;
-- 
2.25.1

