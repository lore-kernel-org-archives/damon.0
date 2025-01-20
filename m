Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC832191F68
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368230; cv=none; b=kbiO0mQ9nCaxuBF6eo0PZ1Av+oYQ5KEKytETBKfqPv0Ts5qFVWSWLMPL+MS0OWMrmPx2CSzgxg8+2lNGR4N/O4SCpBnyHy7SgF/wjYXp6iBX9QsU8j7cZvhImsZjjML9WRJDeRe+iqXqH1BVVuF1Mm0JImmXhCgBIR+fi2pVT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368230; c=relaxed/simple;
	bh=bsUmdhmA5zqIOiag6V93F44tT6i3v4apeMvQ1wy63Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiZutqnAc9MhlK+Xpx5/aBK0h7enCwAgDTo+cN9/O/JCsCND0i48AWpVEhHJieZhcse31dJeDtqp1rnHVhEnyk4SBzc7WZvj4xwOMN9fe1FaDP5GuWaMQpvobzq+mZ0trPecihapLhEzPrN3esqTlRVG91mUNiYK5fC6BxZRfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWqUEKKh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWqUEKKh"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467a6781bc8so36465731cf.2
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 02:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737368228; x=1737973028; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH8n6M1FLf+Q3kYAV5hU2GmbXEqnbBe66cN0Bk155yE=;
        b=KWqUEKKh5pY/aUj/i5L6Tjyu6JYAHPZFdYnjgO5CCvLKVpj+Y3EBzsQS3XqTFCrblu
         INgYZzNSuA7lzjrdDjzuTTAQUrgRIpwu3cmkeph1k/r1d4kYgyjBcdEWsW0M30Lz1RV9
         87HT/ygJaDAZO3A4BfFpug5ge06Wk/lkaQDOqAmxDG57FeNAE5HUhx2MRXtu1E5Rs5lQ
         XBITeCvD28YbgPOG51R7oP+vmSGee/hJNbu5k8lA1eW5P6quzGyeNiLo0HXBR1QjXJim
         fsEYUzSz6zc0KNo3feNw32FpIDCmDAFQcj0hLf3oNWqk81GqV/VKxWkUxB3CsMt9p3B4
         KglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368228; x=1737973028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH8n6M1FLf+Q3kYAV5hU2GmbXEqnbBe66cN0Bk155yE=;
        b=cPQI9/KuNCtH1nXvBgxYEbn781CpWLcwKFfKSy6WD/Q/E2l1nnCWldA45+8/tyBmcy
         kAC1Cl+3RqHLnehJ6RNoJNeNjlHOZZdw4X0onmZY/JVvfz/Apr3jgZ0ilpzYgzPprGLC
         5mnkCpOmeB+nzQMnYEipbJDy6VRyQdZJaI8JYGx7nIx2dIGDElaL38HmZ/VVSA09ImI6
         lBSY01a6+Yif3wAfrO/LHR+KJc1R4G4HbzZSMc5sUMuSwhD7puefO1W3IjH6wERiZgbP
         qKBoUNLj+C0nWWh2mhYBQY8bRvXOlTVYe0OC+HSs4PCXYCOPZVBTI/g8+jY/INLamY+5
         nAkQ==
X-Gm-Message-State: AOJu0Yxe6Z8fedm0iP7iVcvh6SsM/FigUB5DnHV6HKsQ7V7rF85xPGNY
	6VDJej+xh0IH2No/nYKfVLCKHWep6FJq4l1vMp8tZVVBE6NC9VGy
X-Gm-Gg: ASbGnctneFiPFxnNd5eyeMCb3q3PN8k4NwqF1dvLA0hqizmkSTGB61GsVMCGZ5Fj7Rb
	mOgtyahB4j2/VEII39jwHeMKDuMDcND3o9ItTsGJ5+iVR/+H8DDPfZH5mtB1m3QvwXj7Mm+gsRY
	WoG1bYWmot320JFLJeGxyCGFCKt1JuaURaZYwXGJWpo5Cjj2255OeAMoIoZb7Gu/PZqmbdnW87b
	wXcInr2OmwksFQ6LELyJlrl5UT8ulM8K9ztdETYEWhIrGemlRpUl4RWoy6R2IrYaWNT
X-Google-Smtp-Source: AGHT+IFmUgBA3+omEnqHHxh5cbjS72TTV3b+VWTE2szCVUIWMLyqJVzELE/lD1IXBI92VmONmnfh0A==
X-Received: by 2002:a05:622a:1a0d:b0:467:5ea8:83e7 with SMTP id d75a77b69052e-46e12ad56d3mr165357511cf.9.1737368227740;
        Mon, 20 Jan 2025 02:17:07 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:46::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10305328sm40934491cf.32.2025.01.20.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:17:07 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 10:16:50 +0000
Message-ID: <20250120101650.3761306-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250120101650.3761306-1-usamaarif642@gmail.com>
References: <20250120101650.3761306-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to gather statistics to check if memory regions of specific
access tempratures are backed by hugepages. This includes both THPs
and hugetlbfs.
This filter can help to observe and prove the effectivenes of
different schemes for shrinking/collapsing hugepages.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
v1 -> v2:
- Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
  CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
---
 include/linux/damon.h    | 4 ++++
 mm/damon/paddr.c         | 5 +++++
 mm/damon/sysfs-schemes.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af525252b853..b0dbf380ab76 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -326,6 +326,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
+ * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -345,6 +346,9 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
+#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
+	DAMOS_FILTER_TYPE_HUGEPAGE,
+#endif
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index c0ccf4fade24..224308140441 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 		if (matched)
 			damon_folio_mkold(folio);
 		break;
+#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
+	case DAMOS_FILTER_TYPE_HUGEPAGE:
+		matched = folio_size(folio) == HPAGE_PMD_SIZE;
+		break;
+#endif
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 98f93ae9f59e..3eb3ec464591 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -329,6 +329,9 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"young",
+#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
+	"hugepage",
+#endif
 	"addr",
 	"target",
 };
-- 
2.43.5

