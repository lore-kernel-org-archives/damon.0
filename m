Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0D3783AC;
	Thu, 25 Jun 2026 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397496; cv=none; b=ZLhd1i9WQcsQHOjE4prD0hmp9wKp365ZHoypozvZQ5zBnYKbK0oaDEttnwldPuvleQzq3nB3DjFHM82Ely6REqr7d5xUKx8Dxc7feF7WjrDA+L4eTtR3rYX4/5PDv4sftGSukCM5/mForrgGaruiJ1N5mE4OrslpVVs0apNmVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397496; c=relaxed/simple;
	bh=RA5E0IVRziTxkehe8RwMfImo5CCC3gzpNK3zQdywLIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcCsaBRdwrO7BACsZBEf/SPSUL4BdRaCI3xOEHp99hSpCbd3/BGgiwIGPC+w5XTRc6K4EeB7EabisK1Sg4grzb3mdAjd0GpGURDG2mBadgp044uFYxBBAVgIKepWvb2yyjWLA1zqrvybHqh5VERUwxbwIGCPBAsEF7ygXFTcHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7ootxeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7ootxeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64CF1F00A3D;
	Thu, 25 Jun 2026 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397495;
	bh=QU3Mdz0QWuS68FFe2kfHvyIPhX+22pphhD8CNUTJFTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7ootxeAFvxb1hfB81Mthn2cZCaLFZAowIOZ9rKmqjaSAM8KO62ef8i4HhnevDN3X
	 mxGcab7l17Hgm2Erlzv7YA/udIle5opylGgzMrN7qXMWKzc8vJ/yzFwYZsdlEXSrC0
	 zZc141hQocD7AVvrMGy95WE1hzaUTJnvB7XqW5Mm1sJyBUwk0G5DPk8dlHE77AbdyN
	 tPNecPjY0WNYEfzC+c/HXQJcnvcv1QtyC75evsvT1V1kZ3i8iQmWH/fVs1kfUWu4ZX
	 RldtfzEvv2BI5xvE45J721RrC1Egdd9R4V6sSabskJyqULoSxia2ufU+v1DOX4IeAU
	 TcW4aG1srvdfA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 10/11] mm/damon/sysfs: split out filters setup function
Date: Thu, 25 Jun 2026 07:23:55 -0700
Message-ID: <20260625142357.103500-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_set_probe() is doing not only probe setup but also filters
setup.  Split out filters setup for readability.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 982d824f63c21..f3bb146b204df 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1899,16 +1899,11 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
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
@@ -1935,6 +1930,17 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
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
