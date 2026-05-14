Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EE41325D;
	Thu, 14 May 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767768; cv=none; b=t+TbQxfLFC+iM3GGVnfdyE933DhPNFLrP3MVKykTorXn7JR61wYz8gPEkESXWD1bvKsKOKxq2tSEDlqfrE3wgfSZ+rTXs2qCRS15ELbNfNhSB4JbizEtBiOyXAbaLSM99Jm1PL1RpJcEqFxVgFHBSYfchPF1tPVbfKW0ermKrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767768; c=relaxed/simple;
	bh=NHAL5y/oPITnJCCLIJLmLCX0+940gzkr79MzQKjKl28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcgzpjtLKmDEMPwSlmFRqNMfjQCOroRVuAJMe8o/JbdXYGRtPo5NwxxOdSxfUEeJSIUlERdyk7OUtpOfJQ+/ALJ6r4hoCsJqA5aX89sprgXf5rJlVdJotYrIqEQf9137/p28f65HOd9lDXyINH4rq+KfTOebCil3+pIIBNqwkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7v85GB5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7v85GB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A624EC2BCB3;
	Thu, 14 May 2026 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767767;
	bh=NHAL5y/oPITnJCCLIJLmLCX0+940gzkr79MzQKjKl28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7v85GB5adthVl0Gzie0AX6da+Fxt8P/DCoN9neudTZb+yxQ/k+RMBSxkQlNUv3w1
	 gxB0tSOZPXZStHkyYJWswniAz1Os2fR7d3ULJmPBNNHJa4vaAqtaX/pgAxnkDLExQm
	 0Ur3FtzZVU6A859QoDLWVJiIXGIM+p/zXjPT22zXvWizh2OhFWPIyQT2K5y3DwWnhu
	 ShlqvtgbxSEDmZc0Pr6wCo1Z9sc/8YRK03ieQA5lvnosV3EDw5VwY+R8wptDPXyTfH
	 4xePfda9d3AiV2TJPPOB7qihIJq+BOrpG2xqs3b9+Qgc/N0gjMqPN5Kj9ssakivPn5
	 5W1kH5HXPvOOw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 26/28] mm/damon/sysfs: setup damon_filter->memcg_id from path
Date: Thu, 14 May 2026 07:08:59 -0700
Message-ID: <20260514140904.119781-27-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
index 32c371c98a884..d74c58874f74c 100644
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
