Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFD3112C0;
	Tue, 30 Jun 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829070; cv=none; b=M/jtRAa4u6vdDAO7Fpuwgu6e4aIlPzqK7wsQ7pCDZ2jgi6Qbo/zdf9z+Qvudla29Q16KXbWmopHbJo5HiZe0+ugxwUc4xkEHXoKepNjRF5DJeto3FADs2IVHk2CbYvFB03qzS4LNQTf0nOuSVkirxISspxbPDRNo9YL0RmDdhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829070; c=relaxed/simple;
	bh=WdUedgP2wEZ5tCU6maDen+EDq+EiKeWHuG0e32IAgGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftssZy8fBcya/yTnOs7x1h3X1MQ+gzlymGvMrmt3PZTZ6EEfGUm3mlLXWoVTQT8R6G9bejENsrlaXgt3Asey4aKAxnIJs/e43bSUDpYexCW3MYhRcAdccKPWQLqHIm3zWhlV0d2ySM3M7bQ/hMrmu4kSu+YzmvHqFA4QB/qraR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4m9KOaZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4m9KOaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BF21F00A3E;
	Tue, 30 Jun 2026 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829069;
	bh=DpQXH4eWAzKUpyJ3N4PMjq4KjSfFjbZwL0TXiysKWH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4m9KOaZc9PBbmhx+I6uZFVtxtofgHXWxNr83EHH42rQLsumNAEoxIDnOUO4MCd7C
	 ps4DN2kllZscItINWvABpMlr1xkg2pmlAo5N7j9R6umadpPI3EPzm4m+iuRCuwlIY2
	 PBkvBEXHo0REDXfTekNgzOTiypE2u4mct1DniolrXpnYSq8cwytTceYilnKXiRM1Ot
	 M02SFoT/GE6VTOqhsx4kJq1UPnaIX1H9I1dyvcUAhjF9SpjxzpuK6o+c5PjeAQxPYL
	 GAJHSyhIx9R8/zzh34+W3vaIEHfkx5dcirS8H9KfP4B+5HjfIf+il/utnkNp1y/lR0
	 ZcDB/xBDrnrwA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/11] mm/damon/sysfs: split out filters setup function
Date: Tue, 30 Jun 2026 07:17:24 -0700
Message-ID: <20260630141726.92246-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_set_probe() is doing not only probe setup but also filters
setup.  Split out filters setup for readability.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 02afd37b04df4..5b2ae2fe948fa 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1909,16 +1909,11 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
-static int damon_sysfs_set_probe(struct damon_probe *probe,
-		struct damon_sysfs_probe *sys_probe)
+static int damon_sysfs_set_filters(struct damon_probe *probe,
+		struct damon_sysfs_filters *sys_filters)
 {
-	struct damon_sysfs_filters *sys_filters;
 	int i;
 
-	sys_filters = sys_probe->filters;
-	if (!sys_filters)
-		return 0;
-
 	for (i = 0; i < sys_filters->nr; i++) {
 		struct damon_sysfs_filter *sys_filter =
 			sys_filters->filters_arr[i];
@@ -1945,6 +1940,17 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
 	return 0;
 }
 
+static int damon_sysfs_set_probe(struct damon_probe *probe,
+		struct damon_sysfs_probe *sys_probe)
+{
+	struct damon_sysfs_filters *sys_filters;
+
+	sys_filters = sys_probe->filters;
+	if (!sys_filters)
+		return 0;
+	return damon_sysfs_set_filters(probe, sys_filters);
+}
+
 static int damon_sysfs_set_probes(struct damon_ctx *ctx,
 		struct damon_sysfs_probes *sys_probes)
 {
-- 
2.47.3
