Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1FC277C8D
	for <damon@lists.linux.dev>; Wed,  6 Aug 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523797; cv=none; b=Z5Y0o01wdUEhmPgXDqtl5ZR1XfxAeXBJwAhU4HCDy/1mJ8Z0W8Dy2McAU7mwhrqfkpRsNvlpVHxClWQyETx1mFxjSeZzhwRQtykqiWnA3rLbVQq3j66b7j05ZyBYfuRsvD+ijaVTDLRu5xQDeZXuLpA4TdTQDUkzc/CrLaoAiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523797; c=relaxed/simple;
	bh=/W92kUb+TXnluRqaL68VPO0zwa9YeUOvdI55X1iPeMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wf2IW2lml2cTjwN52KjxyaYn26uESMdQ6cEmKplEyC99ZmlSFRRnbdU5eC8mspKmmkVfDF4N+PdXm2qmLOMNrRhXgETUJ0JlM00h5QmGsuKtQqkQ2I7pCUEypnZ6GS3GaNQ/JX1hkpweccO8Id72OMIRFbV30PBsLfuRGC9aqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFWw9vN8; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFWw9vN8"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8e2b50f8f1so453096276.0
        for <damon@lists.linux.dev>; Wed, 06 Aug 2025 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754523793; x=1755128593; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfT15tOepazFTL2Lg8MMF8cCYjiRwORhTnogRj+tN3g=;
        b=kFWw9vN8uf9VYZysgvGb7ck3kPfP09VnrHi1gKwKcqwBuBxdfn107kzt9fVLGHBRFp
         VZi3xYrFSB2tr2iBLUec3KiaUvkpiSWtufWDEsxGCo+CFbndmKxFfMgjYum8CrIiMFcZ
         mpDE1EZaSM2XVhmSZRFJ/rnIKGIFQzTKuVdgDmU+oKT1a2CYk+pPLbMrzm8Q3oD5J4J9
         FKJv1Q/DAip0gcGIQycteikRDlaoYT/SVLw0IHHR7TgForPJ5W1GRSjGGbQdOxj9u/dL
         LO/1dLmsrA9FmQRyDG6rnagTtaYOfc3GwX498fQHEjXFFAfI4Yrqf/adm8lGLOuQV+AX
         cOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754523793; x=1755128593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfT15tOepazFTL2Lg8MMF8cCYjiRwORhTnogRj+tN3g=;
        b=sU+gIQBjx5qh7NBZNAI2yinrJshT7I6IOOGaRSnU2D81fdtjAMvWXwGtxiVLybyHQB
         UjLDBOC7Gt8DFFfBSjbjRdCIMe4Z+rcjYNIHPWFtt4N9KsI+f/AeK0W2s1n/6DPGPX2r
         NH9jsTXuaWhxLbHZSrD6C5VMkGV+ziNuCSJu0B/dzGiXWfnzQ1l8E1/nzPdn8891bHdx
         FBobh/DcEupzgh7D4gP1rT8NIn61wb8fDhiKjX3GXVH58SkpG4xZMQtaEfWyDPwtnKCB
         mms0iwRHS+VsLlchCSYhvRozgLa/QkBXUOat2HRgz4uaPWENTn8eVuULoEhaq5Q6ePD2
         kW9w==
X-Gm-Message-State: AOJu0Yyi/Az6e8aDsjOzBUlbUebDm6wBXIa5KVrH9cDz3SY+NzBbz1r5
	BllgS87Q1YN9mwCSk+DdOqf71LMTbpBTyhP/yGmyXYY1/2OdicPFVpEyaG/sDw==
X-Gm-Gg: ASbGncv+O9gOnNsK4FCpDm++9+nakAcsXpWVYjawAT4msDTep5AdENcqdE31hvFwa5K
	x5IxH79DG1vj6U+DBJkVkBRirhmPt0+HZGnO7Lu1yjdWSqKwOYyNVzSiCOC61+EUvNx6pYVSgkg
	2L3CY9DAu1uCiX0Q2GOqL8eBaeAJDuOmZZ32AaC1EjEyX7Nux3W8il2d+MxhcorrZJdublyMsb2
	NF+4O5F4FqO+XDzDtgg1VhIE4EXo9eXFQqayJdwYHNPg5xiOvAxPNe8eoh+PFAu95wy+FrLfuVX
	Liz5hPqsxLGgYrdXflGJm/RXJaLABNsJp/w8dma3lECiX3OFFhye0JBS296xXDMa9xGpjxxZAoJ
	E+JEe/yTWutx4UzVs+mCGDmz+8NOw5qsJ0+mHBeRYSv9AG3tPpkt+
X-Google-Smtp-Source: AGHT+IErqUmAYFMk9ex7yBFNFktwhE0CW7kYKo02zKyww8eNDXZVT5/FhMr+He7/ul7nzCXLh9hJVw==
X-Received: by 2002:a05:6902:4389:b0:e90:235f:6c1 with SMTP id 3f1490d57ef6-e902ac7df0amr4638106276.25.1754523792936;
        Wed, 06 Aug 2025 16:43:12 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:9e66:4583:8a9c:a62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e900da4155csm2593946276.39.2025.08.06.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:43:12 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	Bijan Tabatabai <bijan311@gmail.com>
Subject: [PATCH v2] mm/damon/core: skip needless update of damon_attrs in damon_commit_ctx()
Date: Wed,  6 Aug 2025 18:42:54 -0500
Message-ID: <20250806234254.10572-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Currently, damon_commit_ctx() always calls damon_set_attrs() even if the
attributes have not been changed. This can be problematic when the DAMON
state is committed relatively frequently because damon_set_attrs() resets
ctx->next_{aggregation,ops_update}_sis, causing aggregation and ops
update operations to be needlessly delayed.

This patch avoids this by only calling damon_set_attrs() in
damon_commit_ctx when the attributes have been changed.

Cc: Bijan Tabatabai <bijan311@gmail.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
Changes from v1[1]:
  - Compare entirety of struct damon_attrs
  - Apply logic in damon_commit_ctx() instead of damon_set_attrs()

[1] https://lore.kernel.org/all/20250806164316.5728-1-bijan311@gmail.com/
---
 mm/damon/core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6a2fe1f2c952..80aaeb876bf2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -570,6 +570,24 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	kfree(ctx);
 }
 
+static bool damon_attrs_equals(const struct damon_attrs *attrs1,
+		const struct damon_attrs *attrs2)
+{
+	const struct damon_intervals_goal *ig1 = &attrs1->intervals_goal;
+	const struct damon_intervals_goal *ig2 = &attrs2->intervals_goal;
+
+	return attrs1->sample_interval == attrs2->sample_interval &&
+		attrs1->aggr_interval == attrs2->aggr_interval &&
+		attrs1->ops_update_interval == attrs2->ops_update_interval &&
+		attrs1->min_nr_regions == attrs2->min_nr_regions &&
+		attrs1->max_nr_regions == attrs2->max_nr_regions &&
+		ig1->access_bp == ig2->access_bp &&
+		ig1->aggrs == ig2->aggrs &&
+		ig1->min_sample_us == ig2->min_sample_us &&
+		ig1->max_sample_us == ig2->max_sample_us;
+
+}
+
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
@@ -1198,9 +1216,11 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	 * 2. ops update should be done after pid handling is done (target
 	 *    committing require putting pids).
 	 */
-	err = damon_set_attrs(dst, &src->attrs);
-	if (err)
-		return err;
+	if (!damon_attrs_equals(&dst->attrs, &src->attrs)) {
+		err = damon_set_attrs(dst, &src->attrs);
+		if (err)
+			return err;
+	}
 	dst->ops = src->ops;
 
 	return 0;
-- 
2.43.0

