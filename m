Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FC1D5CD4
	for <damon@lists.linux.dev>; Mon,  3 Feb 2025 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623382; cv=none; b=o/JrIiefKufIk9GgneY7hikJPxJWDzMN5L8MP2hloxkQNhzIVBFxgGXyej7mODHEwPhEetqdpHBhb7HIdYFpBIWAzn8G/uoViDUUXwwOEk/LaC2/hCjMQ2Yf7z5kJDmpof6xvIxnMNx/dlUj7HzhAoEBF6i2T7t+kzSYqFPEuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623382; c=relaxed/simple;
	bh=fLVyTEV1OFo7/VV9uiQhKo+rtXBWHKl44JXem+syIC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxUfUvt9ByxPCpDic26WW8OnkdA9RpU3uz8DhkVOCebP//o78OzO1yncRRorzDAF2fzsT79AEGYTeQk9AwTAKsXRl5OTmU4OaGEBeZrOOsqlkEovLzsItcVeEx3obgVGjJtM4hiJ8F1JO8AOxjeXwDs/Mu7RqmwzVBYEPYaxv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Y2hYTP; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Y2hYTP"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd01781b56so52759706d6.0
        for <damon@lists.linux.dev>; Mon, 03 Feb 2025 14:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623379; x=1739228179; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SznZScwVx0h8bqXh4qDWiYSeLp6PkS46eqcLFfP1ky4=;
        b=A/Y2hYTP3h0E/Nz8X7MxuIi6mem1u7okh2xmw7zglPqeT7XMXljFVGlu9lrAYLoY3d
         YYtHjv6iWE8gKOyjhQU3W/m0vM6kJMP8n4nsi6+vVVGBOYDzBMqyp3dqbL60mR/ohkc2
         OBHR3i13so1ICJSBLFbVlX99aXWdEuufIXi0YsXfG6c68fbyykVkB9CAF3u1KPyBgsYJ
         P8ZKlgz4N/udg5GUk7SJuIUA4Asohw9LF3Kjv9Jn16V6z1CzYbF8HkxhgOcnjL2PJIBR
         8kYFXt2si7AcpX0cBcw8d0tnOmigPNPckwu6q3500dPFLk7sTiolyImBeOG0DDXMCZHY
         8sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623379; x=1739228179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SznZScwVx0h8bqXh4qDWiYSeLp6PkS46eqcLFfP1ky4=;
        b=Vn9w6Q2nspmnM4JNG4gaB7xp8/OggV2LE76kWSQiCjVYpu+Qr3QkjGJ81P+dGgPra8
         HDmL5qwMuAXGBLHHCf5uIpTHbJLmH5rTaR/kXNMu8UMGVRlGJC/IV09vdaAmANGfttOR
         AfSblErfW1iLRhLY1NJSxvPvdrUZVzCyd42U5aRdUh3fxiJrxcf9shzADbx72pm5c5V4
         QwAp4YAu/K/OM/nhXhInHzNrAjxUnUvx9EH+eYIWQZtecMFXq8QSHLB6JTRUCc/nKzoY
         EoAqp3szsJWC/KxtrF4kGNUrzE04XidDaQsmE62UATUYM9P5ie/BuUo/eVUjhDPL2kx1
         lqPw==
X-Gm-Message-State: AOJu0YybxXS+5CGVv4cSCiWPA6x2sol+b3QmfwpjA+nLeb/B8ES7bokV
	OgB6aQbplHXPEM2BtJMUzPyoM/7f4gw5DSiCVyfVdvweKEt9lVio
X-Gm-Gg: ASbGncvDLm3MWd9kJnFmjpInJRM7q8k6LHnszxVlrICzOLE5rEz3nC0n0CRjzIYBpNc
	/d1TfqTjIqyS3AIVz1jqGcDCnjrUMSOWqJ0mXHGbgO6w0ILEusqrsYIZ+6RCY/n6niMUWcmbCct
	KAbWk+smIETDJ7Q1ZPM7hDn9/k08q8czmM6ZuXyOf2/IJ8cHZO1t6qI5XZJMExNNAHAERfdkz8F
	agEQDhcS8pT1MsLRxh51fDk7v4mPKOjsLVpbANtByKGxKSNaOW3ibGKD/6HqknkOSQ4+8YG8Olb
	jiSJRGVDa6yamg==
X-Google-Smtp-Source: AGHT+IHolYwlmjrVZZLm3U+zwl/FznhpD+yD7VG24ol3h/GVVlqv4G30P3bbLumNQdAfUzhAeEqEsg==
X-Received: by 2002:a05:6214:1c86:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6e243b90ed5mr303232856d6.1.1738623379118;
        Mon, 03 Feb 2025 14:56:19 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254922857sm55094796d6.87.2025.02.03.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:17 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 3/6] mm/damon/sysfs-schemes: add files for setting damos_filter->folio_size
Date: Mon,  3 Feb 2025 22:55:30 +0000
Message-ID: <20250203225604.44742-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203225604.44742-1-usamaarif642@gmail.com>
References: <20250203225604.44742-1-usamaarif642@gmail.com>
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
 include/linux/damon.h    | 11 +++++++++
 mm/damon/core.c          |  3 +++
 mm/damon/sysfs-schemes.c | 53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af525252b853..6f30ceeff215 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -35,6 +35,16 @@ struct damon_addr_range {
 	unsigned long end;
 };
 
+/**
+ * struct damon_folio_size - Represents size of folio filter on [@min, @max].
+ * @min:	Min size of the folio (inclusive).
+ * @max:	Max size of the folio (inclusive).
+ */
+struct damon_folio_size {
+	unsigned long min;
+	unsigned long max;
+};
+
 /**
  * struct damon_region - Represents a monitoring target region.
  * @ar:			The address range of the region.
@@ -377,6 +387,7 @@ struct damos_filter {
 		struct damon_addr_range addr_range;
 		int target_idx;
 	};
+	struct damon_folio_size folio_size;
 	struct list_head list;
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c7b981308862..27323e3a800d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -776,6 +776,9 @@ static void damos_commit_filter_arg(
 	case DAMOS_FILTER_TYPE_TARGET:
 		dst->target_idx = src->target_idx;
 		break;
+	case DAMOS_FILTER_TYPE_HUGEPAGE:
+		dst->folio_size = src->folio_size;
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 98f93ae9f59e..bc7ca43ca9c4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -316,6 +316,7 @@ struct damon_sysfs_scheme_filter {
 	bool allow;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
+	struct damon_folio_size folio_size;
 	int target_idx;
 };
 
@@ -469,6 +470,43 @@ static ssize_t addr_end_store(struct kobject *kobj,
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
 	int err = kstrtoul(buf, 0, &filter->addr_range.end);
+	return err ? err : count;
+}
+
+static ssize_t min_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%lu\n", filter->folio_size.min);
+}
+
+static ssize_t min_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->folio_size.min);
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
+	return sysfs_emit(buf, "%lu\n", filter->folio_size.max);
+}
+
+static ssize_t max_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->folio_size.max);
 
 	return err ? err : count;
 }
@@ -519,6 +557,12 @@ static struct kobj_attribute damon_sysfs_scheme_filter_addr_start_attr =
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
 
@@ -529,6 +573,8 @@ static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
 	&damon_sysfs_scheme_filter_addr_start_attr.attr,
 	&damon_sysfs_scheme_filter_addr_end_attr.attr,
+	&damon_sysfs_scheme_filter_min_attr.attr,
+	&damon_sysfs_scheme_filter_max_attr.attr,
 	&damon_sysfs_scheme_filter_damon_target_idx_attr.attr,
 	NULL,
 };
@@ -1953,6 +1999,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			filter->addr_range = sysfs_filter->addr_range;
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
+		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE) {
+			if (sysfs_filter->folio_size.min >
+					sysfs_filter->folio_size.max) {
+				damos_destroy_filter(filter);
+				return -EINVAL;
+			}
+			filter->folio_size = sysfs_filter->folio_size;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.43.5

