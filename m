Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8738E5E9;
	Tue, 28 Jul 2026 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211979; cv=none; b=d5g/VvfiIviYtLfbuvuLfrpVLMaPU6Ydq3yY4O10hxQNOfKV2mKKszNGD/YCRB53yaRRc8xoYNMQH6mbOjtx8sR/HpqgZNLC/ve5h0jIa0XIPVnIxcIDTsZzUugcqpUjUgYyp1rUJ6heQnAXJ4PKi2Pvjn5hPx4/4IpiZv/XO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211979; c=relaxed/simple;
	bh=2p2VVBvUhnG1Sa0Gz6zzt6LmGpifGCLecxKD1eCWD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/19NA64aiBW1pVogXcjMpAQcirK1d+9cznC595Pzy4Qg4bnTFw+n8MaB+133d8RmE5rC0U1CWUAI4/Tg25FGjVLgEUHsWgz+RU3XB9S/w5TtI68mNLcoJ8CBK1JO48+GMqEa+GLBu68jhYCl8WyUQUsoTWkNL9T7SrUT13qT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcpp4QfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcpp4QfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D41F00ACA;
	Tue, 28 Jul 2026 04:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211976;
	bh=ASGSrOhiTqeMR2TBi/rXvzMlAFD79/gguOPL/F3Ka3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mcpp4QfNtxihZYAleE21Z3Ri3KIkrvTcvgY8y9aHzD0MSPySn4epb62Nx0mHkydav
	 Xslw8Z4GhYwxQyHlAElP9bYx6/bR9Q8oc5scIwqXo+Yk7rstTqrUDtykRnCGnyld+T
	 Elwa7AKysvWyhX4kUVdyVMnfNFnW0mk7URKm6vGCzMexSWdv1XD0JAzKmke+bdvfQU
	 rxfNx/+BxRV7l2kBt/guaO/bG6uhESzsNEPsteMM25EFiqIa8qLBDzGVVQ1kKZREwI
	 UWwZmyNadizHkFKUT3d0t8BT3C9aXxuRuKSCw2MbY0dyiVOeguEd26fuD60MvFGx5r
	 UnmfTfyBly98Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 13/17] mm/damon/sysfs: pass preps to DAMON core
Date: Mon, 27 Jul 2026 21:12:34 -0700
Message-ID: <20260728041242.187380-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface provides the files for setting DAMON probe preps.
But the underlying code is not really passing the user-set values to
DAMON core.  Pass those.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c0130843223d7..d02f5f8ceae5b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2176,6 +2176,23 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
+static int damon_sysfs_set_preps(struct damon_probe *probe,
+		struct damon_sysfs_preps *sys_preps)
+{
+	int i;
+
+	for (i = 0; i < sys_preps->nr; i++) {
+		struct damon_sysfs_prep *sys_prep = sys_preps->preps_arr[i];
+		struct damon_prep *prep;
+
+		prep = damon_new_prep(sys_prep->action);
+		if (!prep)
+			return -ENOMEM;
+		damon_add_prep(probe, prep);
+	}
+	return 0;
+}
+
 static int damon_sysfs_set_filters(struct damon_probe *probe,
 		struct damon_sysfs_filters *sys_filters)
 {
@@ -2211,7 +2228,15 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
 		struct damon_sysfs_probe *sys_probe)
 {
 	struct damon_sysfs_filters *sys_filters;
+	struct damon_sysfs_preps *sys_preps;
+	int err;
 
+	sys_preps = sys_probe->preps;
+	if (sys_preps) {
+		err = damon_sysfs_set_preps(probe, sys_preps);
+		if (err)
+			return err;
+	}
 	sys_filters = sys_probe->filters;
 	if (!sys_filters)
 		return 0;
-- 
2.47.3
