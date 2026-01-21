Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0F28850E;
	Wed, 21 Jan 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958033; cv=none; b=qi6sGlKSYw0jxM7pORNa4etKcbZtlKWYRhk+elW1o5GBbMKv/mCrM3+8FPP5vkNF1xTZnHfBZOnrxmfNzipeeQ6CkX8GNroz+kpJGO6NYEsTP8w4RtbdoadcgkqSKTI8bH8u1XMM9TSGxqaNB9Jt+yML9Itv91gV/QIgBUoYpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958033; c=relaxed/simple;
	bh=uai1Xw1Kf9LGCGIchC0ILt4/1gjQzAIUN9i0sIXflfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6w1Enof0Xb6AeE6SJRVxRwPIJ24vA1buMwXBl7kpNVngp+xml69SG5RgXHXpVNvFU77pwENJbsN9BoMdEowtEorLGShSx/J4UEbPFGkmjRNEqzRGDgSKuRPGUiqer1hsh/DNUQ2sVKEwCmsb+csnkf9jnko/HgL+piD7ETO7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGkKHZqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGkKHZqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BC0C16AAE;
	Wed, 21 Jan 2026 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768958033;
	bh=uai1Xw1Kf9LGCGIchC0ILt4/1gjQzAIUN9i0sIXflfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGkKHZqYlm4D47FY3yLAV8d1VrfnlSH8TUtjCRERPXr/x+PmykiI8VCGS/HoN8Znx
	 KZ6b0SHre3MBwBa0kT5Zv+aybKLxvKIT6DaeqIMkM4NW6orcm6PtAW+1Wv8+YyFUsZ
	 igKjEGqBbnHXAhNqIsPNau/8BTJIywhr5jPTqfGqPklqXU+Zil1cX2S1SAsZmKWdL0
	 A9fbtK3kG/z+WWf+RwAD57j6F0gD1Ej0x9e03+XEwih/qymlHLGRZivtlD8fDYAqIf
	 hU5Sf9QQJScB2nO+oe3tAzRBvXGek1AFBAPanItRuREhk8VQ3l/g6aoqpfwKRip4HV
	 qOReeWvawySJA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure
Date: Tue, 20 Jan 2026 17:13:43 -0800
Message-ID: <20260121011343.164810-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026012001-thud-campfire-994f@gregkh>
References: <2026012001-thud-campfire-994f@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a DAMOS-scheme DAMON sysfs directory setup fails after setup of
quotas/ directory, subdirectories of quotas/ directory are not cleaned up.
As a result, DAMON sysfs interface is nearly broken until the system
reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Link: https://lkml.kernel.org/r/20251225023043.18579-4-sj@kernel.org
Fixes: 1b32234ab087 ("mm/damon/sysfs: support DAMOS watermarks")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit dc7e1d75fd8c505096d0cddeca9e2efb2b55aaf9)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 19d661889cf79..7e65223d63ee6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1287,7 +1287,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_access_pattern_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
-		goto put_quotas_access_pattern_out;
+		goto rmdir_put_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_filters(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
@@ -1308,7 +1308,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->watermarks->kobj);
 	scheme->watermarks = NULL;
-put_quotas_access_pattern_out:
+rmdir_put_quotas_access_pattern_out:
+	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
 put_access_pattern_out:
-- 
2.47.3

