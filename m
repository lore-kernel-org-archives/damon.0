Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD7369972;
	Sat, 16 May 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956654; cv=none; b=rzufy7DwvBNySZW2ZBN0T1MZXLgXqoFdFvTV60MVaO/33haii1FBALQiij7ROpeUbPwwU1t4uRpGMmGtj9YgpaA09grcqmwLucYbCh/8corOCJt3agzIO0kcyRJWx4AH23q/m4wgSPzFy3EZzuwTkYAA20u0PEEj+St8DT7Aj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956654; c=relaxed/simple;
	bh=Ee2xBoGCN0q1MWtaUMmJevs875atGOk3HcGVOqqc1ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/jiQsixCEYCKHMbdgO561717MkR16+bPaJ5eXUS4NejBVSJS0RVSzobTbZhibjIus1cTWb0F4v1UWP2P8s/8yBEamLJwpQatHMs/QPNUOgWzjWl/mDg6og7cCLm5ZUglOpDF270lfC8OMahGKhPsceLqOdQtOeyY30RVqM0jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3DBAiVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3DBAiVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE5CC2BCC7;
	Sat, 16 May 2026 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956654;
	bh=Ee2xBoGCN0q1MWtaUMmJevs875atGOk3HcGVOqqc1ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3DBAiVJ3MOyg5p0ljt6P9bUyfyf8BBFbPeh3n5Hz8RWm6bVS8C8H4CN3aImIdGLu
	 Ng9P99XpRtd/lXcJ/cnoA4kAL3KfJ4jiNmTsJ5rY56oaBM7uhuVE5W1Ied2qEvE3bk
	 vJL5cazGQqPsXauaqrlwIfjModk646fKHHu5XMhXKOVdmon7XbfOmWuFnbZpN2pdKD
	 qYfFl+G0V0MMAGymoj9JnCGhK0MkS6J8WhNx1iR7A+32rw0oY4vs8lovEw2B6CIH3D
	 RDEodlKbeKiWmqqnRktIL7jb4GmQ6e1V8KacGiAzUNzBAQfmn+pNT38cV8w/4JrEHm
	 tNyY90IBq7zbA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 26/28] mm/damon/sysfs: setup damon_filter->memcg_id from path
Date: Sat, 16 May 2026 11:37:07 -0700
Message-ID: <20260516183712.81393-27-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Find and set the memcg_id for damon_filter from the user-passed memory
cgroup path when updating the DAMON input parameters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  2 +-
 mm/damon/sysfs.c      | 11 +++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 56a76781fde22..cd0c352a777dc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -976,6 +976,7 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow);
 void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
+void damon_destroy_filter(struct damon_filter *f);
 
 struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 332d13d9f8603..b8fe4320c3da8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -139,7 +139,7 @@ static void damon_free_filter(struct damon_filter *f)
 	kfree(f);
 }
 
-static void damon_destroy_filter(struct damon_filter *f)
+void damon_destroy_filter(struct damon_filter *f)
 {
 	damon_del_filter(f);
 	damon_free_filter(f);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 2df1d670ee77d..8f927e3dba827 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1897,6 +1897,17 @@ static int damon_sysfs_set_probes(struct damon_ctx *ctx,
 					sys_filter->allow);
 			if (!filter)
 				return -ENOMEM;
+			if (filter->type == DAMON_FILTER_TYPE_MEMCG) {
+				int err;
+
+				err = damon_sysfs_memcg_path_to_id(
+						sys_filter->path,
+						&filter->memcg_id);
+				if (err) {
+					damon_destroy_filter(filter);
+					return err;
+				}
+			}
 			damon_add_filter(c, filter);
 		}
 	}
-- 
2.47.3
