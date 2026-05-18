Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5073AD50D;
	Mon, 18 May 2026 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147693; cv=none; b=uV/rm0lUsaBC5Xh7dqlxb7Xv165WQbi/gMCvNWEaxPS+GTDAmz4zTA2Xaa2nUbZEVRTbgJzKRbNVWo/dvVzXOWnLhRVVd0qpBI+NgVjMevnyXqFVVoj89eNFsr4wSfkSaBcOhGLv5FKKwUmYmxVAGTyIJABj7I+YBqufJQoZt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147693; c=relaxed/simple;
	bh=6WMqOvniCqDfChPfJlN5gPjmRV0oSVQC/3h1Awn27/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwM1d18ejvRaEgi9/Nxc3s/hm/DRfRz2MQGlfHkYbWSfRn5kiOL5BZsFqMaTBHy7y3C+HH1zu1jrUc1cRP1L8qRu4esDO9ZSVI5fpkxKUAk4rbq0KZCJde+hLuIGeoFFrXG+rkrjYXoovbVZhyebAkP5wIC5Eo4lioc8tiQLZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx7Y6cJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx7Y6cJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47486C2BCC7;
	Mon, 18 May 2026 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147693;
	bh=6WMqOvniCqDfChPfJlN5gPjmRV0oSVQC/3h1Awn27/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nx7Y6cJyf/Z+FfDkjViLsnVZQjjR/x4a6hle29GtyefXQ8KOem/yZu9D84oeZkCow
	 brJZMwLSkRV1s8PEP7ICJK8cV9yF++/3ijIGWnetTeohbFfslS94JTfBuFhXwrVxT/
	 Frb08HxyZLHkS6S3ta+POYFOs25hy0wZu0f5XGnF4zHqeOSI3E1UrNt9R1S1XLo5t+
	 i1wwT+vcb22AacRZzfhL51l1M/DMvkkOV6n0HZ52/UZn7K8U3rPpL5tyuxPI2Odffq
	 0h3YXuE7nU7USn9cHzsNr3Fhj1SyHj22LCAjZafvWPufwfP9V2+FHWXj54xXvBS7yl
	 VR8Gq+H7tF8gw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 26/28] mm/damon/sysfs: setup damon_filter->memcg_id from path
Date: Mon, 18 May 2026 16:41:14 -0700
Message-ID: <20260518234119.97569-27-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
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
index 6a54c601889bd..4014fd0d463cb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1006,6 +1006,7 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow);
 void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
+void damon_destroy_filter(struct damon_filter *f);
 
 struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4fc90b0bdac88..68b3b4bbc8fc9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -143,7 +143,7 @@ static void damon_free_filter(struct damon_filter *f)
 	kfree(f);
 }
 
-static void damon_destroy_filter(struct damon_filter *f)
+void damon_destroy_filter(struct damon_filter *f)
 {
 	damon_del_filter(f);
 	damon_free_filter(f);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0f6379caf4816..2e95e3bac774d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1927,6 +1927,17 @@ static int damon_sysfs_set_probes(struct damon_ctx *ctx,
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
