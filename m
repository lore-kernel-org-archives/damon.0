Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D71204F8B
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750155; cv=none; b=JSBu0wynQshHs9djeSUtLO9rYryim/hiIhhSpvar5K93m5Hzb3qGwQlLG6YZlCIpXtUta68w2oaVucSc66wGs3NOV6HLOaJE4eVHh2z9sYoDdcwFRYRpCJm7GjcBGDrE2eD7C/K2dgHdpkjMITAeqrS24mS63aN9Gz+VS1RazhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750155; c=relaxed/simple;
	bh=MuywZZqjbsDPW/ovI/OCTMqxWg2NlbhEOkNx8sr65qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXA4CrOC0V3OGqzrA2hkasjxcEJvI7KCKsQowUv60jXY1ZT3iLmeIEe3qqKdjgukQ6SOt7Kb9hUWV4dp9J9PWVdrHYHmLmSV8THNVg9KllZVOM2RkShrTsa7EKZv0U4LD+GH7kthuWX6Ud7jBIklktzln5H1qy+RS4JaCZrlpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gli9KhUC; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gli9KhUC"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5069df1de6fso31649431cf.3
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750153; x=1772354953; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AivjDh5huKNjDD2xsREV6Gpi4uqBqXwxpevrEGioofI=;
        b=gli9KhUCYOupA+VT2D2wu++u7CxERzfoBWXlCRh/awZCvEZuze4AkxK4BAq+hSWHVK
         YUMkx61ORh1YqWwM/bNLtbvl4fkYld1FMc7V20HPpOLJ2JcoHBUxfXIsa1v1El2+rJ/r
         4+GRr2Kcb4QBoqy12YTBjGY7+SUVzBlaJ0d5wR/Y4SNOY6ALuOFSxexA75HNjfSkbsVd
         QCxaTU/dxxUBJXPIQB1l7mAsdg6WjPt4WwdT/1k6bkyeEoQg8ATOliUNN4tdqnWLbxSo
         OCalk+IxctKbd9CYA7V61ebJCp8kbjubem4DHAQ+msnAqbKAMxxXaXuL6OL7iroZH9tS
         xFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750153; x=1772354953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AivjDh5huKNjDD2xsREV6Gpi4uqBqXwxpevrEGioofI=;
        b=s7Qz/AR+hl2BMrnEakLJl7UX8EjEiirI12taDeFdmet8pRFrEf70WQLlRdf4UzhWSl
         f5ri+u3/u59NTpwhXB83/ci+4Gbtl4nKCGJEOYjw0vhY0kUo7IB+kfayxf2SiHEtyqf/
         Vi/K1NguXnBY6vy/SC0XSp9gaU3Vw4RtEApna2UuijBvbuWTW+rTFUZuAQHmGNp5Nl49
         ggoEzwW1G1Fr4eKE/jXpNYA9KOjo5jo5R6jsqH+/VYCt9kWjfSroNNoOmXK9kfLVog0E
         iIqUTXDoGkEuRpn/osnODUGwLAi7unR1xMJfV7qwg4QGZ4fsoqr+lf/W3/bK4p1L0tZV
         /VhA==
X-Forwarded-Encrypted: i=1; AJvYcCVv7PtnbXML7Q1KAcSO+QKXyMq+YurPicKXyLwpg2yTvT4sYRopdJmCHxwqL5eeLKZfspwlzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YztTnMtq7odUIJpSAIH+0d26hXKsKcUMILNGgMLfWq7g2NUdNPA
	8SiD0OknAe72JtGxnjwcG3AsmuHxwCdBQ4PiSwL5fraz5XgwAUFaN3SxKk8mLEXOZWw=
X-Gm-Gg: AZuq6aI0toaoGTbifHrFAbXeBFt4NZWRcY7fzP0t3v4IGrusan0rFRf/xO/QnFZhQet
	JSUYsszAaLjz+IiiKYYnq6n3AwG9Su4/ZkXpxLn8NMq+f74jgQ3hbBkIr7rKs/yrCB/JRBt6Oo2
	KmFOSvBdEX6UMMkDW78YdPynyOmnWKXpDKceM/vc6ot20Jqe3CTzBms/5YZTshv/CchHc4fpv1M
	bYeZz3bSrIRIJ5tbrnFhzN0aW42CJ1xjecd+exi3sQvkAbySDrs+nUmctco0+3DoJ3OYCe+YAO/
	pssHFmyC1lCdWg7yc8bzBdeT09k+msS9yzvjpGAdaDXo/JoNpMlMo+g/CYFhScxiBlMEgTLj76l
	jD3ktmqJFaz5wOYLxgv2LtXE6Zgqrrb1Yur7hfkkvkEMxTRxgXy5+FKWpq0A5P2oAVtSrKhrSdN
	MSH0MmDZf3Y4LEPG0LMUfUokLiWjxP8IpB8mmOH8bnBQPIKkgTA8ViosMHCdSudLZE2Tl+l+vM8
	teMbiMz4n3PQDulFotKvsBNUg==
X-Received: by 2002:ac8:5d0e:0:b0:501:4f3d:1469 with SMTP id d75a77b69052e-5070bca9b16mr59670661cf.52.1771750153314;
        Sun, 22 Feb 2026 00:49:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:12 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 05/27] mm: introduce folio_is_private_managed() unified predicate
Date: Sun, 22 Feb 2026 03:48:20 -0500
Message-ID: <20260222084842.1824063-6-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple mm/ subsystems already skip operations for ZONE_DEVICE folios,
and N_MEMORY_PRIVATE folios share the checkpoints for ZONE_DEVICE pages.

Add folio_is_private_managed() as a unified predicate that returns true
for folios on N_MEMORY_PRIVATE nodes or in ZONE_DEVICE.

This predicate replaces folio_is_zone_device at skip sites where both
folio types should be excluded from an MM operation.

At some locations, explicit zone_device vs private_node checks are more
appropriate when the operations between the two fundamentally differ.

The !CONFIG_NUMA stubs fall through to folio_is_zone_device() only,
preserving existing behavior when NUMA is disabled.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 6a70ec39d569..7687a4cf990c 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -92,6 +92,16 @@ static inline bool page_is_private_node(struct page *page)
 	return node_state(page_to_nid(page), N_MEMORY_PRIVATE);
 }
 
+static inline bool folio_is_private_managed(struct folio *folio)
+{
+	return folio_is_zone_device(folio) || folio_is_private_node(folio);
+}
+
+static inline bool page_is_private_managed(struct page *page)
+{
+	return folio_is_private_managed(page_folio(page));
+}
+
 static inline const struct node_private_ops *
 folio_node_private_ops(struct folio *folio)
 {
@@ -146,6 +156,16 @@ static inline bool page_is_private_node(struct page *page)
 	return false;
 }
 
+static inline bool folio_is_private_managed(struct folio *folio)
+{
+	return folio_is_zone_device(folio);
+}
+
+static inline bool page_is_private_managed(struct page *page)
+{
+	return folio_is_private_managed(page_folio(page));
+}
+
 static inline const struct node_private_ops *
 folio_node_private_ops(struct folio *folio)
 {
-- 
2.53.0

