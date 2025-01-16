Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9122B590
	for <damon@lists.linux.dev>; Thu, 16 Jan 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038689; cv=none; b=aC2zfXBbmxWsngplaEuY2TdUSDib6Hvtb/Lptt23d05N1rUAWtT2LtAA6mrTPCJuvD9kWbEMGy5HKdZCc1nO9rAqhnN6DRmNkCHEyJxTqmwGsQ+tPSfdE1wBrL5tw+rnfRnEUTCSNVVpySVbTYcERDwfnR5dnB5DPQ6FW6z8a2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038689; c=relaxed/simple;
	bh=fWfV1PP1cVxIuOc2S0Xb8cosWmtHFfA3LapjbZXh2OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beuhZgF1OV/E31gkIiTLo+fwRgVHYb0FUA+V0kbkkqYBzs9DOueN3FMpUHwJL16D0IJxCrt13m5u/f1P1Mrzn7Vegvrzxhdi1JUrUP/V8NMRIFS0XFbja6mVSBdwpqUguUI5CXqhmOoMNc7WvecTUor4neo6a3m/jBgzka1r/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF9z0QwR; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF9z0QwR"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6f1be1daeso91209985a.0
        for <damon@lists.linux.dev>; Thu, 16 Jan 2025 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737038686; x=1737643486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B+QyGFJcFFPr4jLp7rJgEDbi3fOKEsn6Qh3/DdOqts=;
        b=ZF9z0QwRyBwR2Yxu+vjJeSSfd61yqcbD2LuYsHPih3W/P74+aGgciq/xxkvSDYFqyf
         AELiQHynA8nLvrhd4daJbCewr+Q08n3LEwNbNQMrELHUMIl3JxKyoSkXnGNnBi8cOrzK
         WxLOtfM4AE3yRNNkVbBOZ4zytfvo2TRxp4LuU2bVKZ/ifOL91XIbqWOjddIsN0QZZAdJ
         WvDIOGSXdkLpI4SeaoDi/KaUiaZQapV8M3I5EbVm34FThGYSk49wYCQ9RiYdj+RtHHi0
         EafvZ+kHdiEtZ4yKHfVfDiQNAk+a0+iHtgKEiuU9MZcuJtwlWoHE93Hxm/Br1vFkqSf5
         xPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038686; x=1737643486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+B+QyGFJcFFPr4jLp7rJgEDbi3fOKEsn6Qh3/DdOqts=;
        b=ooEf6L1Ka9P9plhz6aw79mDzppcfE2UeAdLEvT5wfpCyRUr49CEsvLgT08IpPNHNYn
         OYKrQ1LbOcVADsLhVQfalYsuKYcsqZA1WAsuqsDpr+CCXNAtfYr0m2rZ8rb/fxtDIhSQ
         uxul6uu2L/ihU4/GdmxarikuD66Ocd0I08CgsDD99JRq3wLtYCpVdLk8yLQKbUvWCChZ
         o/R6f3sGtRWm2V8Pwp6+xBpEUv2yzsPXyxt/UDBEWa5bE7Ez5d0t0nl6fC8KMjj6nW+5
         TwXwq1fOPWCDPDHcgft5sbiz8Y/SlVP1HWG0a7DpU8qH1FSPkfJZkVRU+jVcnTEj7hGv
         blfw==
X-Gm-Message-State: AOJu0Yy57mjY34bKgv32S0FysI/G+4csSu0BGkVqAxXVFq5N8/57UJtI
	hHBb3LIod+DXwvZc/Fd56ILI1CyzZhGImM8Xbr214geh1WfVqnN+9hzZ7EIL
X-Gm-Gg: ASbGncv0Lf6v01cpYdlDYoIMJCstFkN4uv7tK83U7o2JlriGqJ3EQHjMEjdoYYxdmg9
	cZzLcCIiqtMAsRE+8/ZMFl5bUVhRNqypZwYKNG3tco/NBAt8mc73ZMNLimZ1GJC41JfZ78niHXl
	73WLRE+cZ7xcLUbjxW7WmMQ9ixdtUjBDdcsbGnjYLi0+gsRFDEy76TwYQcU3qvW5CaGRzD6FvgH
	LgpPhX/FL7sFFUPtmKCALcJnBIQwE8EtYWt2bU50p9L8adHg3zj8g==
X-Google-Smtp-Source: AGHT+IEaNPPwv2jgmflcyY86b/WEwel2W1k8equ5GjnUoSfoOqjiDz0DmZNagpICpan2+ywzoOgFQw==
X-Received: by 2002:a05:620a:45a7:b0:7b6:df08:367a with SMTP id af79cd13be357-7bcd970960amr5194628485a.23.1737038686573;
        Thu, 16 Jan 2025 06:44:46 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be61487360sm10397985a.57.2025.01.16.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:44:46 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Thu, 16 Jan 2025 14:44:36 +0000
Message-ID: <20250116144436.3947318-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116144436.3947318-1-usamaarif642@gmail.com>
References: <20250116144436.3947318-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to gather statistics to check if hotest memory regions
are backed by hugepages. This includes both THPs and hugetlbfs.
This filter can help to observe and prove the effectivenes of
different schemes for shrinking/collapsing hugepages.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 3 +++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af525252b853..1d94d7d88b36 100644
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
@@ -345,6 +346,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
+	DAMOS_FILTER_TYPE_HUGEPAGE,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index c0ccf4fade24..a9e69179d45c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -222,6 +222,9 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 		if (matched)
 			damon_folio_mkold(folio);
 		break;
+	case DAMOS_FILTER_TYPE_HUGEPAGE:
+		matched = folio_size(folio) == HPAGE_PMD_SIZE;
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 98f93ae9f59e..de9265f7ccde 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -329,6 +329,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"young",
+	"hugepage",
 	"addr",
 	"target",
 };
-- 
2.43.5

