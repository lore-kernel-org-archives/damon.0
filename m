Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794957789;
	b=WaqLYstCywB1eao3j9Br/GjqElMLE7Lw/g98CCB89Us3zPL0m5cyLIAGp62+Rh37KVgQ
	 yrMJSqCxetXOUXx0PDnKaPP4aTgI8Njydz30b5eNYO1ObquFXnC/NJOdCT0cmTIL3IV7M
	 tiWwkJ2bwa2nBCWc4hEY5zCXEO7IHu1rKERMiu/M8/3sXumwi4tPwE6DHjWOsLVUDlGC7
	 U65fNOEyM+WA+vFgdK5KYvwYxPn8jbdHhBmrwQN3GfkLeHoXsquVy9Hr2R32tXgu75UKV
	 Iscva9lcj3VeMxu/CNwOXwj4+D/47z7p6ZWOjrgfiVF/BNLckROgArL/91AVWKfTyOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957789;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M4F70HveUXtSu/VzsmjPy4tHZsFCCJi8A8Mell8WdKc=;
	b=xwY6v7z5C9GdR4PfS4HrEhULlV8kkUjQ16FSRRRsF08iWEhWufFljZCHLgvaau0ousDi
	 1W5aWtvIGYtTTePENOJLkmTnJVnmgB/ZOFKOQ1lCSNA1Dojua+EV1b84G547ad1aFGxC+
	 6rhTl9ALsPNCJvOGmCp0PDaqYm+LZzazIXnfLpUK2CBRO1UuM7iwMuJtHCJlz02n7nvpk
	 IdA9covIG2ynaXxBaCNIdu2S1atXUKDQ9ZRAQJYkVyS3xT3JPCyu/oeemXEbdlcPR6AkJ
	 S8FNo7gK+0wH3wzySuf2MFTqXWXvn7/PAoF91p8WyrozQLS0g9NAuOQZaiC4PWLHV1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KU7N+Fsh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFEF606A31C;
	Tue, 17 Nov 2026 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KU7N+Fsh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794957789;
	b=C5hSpsejT9Csu6JI2yDzDeAREi7cXTkRC+nKrIjKctp31/jCNQVGbztRGm5WvHFtzXcc
	 ywpvs1koacXG5YnK1MRXrj39wJp3sT7kslsocU7XrfiRQx/p/JfRhpFNFAE2XOT/LsPuL
	 QvO8EkQ+9ClKmOpGanuNuduv11Rdvx+yVo9O4Hf6fWBjsqiKEeaCLicYCgcqz1N4HQKlQ
	 Q71cUoMiemq4aiQtksP9Lo0/ddidcQP35j6rawDTm9Ho/bqa8TDX2xRe7NQgBzAqFJ431
	 xMroPBxytZ9hEDDju5myFSCnYP3/wVELd/Hv7tRh/MEQ5so1b0TCSjT4CQyO2vRAJTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794957789;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M4F70HveUXtSu/VzsmjPy4tHZsFCCJi8A8Mell8WdKc=;
	b=L1MBYU/dmoAktWFbZlhIdcHsQQV01bbvFIwJC0kbnLBW4NRIGnFMjUTOJfL9OAgJiti9
	 mSqdmSKdE9FoYYcl9ppl2/v73VEIcl1mqmBwP0Rr5AGtA7Zi/I3T/RQbwXAiQmaqhRYOP
	 FUQliz9I2WFh+fJqaxhrG2nvPw7uUWdBCg0yqr8HYq5bXxPa2RycX+cfMaS8X9fNlb1DB
	 w67X6ksTiJ1HuCB2ZfLwqweCDLYbR0p5pRASNyNpE/pfdXgODBhTMCPXXtKi+Zw567UbJ
	 akEy/56GZymoknwK8ytDpCCbb9G2OYu0aVkDFUFiEkGqxQTYSHS4To4s0t+gqCWrjzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4450F1F000C6;
	Tue, 17 Nov 2026 23:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957789;
	bh=M4F70HveUXtSu/VzsmjPy4tHZsFCCJi8A8Mell8WdKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KU7N+Fshcp+njvgxSQjWz8ncBC2t8clOh8fDbqHDxWNDQG+ost49IPXS3At17d8oG
	 yzrUq2f8CzNgla56ovD/C1g3PDNho1xAMJ3LIOR1ivjJX/UHh9FuqjoQOUrYCPtjnB
	 w6iQ9MOR/d7hkbryXAxtkMOGvCpHEWaz0HOQi/w8auLNeATLghSQQLMnfSFvK/37xY
	 WjElk4B6NdFPai+GQUck3j3SZfLvSK7resWeZpOnwwySP1Uj87YzBYH3UPaVgoeqwX
	 qva0f2Ru0PXVY9L4UhQmeXmJok+5Pc9Q/wDp+neUV6FOaQzZEMeKorjAafaKk9AGNm
	 3IULMFAcacvdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5A804AB40;
	Tue, 17 Nov 2026 23:23:07 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Tue, 17 Nov 2026 23:22:16 +0000
Subject: [PATCH v2 2/6] mm/damon/sysfs-schemes: add
 sz_ops_filter_passed_last file
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
Message-Id: <20261117-damon-sz-ops-b4-v2-2-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
In-Reply-To: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794957787; l=2833;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=u1DV0UDoFEvDL3o7weOFk6krr3N8RcXJkWhDsTcSkS8=;
 b=ub0fqxaKw5XbPxgkwtlZcCSSAhhCeMDHpt+Ei20JZ5Gyd00+YxJp1oD+Btjq9e5umYV/NAQ6p
 kcAFeK4nKn4DVQOxzviNFD7DIYF18kXYmSqXQEBZipJIznYH4z62KJQ
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
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 230987efac3a..750f70f0c31b 100644
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
2.54.0-uber3


