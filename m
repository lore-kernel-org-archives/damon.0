Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348D39E6E4
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541407; cv=none; b=Ye1rDeNth29C1J/CsizDTXuwoJAbwSoT9cAkg2GdriyMIF8BvIMcxNVjn/hsoMyftj/SaBHmYE1EGqrhtpLoEbcYZh1Td8TETjCGzkqWQ7b1m0oejB+FTBC+3GLtxfnFUZnK1qii6WMYcV9iSUJ4CXKAxWaPllUXKcywvNJKQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541407; c=relaxed/simple;
	bh=RPHm/I6WqLfqccNlVusRSjc2hzPQak1wVwmSFNX0Rvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIE5YEjoXx6PlUKdP6QSLk6pT+wsgHuR90g+VJ7Yz2xvSOO9hCPRh9t3fhHogNx9OoaU38lKdqcNJMKISFwjGBh+FsWeGdtBqs8nXZzEW1D0M9Xo6I2lyytoRZxwfVsk3ZAXv0ZdQSrLBlj2o4GvawAQGP0yTki//gy94dXF78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLe3jJpB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLe3jJpB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf52d15d88so13229175ad.2
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784541403; x=1785146203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4P1uAuS96oO2CYd5dZWKgEcG7rXEBr6r3ZYGLFiIQg=;
        b=RLe3jJpBcLemP7gp296U2jbDfelJjsAF23OtdUQOaeAGHkc0F2kfAblefCLbmv6o4n
         P/JSGbVDxr2pHQqqXlXwqGdRgNwNm0h/6fsK8i0R7QdkPvcs8czMLbJKhV/7kDrkvbt9
         KVaClOqpUo/oUN4Fh12pu0GM3pWvNsRKjYmzyukqPvLVKroV1CTras1EmsnK8ci2cqn6
         N/UDJOq/QBVXJJIMCdbp7fkZSxRia7XmQ+UiefngtwjAD2zUckEAjNXcYIUt6GKWcmd4
         lUryXoJDX9ABuDxw2shh1ZLH+cMnvo2dXRyGY1/7z2YAIhdrl2aNmpVvFK9zhr8I9ixE
         8VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784541403; x=1785146203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4P1uAuS96oO2CYd5dZWKgEcG7rXEBr6r3ZYGLFiIQg=;
        b=JRtO8wz7yt58rQ5Wu+0sWDupVNIbYB63aqKo7w4uHpAtPbl44SMZPGbMGKM+d6uPoN
         lq8EIGsWwjzmrGGmbDUMnDW1yDm8FbFjaqm+7FCoKzlkslDR1eR797gDcRlIFqaHmpVJ
         xYklRb5yr+BJzrZCJ0imfjatliPa4dGerYSTL3aUx4tMvqjFCD3OeuR7Ze89BsAvMcGL
         FCwUsbfm/Hvp4n1f3C4prQmNcX1nn0S40jbluFqRoNrCm3Yw/KTVHNuDunc6cZ7YNERM
         p8AuVJmzBBKpe+Rx/bqVJ6c2eHGPbj17c7wGHmOsAiQOxOU5JBoYvbSrc1X2o3gP5b+o
         UAzw==
X-Gm-Message-State: AOJu0YxYTdkZvXEm5mj4GBGLH5drGq6BM3OuKPMemnetdeJUMhU7DMvd
	63C7SAIpe6ubAzxlpN7UAelqcV6ORrTchcto0+VGpr/RdBwjLTbNfUnp
X-Gm-Gg: AfdE7clKhfTJ9GiuFTSJfZHTM41gKg/1kt+BNThiKSzFQUf8uHWj50G11BjsNUYTOHH
	zsmG3Fu+ppoe4I32Jqkf16ZHN/a0tCz1waW4PZSDOSShUR3gs7NevH4OmVDq2ZznmE7jSRBy3kP
	Utc4KpzInhXbbtq1d6M2SKEQ19v3wbQ2Yv4JExlc+zqJDZFRStkf59K65wQ2iI3lM/ougm9bb17
	JmwVtG3vkCsbBCOjDUvusoaK7D0fx+ETr32WvMrqyUac5pQfg+2JGqIBInqdlvFyruLiLNTh3Xw
	LEm9Ie7DrGiQ7oubwim/QJsreypfzKLnF9VlXr4p7wnTSDDkuE4UHeHWFNw9/zUCIOHAiIfU4vK
	jHIemvPIhGAAy0UKz8VGahenKcXoJgD9H0Ctti+FH3CQxg9rd3Iuz2AqMPuzP1daVx2lna+UM8O
	eF86wITh3CP2ie0StuvyZfVzA3GMs=
X-Received: by 2002:a17:903:440c:b0:2ca:1594:451e with SMTP id d9443c01a7336-2cf3496b583mr155402025ad.31.1784541403123;
        Mon, 20 Jul 2026 02:56:43 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bd3aesm53940335ad.26.2026.07.20.02.56.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 02:56:42 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: david@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
Date: Mon, 20 Jul 2026 17:56:33 +0800
Message-ID: <20260720095633.32281-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <59292ba2-e0cc-4e50-bb26-be9c15843a41@kernel.org>
References: <59292ba2-e0cc-4e50-bb26-be9c15843a41@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

On 7/20/2026 10:44 AM, David Hildenbrand (Arm) wrote:
> you give no real motivation and evaluation why this is required or
> why this gives the user any benefit.
> A SPLIT with an explicit order is not really want we want and it
> does not fit the existing primitives.

Thank you for the direct feedback.  Let me explain where this came
from -- the cover letter should have included this context.

This started from a real problem at Sangfor.  The scenario is:

  KVM-QEMU virtualization on Kunpeng 920, with KVM guest memory
  backed by tmpfs shared mappings (THP=always on the host).  An
  Oracle database runs inside the VM.  DAMON monitors the KVM
  process on the host to measure the hot-memory ratio.

  The KVM process allocates and uses a large amount of memory.
  Under the same workload, DAMON reports a significantly higher
  hot-memory ratio with THP enabled versus THP disabled.  Direct
  tmpfs write tests inside the VM -- touching at 4K and 2M
  strides -- show a clear gap between the two cases.

  DAMON parameters used:

    operations=vaddr
    monitoring_attrs/nr_regions/min=500
    monitoring_attrs/nr_regions/max=2000
    monitoring_attrs/intervals/sample_us=500000
    monitoring_attrs/intervals/aggr_us=20000000
    monitoring_attrs/intervals/update_us=60000000
    schemes/0/action=stat
    schemes/0/access_pattern/nr_accesses/min=1
    schemes/0/access_pattern/nr_accesses/max=max

The underlying issue is that under PMD-mapped THP, DAMON's monitoring
granularity is coarser than the actual working set -- a single
Accessed bit covers 512 base pages.  Before SJ's probe infrastructure
arrives, there is a gap: DAMON cannot distinguish hot sub-pages from
cold ones within a single THP.

Split is one possible mechanism to bridge that gap -- by dismantling
the PMD mapping, each base page gets its own PTE Accessed bit and
DAMON recovers fine-grain monitoring.  It is not intended to be a
permanent API, and certainly not "the opposite of collapse".

I did not write this scenario into the cover letter because our test
results do not yet show a clear quantitative benefit worth claiming,
and I did not want to oversell.  Without the context, I understand it
looks like I randomly proposed a new primitive -- that was not the
intention.

SJ acknowledged [1] that the monitoring problem under THP is real.
My RFC is a concrete proposal to start the discussion.  If split with
an explicit order is not the right primitive, I would appreciate your
thoughts on what the correct DAMOS abstraction for this should be.

[1] https://lore.kernel.org/20260620203915.82947-1-sj@kernel.org/

Thanks,
Lian Wang
