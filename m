Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856222;
	b=wRyOfSSaHa1bkkd9RdkPZn795lEUuxLHl0A/P6q5JUam0pDQlbJwceCBJIgg1juaGtNE
	 HS3DP3owYIlxecEsyeDqFTmm07Pt97WPRMmE55OkRJxY/gDRv8xnnbCsK6h56YbzlO2zG
	 UQDNQ1yHKulMzlKRggeb7nL+j2U0G6wYCXU/anWH5YCEOiG+G64c7xEesM4lbIONd88h8
	 HsXB/jIRfsMxtZU4FZ6CoP8n4h6KhJxMw18pjh2wtRqtAZUg8XSMFegoA9kR0an/h+2iy
	 AitIt7vAuj7mq7T4ZVauu+e6hxvosML98hmAE+qTkeDmL/O4vqldE/z/I6HYn2L7aQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SEJOx53H1+kOAfB5X/d1gIgUhchGzcrN8DF1l4byjXc=;
	b=x6MXfOaMJznDM22tCY6ztv5PySKYPW6L3/4BLwUO6KLyxPLd22s95TtnstC4/LG1cosY
	 DnGkAYwscbrvtFRLeLsCqCnLdsuNIBPX/PKEsM0/uFchceBPQNtwAjm5jcqC/ST20RQsD
	 njC4D0OLp4anFtSg5xYOPa+4Gu1rlnMOnXL/r+6oukSBiNg4Xwbx73OSxt7gQvNLLnIa1
	 5kKq+Vyt4LaLJhgk/NfuNX/mV91jBRCh6glyZH4NY2fV0uzhAbhAKbt9t1eK6mQE/yJPy
	 WEzJaAXeJO0VDUyAVVnOsUnDkJv/96/9wzDaGGSOzy4HvM7qGHr7xkT8ogBov1Xi5sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNtdmOa5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED201606A32F;
	Mon, 16 Nov 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNtdmOa5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794856221;
	b=vBsUM3xKGizhRwS51I+qzF7uz8WpkSRfXR+C8R986NSMBzTSSADixQFsb7Y28eFZpeOe
	 HyyFpENPpzPTO4X121/eYcrjyq5mTSfjrUwTEJXmvn/YjOIHK3kqHIUZmLfZwLMvAMiQL
	 NZN29ZMcs3Eg8comiCfDyGtA1Qeufsj5wv0dZEXcybOHLFHZn9gbCvpWFS3vf3LK5s8JQ
	 YKeJ6K3xUn8+Owe/W4q3XNpkeObouV2yO4cvl+jheFYe2yhuzdc1ZXEahW44gkFgByWJF
	 9puO4ainDb4HuxL8ndq1k6sTIFH2wrP+9ZaYhfgdyyx1h9R1FhQvK3EAHH6XXLeQO3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794856221;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SEJOx53H1+kOAfB5X/d1gIgUhchGzcrN8DF1l4byjXc=;
	b=QD+Rz0lDF1tXhL3nJGkuBzPUaXlX4g4pjwl5WhTtivDOKqFtvLa1FmpDPcydlDFGS9lw
	 gzEpuEwBabDg8d1gkxOSy9j9qAHW+uIJNFpmgdF2jxMM4TAM5jLOHlRHZs1/Bl+QT5+uq
	 JED7972rfGlVQQG8mJiM3cwBXZ3XN7MmAq5wng32Ati8S3L86OYs9kutranjAmLat0r/d
	 buPTsYMhplf3VDdIt5IqGFuiihUYrUZrfahfmCSOpoK0Km8eIZ35zdmLysPuD+ertRqMg
	 act0ovJS7gw6Yyij0QNTzX+sYyXHkBWIjvfCQZnlRYgzwTTuMzCm4ArKKFQ1Xkndpnw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E0CC31F000C7;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856221;
	bh=SEJOx53H1+kOAfB5X/d1gIgUhchGzcrN8DF1l4byjXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VNtdmOa5Bv0ZFaxb2XTUipyEydDyWvdVgAreLr4Y0Kb9QmniLCGusvauvooTXu70V
	 Req91qAXtK7zzhZrAv5sMT/pqEqJzh5dEWuYlTbLz12aFXfNF5vnIM5AN6nM57hCuO
	 0+B45VFu0/gmMdb+xoo430xETiFEZmcKbdy1kMBzrdKl98EOCFjrDdWkjfk5q/NPi6
	 +pve/LJboiuaDpWG21AMLoAdnDtFQur1fOb/3vTaR170opL6CX5MyNmhTi/uWQERXO
	 zJ84jGYVJIQLsp0b3Hip4IGlMCPROORE4FF19zcSKPBgA+DeVeVbwa9ikRFTNoL4Nc
	 LT8odP4A+O0jA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 693AD4A599;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Mon, 16 Nov 2026 19:10:05 +0000
Subject: [PATCH 2/6] mm/damon/sysfs-schemes: add sz_ops_filter_passed_last
 file
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-damon-sz-ops-b4-v1-2-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
In-Reply-To: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794856219; l=2837;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=3d72KQenPLZSAMPasN1wih5Lo/g59JndfypEpkGmhZ0=;
 b=ob0NIrM5E36+IU946sP/gerNGtsB6G1jMaVz6CIklTsO1XmSuRtfAXavsk4EJgGhR524xNXNa
 hh61Cn/ziZCB+eAEWSGpjAOTt7YsPgURlFwJy7Fs8cvWMw+RQF3ZHXP
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 7bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Introduce a new DAMON sysfs interface file for exposing the newly added
DAMOS stat, sz_ops_filter_passed_last.  The file has the same
name as the stat and is placed under the DAMOS stats directory.  Like
other stats files, it is updated when the stats are refreshed via
refresh_ms or the update_schemes_stats command.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 mm/damon/sysfs-schemes.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 230987efac3a..fe33189e8802 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -370,6 +370,7 @@ struct damon_sysfs_stats {
 	unsigned long nr_applied;
 	unsigned long sz_applied;
 	unsigned long sz_ops_filter_passed;
+	unsigned long sz_ops_filter_passed_last;
 	unsigned long qt_exceeds;
 	unsigned long nr_snapshots;
 	unsigned long max_nr_snapshots;
@@ -425,6 +426,15 @@ static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%lu\n", stats->sz_ops_filter_passed);
 }
 
+static ssize_t sz_ops_filter_passed_last_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->sz_ops_filter_passed_last);
+}
+
 static ssize_t qt_exceeds_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -485,6 +495,10 @@ static struct kobj_attribute damon_sysfs_stats_sz_applied_attr =
 static struct kobj_attribute damon_sysfs_stats_sz_ops_filter_passed_attr =
 		__ATTR_RO_MODE(sz_ops_filter_passed, 0400);
 
+static struct kobj_attribute
+damon_sysfs_stats_sz_ops_filter_passed_last_attr =
+		__ATTR_RO_MODE(sz_ops_filter_passed_last, 0400);
+
 static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
 		__ATTR_RO_MODE(qt_exceeds, 0400);
 
@@ -500,6 +514,7 @@ static struct attribute *damon_sysfs_stats_attrs[] = {
 	&damon_sysfs_stats_nr_applied_attr.attr,
 	&damon_sysfs_stats_sz_applied_attr.attr,
 	&damon_sysfs_stats_sz_ops_filter_passed_attr.attr,
+	&damon_sysfs_stats_sz_ops_filter_passed_last_attr.attr,
 	&damon_sysfs_stats_qt_exceeds_attr.attr,
 	&damon_sysfs_stats_nr_snapshots_attr.attr,
 	&damon_sysfs_stats_max_nr_snapshots_attr.attr,
@@ -3130,6 +3145,8 @@ void damon_sysfs_schemes_update_stats(
 		sysfs_stats->sz_applied = scheme->stat.sz_applied;
 		sysfs_stats->sz_ops_filter_passed =
 			scheme->stat.sz_ops_filter_passed;
+		sysfs_stats->sz_ops_filter_passed_last =
+			scheme->stat.sz_ops_filter_passed_last;
 		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
 		sysfs_stats->nr_snapshots = scheme->stat.nr_snapshots;
 	}

-- 
2.54.0-uber3


