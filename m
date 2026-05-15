Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6F378833;
	Fri, 15 May 2026 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805899; cv=none; b=G71W+N5q2b8oPm8CJkzFSPo1TpnUBaH7bhoJ0oJj/+spPnnKXh8r68qAOMAWHLWL8DEAYqv0Na53VnIfKe5eAsJ1GryUrgjCaMgwLixyocl1xoTca1Au7XOaSwsg6MkFKMEFPypaEsqFj/NWLK08Q6xAckHuWNpt4I/nPACOx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805899; c=relaxed/simple;
	bh=PDuM782dGG2LDPjQZNWcCEwrn5/ZbTB5xohK557WpVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFO7qrzgZ+9JCuX9fyRxjREu1Kfdj3UGKMmcK7JDPyWxshsvELX+enrfG7nzh1WhVeBrhTCUXnoF6v+DpMjMhZW2p3YIizOwQgwY8phWlAINmQfgKqjQie0JSm6s2skF8LF5+yf1ayBStU6c+XEgvdf11NabLdDBzsNROeWYr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMLWx31t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMLWx31t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68EEC2BCB3;
	Fri, 15 May 2026 00:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805898;
	bh=PDuM782dGG2LDPjQZNWcCEwrn5/ZbTB5xohK557WpVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMLWx31teEvDCLkfORSTTqndUMh731Ek0cmeMEqgxqbJQ4Wv7Re8HHusjZCQ+T8xk
	 TCu22IR+UZt6zWmgSklrknPlbO/qXzK30V1FRRv/zvVWPcFf4aVUqIFroeINyZ1gPo
	 SHuFcfjhB0h5jy2YAEn3Bz2oSInkYU7DNgZQnOv+v+DuY4xvJENy1jlheJ10H5nj33
	 v+Tp3Pp0SbciKMr8iTelWTvPf55i5i/wEaJV9D3M/5Z3n+a8kjd7wPcWYpAiPkurio
	 zYzf277H1k9CSFJa/txKFLdNiNYtbTsz7nNebu/EPQys3sMG/GWvKu4lxGAX8A5mWg
	 7PbEIMGkndThw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 26/28] mm/damon/sysfs: setup damon_filter->memcg_id from path
Date: Thu, 14 May 2026 17:44:27 -0700
Message-ID: <20260515004433.128933-27-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index c3ecb35da6404..5ad46bed18119 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -974,6 +974,7 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow);
 void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
+void damon_destroy_filter(struct damon_filter *f);
 
 struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2d4a63dcc47fe..a6f613c9e5c91 100644
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
index 21f89f2976ca5..d0810540f8257 100644
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
