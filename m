Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03B294A10
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410859; cv=none; b=ObQP4AAksWabXYKo3+9Z3mjCJPaNcDL8s49PKbnD1J5ZOZzfi9u3SqGyfu5j7vQ7c8a9AR62N8Au2SGfTWxQM+Cu8PRQKMuAa3vAzsWcZ8RI71tCp4Nq4v0hdPjOTnFuqCGJx2ikpb7h0+c79ooWvM336MrYGHg5NzlU3IwCoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410859; c=relaxed/simple;
	bh=a2md+4vsTqK11YqhnkKXK2lQnHwV8IUnDfnplUt2rhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jm7Y5L0NwvRg5fbVsm0S7LfSnPxNEMDrYqnxfYv4Ci9zMWq9JeY3/lY37lBRgkLiPL20TZ7BhveJkeEgs33rdhRUlUES1HtEg/flMx9YDSaZ+Em/hOkxLEIcYhSOeZOr2URnfJUEYB8N6manizuFsrmTgtSpU+bDszXMen/IrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CekcRmkA; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CekcRmkA"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71b49a8adb2so52757347b3.1
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410856; x=1755015656; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx5UQH2AP53zKZgFMv/Gb2uS3eFAcrg1hCo7F6RktNc=;
        b=CekcRmkA2lVosZax4UBj0NT2sp6hBkHae2b7ppws0c2HaQ2QdB7iU4cp0C33m/rBzn
         hnwjrKMqj/PTVgBjvOeh+lMXChHYmaWPN/lM1moWV4BgWrANpIYSws11LXWxN0AKHkWh
         rkzgMbJiMRxkkS1CsLzmK8qxGId35uCH1epnio3Id6/pZwb6lUvojeHIIzqy7uM7Junv
         erJRP7NpQ4dRXpMBfjd9froZRwLLwd/phCKPbWy5y63HyttgWkxcpg3aNxEh7urDHvqS
         L1Ag9WGe4yNaQnbPz7tRvEmAVMUxgyf/HZgB+TKlqJ4F1hB969G1TCqz02MAqKBbTQ/N
         IWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410856; x=1755015656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx5UQH2AP53zKZgFMv/Gb2uS3eFAcrg1hCo7F6RktNc=;
        b=w/JxUq+685T6+CQbpcj/A9tF2OecEz6omGEtjWQ6zjf5QXmz/qIygrpF4YlyUuG4UW
         fndsXcn5onQ8Vqy8zbOE+omwschbTRoX6Qp1UzUu+hqki4yo8cxp3VhWEOuueN2OXKUT
         XzIgpXDuISDj6brQgXXWNYS92+ICN9cDsaymGw/2ctzeUy/2/CmDCD0G5kvpo4anOlzS
         sK9NOC0+If6peA1GPmfHqojFYQEAUqzGeMQ6LEltw4atoY8lvY0vl7fCFwiph3vZxNid
         axdZnzb3LvdYrj+ua777bxexSTC/HdwDq3MKT4w24PR8DW/ygLId7L+5twvIwi8Rixm6
         whsg==
X-Gm-Message-State: AOJu0YyvNAg2eWVdM7DHVFqadMQaHQ+PscHL5P/Bz1wWCc3rtUuxuF9w
	gqm7jkEeal996dg8mtchU9oqHtKT/UG1REh7f4CN+ZH/9vdXRXrvq+jNGlhkBw==
X-Gm-Gg: ASbGncuRVEBdYkzaSIoOOpV16T5oQr/mXaS9tMBoiLwsLCdX7sT1/zzjdGg78P76oZM
	BUNlL0nrnw99DX1PSTfLVRhGtuWQeLdorN0CFrg+5UEmpJVywhGa8Dz8FuWsNxPTrKC3K/4jF2e
	APEYEzzV0C7S3rem0u2rOs4FcZ7Ak6wol3HpCMW+xpps94fK20DMExy4rhKK6uTL8TonA08lKsZ
	8AUuegLwOmx3KWm9kxMRb64kg3nnEYBfliLxmMv0/pcBk7uDr95ngFsWglM8+Ro+eUfy0C+Vg6Y
	8KXAayvUnFRKQAwan1pycbOQlCc5XXv8VFc5bOQPLi9nsE/2UvoliFsUJj3H9OUR3QVIy1+pTut
	iPV0bz+LW7YM4/wzF2akCSVf5P4NDyA/FF4/qoJZSmJM=
X-Google-Smtp-Source: AGHT+IFlo58+shaatwrcSK3z92CxM5zcfRVC7mFQfOpwfhIPPC64bmge/xE/VJyP1a2lBc5ROadoGg==
X-Received: by 2002:a05:690c:102:b0:719:4c68:a70f with SMTP id 00721157ae682-71b7f7f5e71mr172583967b3.20.1754410855971;
        Tue, 05 Aug 2025 09:20:55 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:55 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 2/5] mm/damon/sysfs: Implement a command to only commit scheme dests
Date: Tue,  5 Aug 2025 11:20:19 -0500
Message-ID: <20250805162022.4920-3-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

To update DAMOS migration dests, users need to write "commit" to the
"state" file of kdamond, which will recommit all of the damon parameters.
This patch implements another state file input command,
"commit_scheme_dests," that only commits the DAMOS migration dests.

This provides two benefits:
1) It is slightly more efficient
2) When the "commit" command is sent to the state file,
   ctx->next_{aggregation/ops_update}_sis are reset. If a user sends the
   "commit" command frequently (relative to the aggregation and
   ops_update periods) to update the migration dests, the aggregation and
   ops_update events will be prevented from triggering. Having a
   separate command side steps this problem.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/sysfs-common.h  |  3 +++
 mm/damon/sysfs-schemes.c | 35 ++++++++++++++++++++++++++++++++---
 mm/damon/sysfs.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 2099adee11d0..3189b2bda079 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -59,3 +59,6 @@ int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 void damos_sysfs_update_effective_quotas(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+int damos_sysfs_set_schemes_dests(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index d355f6c42a98..d30c8b6575c2 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2445,10 +2445,9 @@ void damos_sysfs_update_effective_quotas(
 	}
 }
 
-static int damos_sysfs_add_migrate_dest(struct damos *scheme,
+static int damos_sysfs_add_migrate_dest(struct damos_migrate_dests *dests,
 		struct damos_sysfs_dests *sysfs_dests)
 {
-	struct damos_migrate_dests *dests = &scheme->migrate_dests;
 	int i;
 
 	dests->node_id_arr = kmalloc_array(sysfs_dests->nr,
@@ -2468,6 +2467,35 @@ static int damos_sysfs_add_migrate_dest(struct damos *scheme,
 	return 0;
 }
 
+int damos_sysfs_set_schemes_dests(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int i = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damos_sysfs_dests *sysfs_dests;
+		struct damos_migrate_dests dests = {};
+		int err;
+
+		/* user could have removed the scheme sysfs dir */
+		if (i >= sysfs_schemes->nr)
+			break;
+
+		sysfs_dests = sysfs_schemes->schemes_arr[i]->dests;
+		err = damos_sysfs_add_migrate_dest(&dests, sysfs_dests);
+		if (err) {
+			damos_destroy_dests(&dests);
+			return err;
+		}
+
+		damos_destroy_dests(&scheme->migrate_dests);
+		scheme->migrate_dests = dests;
+	}
+
+	return 0;
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
@@ -2530,7 +2558,8 @@ static struct damos *damon_sysfs_mk_scheme(
 		damon_destroy_scheme(scheme);
 		return NULL;
 	}
-	err = damos_sysfs_add_migrate_dest(scheme, sysfs_scheme->dests);
+	err = damos_sysfs_add_migrate_dest(&scheme->migrate_dests,
+		sysfs_scheme->dests);
 	if (err) {
 		damon_destroy_scheme(scheme);
 		return NULL;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1af6aff35d84..c2b036abb25b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1188,6 +1188,11 @@ enum damon_sysfs_cmd {
 	 * to DAMON.
 	 */
 	DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS,
+	/*
+	 * @DAMON_SYSFS_CMD_COMMIT_SCHEMES_DESTS: Commit the scheme dests to
+	 * DAMON.
+	 */
+	DAMON_SYSFS_CMD_COMMIT_SCHEMES_DESTS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -1230,6 +1235,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"off",
 	"commit",
 	"commit_schemes_quota_goals",
+	"commit_schemes_dests",
 	"update_schemes_stats",
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
@@ -1478,6 +1484,23 @@ static int damon_sysfs_commit_schemes_quota_goals(void *data)
 	return damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
 }
 
+static int damon_sysfs_commit_schemes_dests(void *data)
+{
+	struct damon_sysfs_kdamond *sysfs_kdamond = data;
+	struct damon_ctx *ctx;
+	struct damon_sysfs_context *sysfs_ctx;
+
+	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (sysfs_kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	ctx = sysfs_kdamond->damon_ctx;
+	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
+	return damos_sysfs_set_schemes_dests(sysfs_ctx->schemes, ctx);
+}
+
 /*
  * damon_sysfs_upd_schemes_effective_quotas() - Update schemes effective quotas
  * sysfs files.
@@ -1644,6 +1667,10 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_damon_call(
 				damon_sysfs_commit_schemes_quota_goals,
 				kdamond);
+	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_DESTS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_commit_schemes_dests,
+				kdamond);
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_schemes_stats, kdamond);
-- 
2.43.5

