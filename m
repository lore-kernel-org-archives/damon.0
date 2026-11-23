Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446799;
	b=1STCk7QKKDtkEVgg5IXPw58DOAR9n4/Ho7H9AWk/bFqR7BLePrBDkNmB3vSJAk/dqOGL
	 kn2bjzhr9wx4CDu7Vm8ucTxXbq2tDWuhn6InDe2/8FLELWP8mqBn+w7bpQZiKPCFBgKpk
	 qN9AHBwNx6i8m9ilvpVajLOGcaGlh7y4rYKolMbg6O7+OfQ3XTzibJ9MWwCXxKbtMCwfY
	 nzhvMS3d6RshXZN9Z+pX5N89NoXDyybJ/2OGH2hEYhhzKfBMNFUFNryGRF0HLlvvQ+ySK
	 JM5UThCL/1/Vyt1lJ5Rrs3Np6FRrzTV/vPZTbzogTvW7d92wDDetajvQld3aW6dajhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=anjosQojPpSKjTyo8SLgcPgFtc0uahan+Zt7aVToU38=;
	b=omlZGklFZbNEw6eynwaaeqZzB+/E5EDuX1GX3bFJ2GOWojBKsUbVt/WzhS6X3GDtVQ16
	 AqpxDfWGJXYqPzoEzRBIO1eXWaH9o49rdzkg6dKQij/PwtAL5Y9pVwl+eTgsq+4xplILH
	 oSix0uQJHHrxTtN+zJiN2Ul5iWw51i5WezNpb/mSlnSjC0IszoYnYY6r3FwWMxGXk++jq
	 UHotlEi26JmTZ3HtJAiD37TVy9wxYuvKQptJ9st2yKP3RJS1VNR2xud9hXnJ3eg9tjMhc
	 MTMiT6HZNJEMVe3oZs3uXcwdUhv6RX0Xyo/Ln6fGKQWzp8WTgzOaoCRc/p69SzZ5ZOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRWuZwnF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1855606A32C
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRWuZwnF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DDB1F000CF;
	Mon, 23 Nov 2026 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446798;
	bh=anjosQojPpSKjTyo8SLgcPgFtc0uahan+Zt7aVToU38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MRWuZwnFp2IuTCwJQlojIFBselaE+wLkhBNw7MTxxWkaUeaC4Y6mgpwUktV8eHTkW
	 mQcRtI54HYMqYnwhpmRgUCR4oHZ1wiqpJac+InR6hHPfA4EX2ghjRVCBIdn3j7pMq9
	 qB3nH5rMptWTsXmZqDC8ipsQH5DcRaGoMMuHbzQqHdBUbfeZ0WAxt7TYuO4Rlr564v
	 d7x4nJujLqm5OeJINa2F6JVazCkEw28epGpe96oXVDWytJu70diek7SD6MXXy9bNSo
	 GbU9/AEEsN4X3Gg+9RjTWSn7FIi2cBP6YQpWhgtzGWBoWOamalfJxa7yMPatGcRz5a
	 LPmovK9P2Zx2Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mattathias Pinchover <mattathias.pinchover@uber.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH v3 2/6] mm/damon/sysfs-schemes: add sz_ops_filter_passed_last file
Date: Mon, 23 Nov 2026 07:13:03 -0800
Message-ID: <20261123151309.82675-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123151309.82675-1-sj@kernel.org>
References: <20261123151309.82675-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Introduce a new DAMON sysfs interface file for exposing the newly added
DAMOS stat, sz_ops_filter_passed_last.  The file has the same
name as the stat and is placed under the DAMOS stats directory.  Like
other stats files, it is updated when the stats are refreshed via
refresh_ms or the update_schemes_stats command.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 230987efac3ac..750f70f0c31be 100644
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
@@ -485,6 +495,9 @@ static struct kobj_attribute damon_sysfs_stats_sz_applied_attr =
 static struct kobj_attribute damon_sysfs_stats_sz_ops_filter_passed_attr =
 		__ATTR_RO_MODE(sz_ops_filter_passed, 0400);
 
+static struct kobj_attribute damon_sysfs_stats_sz_ops_filter_passed_last_attr =
+		__ATTR_RO_MODE(sz_ops_filter_passed_last, 0400);
+
 static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
 		__ATTR_RO_MODE(qt_exceeds, 0400);
 
@@ -500,6 +513,7 @@ static struct attribute *damon_sysfs_stats_attrs[] = {
 	&damon_sysfs_stats_nr_applied_attr.attr,
 	&damon_sysfs_stats_sz_applied_attr.attr,
 	&damon_sysfs_stats_sz_ops_filter_passed_attr.attr,
+	&damon_sysfs_stats_sz_ops_filter_passed_last_attr.attr,
 	&damon_sysfs_stats_qt_exceeds_attr.attr,
 	&damon_sysfs_stats_nr_snapshots_attr.attr,
 	&damon_sysfs_stats_max_nr_snapshots_attr.attr,
@@ -3130,6 +3144,8 @@ void damon_sysfs_schemes_update_stats(
 		sysfs_stats->sz_applied = scheme->stat.sz_applied;
 		sysfs_stats->sz_ops_filter_passed =
 			scheme->stat.sz_ops_filter_passed;
+		sysfs_stats->sz_ops_filter_passed_last =
+			scheme->stat.sz_ops_filter_passed_last;
 		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
 		sysfs_stats->nr_snapshots = scheme->stat.nr_snapshots;
 	}
-- 
2.47.3
