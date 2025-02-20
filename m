Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA43262D3D;
	Thu, 20 Feb 2025 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080812; cv=none; b=aD6DjRp/sqTVOX0OJzW9uwnkU1OrXdmCDcFaACT95zXXyBUsuQH7jv8BRFGXVa4ov+/aqRAHdFp9td0KNhARae8lAZ6x3+UDjwT3TWqgyd2isjjtHId2K69z7Vq+pj1RvLpPC6TysO/gXkzVUxiO0ZmVs/SZS2Rn8ugh1ihq8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080812; c=relaxed/simple;
	bh=GH9O1+rW8ywRoDFEndKmAk6SUuzHHAhWNBp35Gw6b10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L131uNziWNYRWCi3U9TJNJuBGjtIrtyDg/5Mydn4JI5BmvkGM3iqB5VnbFrJgb0f4BLJv2QdNf54bLRa7CMTfwJOE+kHD0V44jlGGUgUA29g+InSnsI+nkSbD5lke2oxFGzhA1lpx0L8yyEz3gGrtQk96+3wn5lcv6OdFA/m8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maTwzYGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maTwzYGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC24C4CED1;
	Thu, 20 Feb 2025 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080812;
	bh=GH9O1+rW8ywRoDFEndKmAk6SUuzHHAhWNBp35Gw6b10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maTwzYGKA5skdxLquMlgD68qhQHKsYnoHbbYAoLeNewOU9hccV8E1abjLK3oQTDIA
	 RSJnIfKh4yOjq3nkm3jUay/1zIbbLmcKE1cbUB/gybWIxAIkS5+FUmRTEKWsBBi5et
	 y+f2C1ob6qQBTaX3LWJI3KvIV5qn1hKopVDuvamYi0W08t5KPwZTuIlbSi9V05mUTk
	 +Vncl26DNFLLSkL6s5/jCrxCscsUNFpdmflcuUFjFLMTCFhBDR20z95B0KHYljyd/t
	 vV7u53LOY+Az36gNffp59kmpS4u/amTgn/n9cbycqZn7MxikkYuV5/2SS6dfNm2gMT
	 Eg0u49fhQILUw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon/sysfs-schemes: let damon_sysfs_scheme_set_filters() be used for different named directories
Date: Thu, 20 Feb 2025 11:46:39 -0800
Message-Id: <20250220194646.37726-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: <20250220194646.37726-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_scheme_set_filters() is using a hard-coded directory name,
"filters".  Refactor for general named directories of same files
hierarchy, to use from upcoming changes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 66a1c46cee84..541ca5887b24 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1604,7 +1604,9 @@ static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
 	return err;
 }
 
-static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme)
+static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme,
+		const char *name,
+		struct damon_sysfs_scheme_filters **filters_ptr)
 {
 	struct damon_sysfs_scheme_filters *filters =
 		damon_sysfs_scheme_filters_alloc();
@@ -1614,11 +1616,11 @@ static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme)
 		return -ENOMEM;
 	err = kobject_init_and_add(&filters->kobj,
 			&damon_sysfs_scheme_filters_ktype, &scheme->kobj,
-			"filters");
+			name);
 	if (err)
 		kobject_put(&filters->kobj);
 	else
-		scheme->filters = filters;
+		*filters_ptr = filters;
 	return err;
 }
 
@@ -1670,7 +1672,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
-	err = damon_sysfs_scheme_set_filters(scheme);
+	err = damon_sysfs_scheme_set_filters(scheme, "filters",
+			&scheme->filters);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_stats(scheme);
-- 
2.39.5
