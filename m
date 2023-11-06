Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B129D07
	for <damon@lists.linux.dev>; Mon,  6 Nov 2023 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyoPvSX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15AEC433C8;
	Mon,  6 Nov 2023 23:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699313651;
	bh=MtIChiGlAMl9WTJvVSRQmuDT6RxSD+NBrsKsO1Hl6Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyoPvSX0uc/PWJFKoa+VUDxKq/E/FXknGdVXc5LledMo3lXe9IT0oRt5RQemS8eDn
	 ofZwHuP518ZGSpd/p2iBOmqYK51qD8Jfy+GUrzPHxN3Efbc12q8lf3CyJVlx5SCaeE
	 yyTR10BkFHQeE4KhahwXsPuOaDPe+rBdNAWYOwCW6mxNfkOc3H8kz/nw9ziN3Td/B8
	 ccVLiR9YzBxtkhVjVtOTIIqYPB4+2MiBrqNyFMGGVzs2/Q+OeJiPYZYodODtGKExOQ
	 eRaMsQXN36VQLRMi6tPFYVJJYI+AA75HN3DJf9l/fg/xDKdWUtd7iRuYq0d/eUxfZz
	 YOYXIHDrJhrhA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] mm/damon/sysfs: check error from damon_sysfs_update_target()
Date: Mon,  6 Nov 2023 23:34:06 +0000
Message-Id: <20231106233408.51159-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106233408.51159-1-sj@kernel.org>
References: <20231106233408.51159-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_update_target() returns error code for failures, but its
caller, damon_sysfs_set_targets() is ignoring that.  The update function
seems making no critical change in case of such failures, but the
behavior will look like DAMON sysfs is silently ignoring or only
partially accepting the user input.  Fix it.

Fixes: 19467a950b49 ("mm/damon/sysfs: remove requested targets when online-commit inputs")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Note that yet another fix[1] should be applied before this.

[1] https://lore.kernel.org/all/739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain/

 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1dfa96d4de99..7472404456aa 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1203,8 +1203,10 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 
 	damon_for_each_target_safe(t, next, ctx) {
 		if (i < sysfs_targets->nr) {
-			damon_sysfs_update_target(t, ctx,
+			err = damon_sysfs_update_target(t, ctx,
 					sysfs_targets->targets_arr[i]);
+			if (err)
+				return err;
 		} else {
 			if (damon_target_has_pid(ctx))
 				put_pid(t->pid);
-- 
2.34.1

