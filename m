Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA83CB91E;
	Tue, 12 May 2026 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596628; cv=none; b=c/psAkDwVLQ23JW6hl6QMHB6QiZgZ+DzF4gPTz20+IHWI1mzAAau/eMJ27jT+vb5V6HeI1tbjJ87h7Kg5Vt7Vsey2228TDk0gJj0RMUgtUwL0nSPCGgeOr94+z9nuzLAqXJ+qaZ7EA7FehSZp+S6XA2V/4/lVvH5jwz/e7SMESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596628; c=relaxed/simple;
	bh=cFvp8t6ODEV3JdI3/2xCA29FAtQcg5JdAkWzfAP5fUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mae+yQuryf3d8HKn2SXR6QH/1E6AD1IMIjslvbcAmYy+clAt+2a9ibj/dsqR2UqsnpJEsaP8GVyFBX2XWa1V57eAXFatdld500DozQM8dd1mteWBwuUXD6bPAUPn/nkhCw6fWcEBjn4zFi4DzNZcRkeqLBshEHpkNbHTfertpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXMh6v4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXMh6v4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DA9C2BCF5;
	Tue, 12 May 2026 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596627;
	bh=cFvp8t6ODEV3JdI3/2xCA29FAtQcg5JdAkWzfAP5fUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXMh6v4S8blyPmQhNSi/jVQnYSmsr/nWTHGVyngriybW3PN7mRYtehiv6Fg/rGNKj
	 HsMtgcAqJu1TmNgoFc4cQNvVZP/PNKBkQzgZvWtHbbjtc2aH25/NmIhYeUguOCeuUM
	 V41/BnERJWQTmiIGjkD9rmkVpEPbgdCtW3kOQtUFMhfpvbS/cy5IH7X6dPM7vtOum1
	 xN5glbUR+s4DTK7GQR692b6wCz6zklxGq2sNmwb4li1OcsP1pryObrhOoLVeYX8SZr
	 SvJyijxVUDo/J3MXa0gY6W8zvwOULqFnB/bba7+cDrZ1ewoxg2lzOpqhgClZO/OuZN
	 7gahZmp1+tAcA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 26/28] mm/damon/sysfs: setup damon_filter->memcg_id from path
Date: Tue, 12 May 2026 07:36:41 -0700
Message-ID: <20260512143645.113201-27-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
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
index 3dec0947b93f0..6935cc3ea00ab 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1004,6 +1004,7 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow);
 void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
+void damon_destroy_filter(struct damon_filter *f);
 
 struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ef751898a3c06..89568f463e556 100644
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
index 2b68e1a7de451..0b7b0ef345cc8 100644
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
