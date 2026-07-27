Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6893F4847;
	Mon, 27 Jul 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163118; cv=none; b=Gy77z5ie4/NR49c3t7x3AoVC2RG9/pnGckF/nI0YvM5rftBKd7QNR2BA4Jc4R5aWMIvbLe9K8yZ8MZf9LSUZxoKv0vrHnki+WJy551TI9ff7Zc8SVJXPPoV+HlWyw5+6S4raInRN6FSl2TYQQisNHIgzyz5IfzF14rr+1WmmaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163118; c=relaxed/simple;
	bh=UCnmZJIFWLAyA2V+BxDBrCEglrwT+PkL34Q88xrhGDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snGGF1eimKOw4P1TeVS7wcSEMqH8ko0YT73hw94QYuCHLhc399xszBAj0g2UORIxoxL3AQcC4bSTE7Vp9MSsp6QTQiruiawxUa8BDXUPQrg76sqQ/W08m10x9Dh3l1ll6lxWeJZUFba2mpqJ87vadjfBE8hieSsQADgtRRSqMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASIfN2Hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASIfN2Hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4A81F00AC4;
	Mon, 27 Jul 2026 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163117;
	bh=3IJAHoEq/HxxwTqavkeHm1rK87WzNS/lOqxmVc4kOBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASIfN2HmzFDLPKauEvk+aTbeOju5g2NHdiFiUPIwsEy3Ru14mfA+g5ArrLP9D1glA
	 Y+uZU6bkNK+KsesYculdkRdAEBJzfJ3eqkfKwEaUiEaN54hMn8LS6NwgJJfSd/Izn5
	 vGyWbcPFGSZL2W/KTNMrS1VSLSqzs7UHQnGkMrKbOHIPEi0WTgha5gmiQrBvnv62LL
	 4EmNnxdvNKWqqqOS0c58zsapG6MRN1WasFzTguqsx8nIStsuk6YDTDNAKozQbNwX0p
	 5H4qnCHiTSiGbiQnypLNNVeaAe0eXJEsdEaGcaJ5CN5D7YgMKpN5h1QcVpOd2Dx2+Z
	 YCjrVisD9D6FQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 13/17] mm/damon/sysfs: pass preps to DAMON core
Date: Mon, 27 Jul 2026 07:38:22 -0700
Message-ID: <20260727143829.86236-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
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
index 0173f37fdbf3d..3ef6b07cdb5fa 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2174,6 +2174,23 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
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
@@ -2209,7 +2226,15 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
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
