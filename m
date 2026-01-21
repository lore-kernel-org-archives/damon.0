Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8972DF6E6;
	Wed, 21 Jan 2026 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957564; cv=none; b=JtnQjfgfbIjefcS1Hx7zgyjGhtFbiGsFW+HyruYCGFKHxrs5LXxfF+WrCJoA6lEuPNt5d+MfRgEM80ZInkoQTvrQvC6+CKaHGupbGEs/4zjGQZkNLUg0tMWy24K4Q2sbUBvjNcuICjx4yx+GtbovGVXpDxGVB2C9OOLwLtT1/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957564; c=relaxed/simple;
	bh=bkL4Csv1J5fCFB1J+012eueI1I23oMHM916g85OSop0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxSCOVjpODNddF064ehpyIMnvyLHkOzJi3CYNmnUCinu/3QUx/0ASgGpdrPjnxNlh4z+kv9z/4I38Eg2VeojiTVwt+HahbjbSL0mzypnKB2RspOYyb+9e83irb8ohTmTkx5O2fBaWAKpy9oZI0hcnvZsv3Dq0KJquijzPQW9aeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZm2P7eG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZm2P7eG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89CBC16AAE;
	Wed, 21 Jan 2026 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957564;
	bh=bkL4Csv1J5fCFB1J+012eueI1I23oMHM916g85OSop0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZm2P7eG9TiYxTm2SwW+UZmA+Zfyu/kR+AoePx5xjasQvTpS36JtB1wHgsMbONQK+
	 DZh0Hhkvz6NOwJkBw0CntMqFl3dAjFgtitjmXqL7d8ITg/9usLbj8Ql3u9t1ZIXub7
	 /jd67LNr5LkbDW9NFATMG18Uw6LrBGO6V0tjYbiQyGy2FfWhv1jUEVI+ehdDgPG/ID
	 5YiUo9hoYHPN86OZ0VIDs0djpy7BHk9/qbGoJ9xYTBsgWMMjzAwpY7RoMhdI0QBkO/
	 dZdRnAGD3lGPwuvX1WJr4xwOZWr9RO+X6/H61Wu8Icaq0EBYWAh/xk2H5eXO/X90AR
	 2yYQfb+ag2CAA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure
Date: Tue, 20 Jan 2026 17:05:56 -0800
Message-ID: <20260121010556.121990-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026012014-pesky-canola-55d1@gregkh>
References: <2026012014-pesky-canola-55d1@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a DAMOS-scheme DAMON sysfs directory setup fails after setup of
access_pattern/ directory, subdirectories of access_pattern/ directory are
not cleaned up.  As a result, DAMON sysfs interface is nearly broken until
the system reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Link: https://lkml.kernel.org/r/20251225023043.18579-5-sj@kernel.org
Fixes: 9bbb820a5bd5 ("mm/damon/sysfs: support DAMOS quotas")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 392b3d9d595f34877dd745b470c711e8ebcd225c)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index d9e01648db70e..4eb2328340609 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1606,7 +1606,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		return err;
 	err = damon_sysfs_scheme_set_quotas(scheme);
 	if (err)
-		goto put_access_pattern_out;
+		goto rmdir_put_access_pattern_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
@@ -1633,7 +1633,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_quotas_access_pattern_out:
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
-put_access_pattern_out:
+rmdir_put_access_pattern_out:
+	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
 	return err;
-- 
2.47.3

