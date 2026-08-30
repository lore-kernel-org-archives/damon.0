Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F22EEE6E
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066858; cv=none; b=JgZgs7Zo2/YEFVfRN+n2F+9C5j8oSg0i6HOZps5wwfnJ9aKTOzNggzF79DBpLQWBccLrwR/akSeX/F7C1dSFIGUIa7vRudko4IPw88oXNMfMXRHDyQDHsEk+MAkrX0XLoVrSF8oL9IQXxIbtxv56qifGcZg4P9zT3GAE63/HN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066858; c=relaxed/simple;
	bh=1IoYOQdQXFvwKzLHxgB+uq3xpg0ikIIhqsw4J/nkMyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk6Fy0MPfzVCVWcdyx18Fpi/s1zC9ufUztjgdN3jsdlE68XIht5/oSD1CUdBk5VZ1PsO3kl4soNqr+89/I22wE+UD8udbyUr7RnlURXzW2SCYcyoK9X+wjik2Js702rlxiiuKzMlMAVM7dnmyDuyIfTfGp2I9b1m6wtRc32e1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=VaoCfi7N; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="VaoCfi7N"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2318396a91.1
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788066854; x=1788671654; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDQFaZkSZClgPI6vQ9uvEW8golFAoyljS7GedCtCSvM=;
        b=VaoCfi7NUM8bJQqLusuQTTWn3yFbDxA8yQOd1aLNM+fjEHN3kazUAU/sS/M29fQNAK
         1ChGmiLDxMvw2klWXyEgH8AmFVN1ucxVE1SKjwOFYT4kkalE6yTn2eh5VsrdPZfNnDP5
         titf2WBGEq7sTjj2Q4z6wasfEnbPz85kQXSkCstt1nhyGrzSvp29E0MGlqB5+KethRXF
         F6SXnIC5juYm/g0vAWBygA6ZIWbox1HoNantQNF3nGZHsc1k4VZhCDxjshubApJ+CzC2
         RJgE/rxokrvFf5iMTvem5s5fMZQKUpJc9GXgGMq4XZOiiAme+YDYJ6ZPfm04KuCAp3W4
         WD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066854; x=1788671654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nDQFaZkSZClgPI6vQ9uvEW8golFAoyljS7GedCtCSvM=;
        b=pGXUUB4ZypHWbQTddfPJNpluw5de+Nnf1XqoKIp+uz59+x1fDTy6keTR9g01BxsVKJ
         YOGTWW6j6hg9tquRwLCfZM2klWWVJCVSE2UIn678kEYrKq+RNXy+U4SLm56Mo/LorY8+
         Zyq3tgJsQLEB9q2o/sFdTx0Yw+xwL8cpg3gLI6cHvl7TVHY/CmgO2JMn4q4ygOmdhdrk
         meg0pUGmsB2Wn7mLqSoCaC/aX9JsnB2SZnRomecG9C+Lkov6nLLWxw+R+0blKbPrR8rv
         +eU0tmfka7OTWw9vyqlS2GS4+uHXyGkGlwvAfuk1jI1OFAc+dXwnbDTDT0r3Gg1xxjfA
         RZkg==
X-Forwarded-Encrypted: i=1; AKwUvBxQiwZTQ769IpknycME8x1hK3tJGI9BOK3DupaBHSC8Zy0BjcxfeVIc0Rf70gV95J8L/wI1Ig==@lists.linux.dev
X-Gm-Message-State: AFuF++lKf4qngoFXb8BHC5HTMcQmM75CmkTAienCqZG7O67v0szhBDBq
	0ZG6VMitnwIEknrM3+PTxc6MDWkIoA93FH8aTBAB/jBzpuqpcZ+MkZF4C1JR5uULg+E=
X-Gm-Gg: AYBFou2AT/rxBGId0W2XdttuHCk+Ws2Qk8TVZ0vEeRx+UX7QHPspDWRCZU9hANUwag3
	j/BzVXIo237gdwAuMrAAOL1CMwvQFl4mAD61P3tr1z6KNFiOIIuHS62Ki4o4S4At1YPYDIHXzWH
	0wGvTfWU6SfhIUSQ/AFauN9ORMew76CHdGO5ejKz1KmtvN+DyvuFKqUunY08Zs5W2HH5p/RDc7S
	lVi/KLMu9PQUhzhrIT/W4symG/YheRsuX+KhDqVkpfT3bqMknhdO6HgyXkaH7SL3B24M9wUyRpB
	T7PVw/JreEw1PUdIVPRq2Kd0uFgR4oVMhp3GBuPdttXkU7ca57jgcLf21EZLZbqB53iEqZPmxot
	7w3bBTRrJwHLRWn1eCfIPOjXeCU2cqSQqscq1/JsSgEboGXHcW4FUOb33YSIjqhM/a163nhLETw
	F6umQm6Bu8GF7lbUlbCrTIsihC1JJ25A9IYtBNaMp8M0wrcJci30FteMWL47fS24+B9jsA48HGp
	0yGlnIiuvBuvmmsZyX47Wq/IpMEShjYf+k=
X-Received: by 2002:a17:90b:53ce:b0:398:c0a2:8f8e with SMTP id 98e67ed59e1d1-398da8b6e92mr295447a91.26.1788066854435;
        Sat, 29 Aug 2026 22:14:14 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:d101:1d:112c:715e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm22595810eec.29.2026.08.29.22.14.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:14:14 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH 5/6] mm/damon/sysfs: support aging_flush
Date: Sat, 29 Aug 2026 22:14:06 -0700
Message-ID: <20260830051407.50008-6-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260830051407.50008-1-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the aging_flush monitoring context option via a DAMON sysfs
context file of the same name, next to addr_unit.  Accepts boolean
strings (kstrtobool); defaults to N (current behavior).

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 mm/damon/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e3858ffab4b2..c8bc9cfbe4cf 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1403,6 +1403,7 @@ struct damon_sysfs_context {
 	struct kobject kobj;
 	enum damon_ops_id ops_id;
 	unsigned long addr_unit;
+	bool aging_flush;
 	struct damon_sysfs_attrs *attrs;
 	struct damon_sysfs_targets *targets;
 	struct damon_sysfs_schemes *schemes;
@@ -1618,6 +1619,29 @@ static ssize_t pause_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
+static ssize_t aging_flush_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	return sysfs_emit(buf, "%c\n", context->aging_flush ? 'Y' : 'N');
+}
+
+static ssize_t aging_flush_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+	bool input_aging_flush;
+	int err = kstrtobool(buf, &input_aging_flush);
+
+	if (err)
+		return err;
+
+	context->aging_flush = input_aging_flush;
+	return count;
+}
 
 static void damon_sysfs_context_release(struct kobject *kobj)
 {
@@ -1636,11 +1660,15 @@ static struct kobj_attribute damon_sysfs_context_addr_unit_attr =
 static struct kobj_attribute damon_sysfs_context_pause_attr =
 		__ATTR_RW_MODE(pause, 0600);
 
+static struct kobj_attribute damon_sysfs_context_aging_flush_attr =
+		__ATTR_RW_MODE(aging_flush, 0600);
+
 static struct attribute *damon_sysfs_context_attrs[] = {
 	&damon_sysfs_context_avail_operations_attr.attr,
 	&damon_sysfs_context_operations_attr.attr,
 	&damon_sysfs_context_addr_unit_attr.attr,
 	&damon_sysfs_context_pause_attr.attr,
+	&damon_sysfs_context_aging_flush_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_context);
@@ -2102,6 +2130,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	if (err)
 		return err;
 	ctx->addr_unit = READ_ONCE(sys_ctx->addr_unit);
+	ctx->aging_flush = READ_ONCE(sys_ctx->aging_flush);
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
-- 
2.54.0

