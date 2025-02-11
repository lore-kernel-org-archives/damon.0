Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D51FF7B7
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277890; cv=none; b=Jjor6TOz3tkPHYW0xsSDIEzwlqlS695PMa+sHLXGP5Ji0jyAQe3QhMkUSBszKL6y7aeRU9kjurDV9+Lo0n5DaDl8QJj5JzNOWZEUz3rC28ZhDQnop6PZiYqPcuFGc5acPmk7xO6AHRYtvZpm/RQwWTZojd5l76VBzYIl/tLzZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277890; c=relaxed/simple;
	bh=0wgnFJ+RP/D8mG23DVksIEa2fkouc20UXU64BLpdzyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8eBkqMYVpVMo+R5VskLSXQO2FBdM3dvm9nXnRx1zH3+H4emGo/wLXGTrJDPd37D8BufMQpxJ2P+KXNE4xwbtlf5QfKQf+hMrk7I8v0UWs/g3IvsI2HZm/rhHvJdqkpj/Wrcry1wxfqrF45ts2xeZxRDZ/PYtD+aQjCUaUAofjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmcsJLrP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmcsJLrP"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c053a107b8so297458785a.3
        for <damon@lists.linux.dev>; Tue, 11 Feb 2025 04:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739277888; x=1739882688; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zyxp4qKor0yB6Upvj/J6rwR1h/DvEyqLUMvE/8sgvM=;
        b=YmcsJLrP7gOA9vyiFO6PosP4xL789gAa6hoFXffdv4H+lkr2POAaFDYTcJ9YEpJQ+W
         Jxi6GmMVeNuB8VedzBFkMUb1aeDXizopkZyo337ntKnFlZyWiNHFLGucW/ZNq//PWCg+
         Y/uW9e7vkKd7rB6p008asCDWR4rnypSvImvHlZjEkNA0cUQ4MENTiD1ib2AuUGhdzhQa
         B+1xy+Y+hFmV5nhtjrhnHjhjijaVFQVymvV8jn7mSyEtRlgEGpdI8J1zVao63GtQI8l8
         IYgV4SdzstXIYWYBDt+TkTzV0mhpVaYj4Db2R7qU98+mI9oCigOs7oEIgYBUF24Bi/qe
         kP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277888; x=1739882688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zyxp4qKor0yB6Upvj/J6rwR1h/DvEyqLUMvE/8sgvM=;
        b=OeOzcE0ByeSne4EdujUCinkiclptWkEWtDriE5R4wF5AOwXhw54UB0Nt7cPvZumaYy
         DNsTznRt+QtI0SPkR89te5Z+cLah08+JuyRu2dLUsuso+/II66c1wGXxtXC8yy41RQpt
         rZoZdh9cIv4SYbbTdRAPLLfo5SEXTShr6XcURVgP1l0PDO6YEpx4/ufypHmZHVO1to45
         FwMhIiTk4XR2nx/oQNA8A2/dSaASTjXc6ZcU1GcJ0bP1DbxiCeEncR+MznJf6AcdmB/n
         tMfe/xU2Ia08MV9XirUWBVcrPI582FePqRMLFree45hBxfQX+zT1H1sTmw/WPDbKSDjf
         swkQ==
X-Gm-Message-State: AOJu0Yw8IbVjvSMxJUqND/KSnx2yvJGOCSmfKwC2ZGUdCluT976V3jXo
	0i+d6RUqVXiGIPkTqWtGMPhGtrM2Sg8Kitml/JCJAaDKGoR7Licn
X-Gm-Gg: ASbGncvXLOhWmVpaz77ChxZTeOFzUE+FJ8xt0KNxFIP6+0U5x1cvskFZyxOgfjd9O8A
	LDg4TvLA/3IL44qzfNKylwQQS+JrRprYA2/JMga4ePTeSMtPbka1DSgL1qdIiDSLcFA3hJvaIx9
	62Y/+xXhH902f1vp4+OHrljp1l+ILsqEo66jXYPg2aiid0TxNBtBmhCjk3hoTrPxme9G5FieXKn
	AAqgYXumm9JY9Rnj/QM5OvemCl+40+2SPYwYjSwFknFDh0is36DJMQBaFXM40sILoVgcUJUWOKL
	RCpfy59syEGwTg==
X-Google-Smtp-Source: AGHT+IEJTN8x+UN6cPapypXGlWsjEzOvc6OtH8mxzRq/xr3rROZkgpXaGMFGqSd9HYs7jToaBiYx2Q==
X-Received: by 2002:a05:620a:2795:b0:7c0:602c:e689 with SMTP id af79cd13be357-7c0602cebd1mr970692185a.16.1739277887826;
        Tue, 11 Feb 2025 04:44:47 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:46::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec2e9sm663299485a.20.2025.02.11.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:44:47 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 2/4] mm/damon/sysfs-schemes: add files for setting damos_filter->sz_range
Date: Tue, 11 Feb 2025 12:43:41 +0000
Message-ID: <20250211124437.278873-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250211124437.278873-1-usamaarif642@gmail.com>
References: <20250211124437.278873-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add min and max files for damon filters to let the userspace decide
the min/max folio size to operate on. This will be needed to decide
what folio sizes to give pa_stat for.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/damon/sysfs-schemes.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9020bc9befac..881d00bb3a34 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -316,6 +316,7 @@ struct damon_sysfs_scheme_filter {
 	bool allow;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
+	struct damon_size_range sz_range;
 	int target_idx;
 };
 
@@ -474,6 +475,44 @@ static ssize_t addr_end_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t min_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%lu\n", filter->sz_range.min);
+}
+
+static ssize_t min_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->sz_range.min);
+
+	return err ? err : count;
+}
+
+static ssize_t max_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%lu\n", filter->sz_range.max);
+}
+
+static ssize_t max_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->sz_range.max);
+
+	return err ? err : count;
+}
+
 static ssize_t damon_target_idx_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -520,6 +559,12 @@ static struct kobj_attribute damon_sysfs_scheme_filter_addr_start_attr =
 static struct kobj_attribute damon_sysfs_scheme_filter_addr_end_attr =
 		__ATTR_RW_MODE(addr_end, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_filter_min_attr =
+		__ATTR_RW_MODE(min, 0600);
+
+static struct kobj_attribute damon_sysfs_scheme_filter_max_attr =
+		__ATTR_RW_MODE(max, 0600);
+
 static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
 		__ATTR_RW_MODE(damon_target_idx, 0600);
 
@@ -530,6 +575,8 @@ static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
 	&damon_sysfs_scheme_filter_addr_start_attr.attr,
 	&damon_sysfs_scheme_filter_addr_end_attr.attr,
+	&damon_sysfs_scheme_filter_min_attr.attr,
+	&damon_sysfs_scheme_filter_max_attr.attr,
 	&damon_sysfs_scheme_filter_damon_target_idx_attr.attr,
 	NULL,
 };
@@ -1954,6 +2001,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			filter->addr_range = sysfs_filter->addr_range;
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
+		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
+			if (sysfs_filter->sz_range.min >
+					sysfs_filter->sz_range.max) {
+				damos_destroy_filter(filter);
+				return -EINVAL;
+			}
+			filter->sz_range = sysfs_filter->sz_range;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.43.5

