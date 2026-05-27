Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D963F58F7
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880090; cv=none; b=I3h8R9IsyMaVAVIi8SUu0MTTebZydShDwmSgtpHJc2lWLTZ/nZ14reTDkMXbHMH3Ehf6cCU+aTy8G8c14jpJhJPQKHZ6uCiyA4STIp+QJZjlWHzE5f7eTxmGl9U0ccu5OFDoI2lsj+Jq/tlNb3IVvxasjVDxY5TPNo4wQ2j0wjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880090; c=relaxed/simple;
	bh=6F4C7jXw3kPjRHyDTra56ILH7RMIhMbIQ1DUccefIQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Phsyldw4HooO4WGnBmLKGqyKNZp4YiKbIU1wWVGgmYw0+o8Gr6dC0iakjxuDXnH9F5X6EvgbNZTcDHAexcq02rpwAaRXFm1BF3bQ2RIhd4+ftNkiVNeBR0ClGmQTlWqm+3G5o5P7i8o0Pb1Dcncyogy+rydZx9SU4Xn4V+mWqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=d/GWnyKh; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="d/GWnyKh"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=q/70JID062V814TY2TOyw8EA5k2YWRj4Olo6OZJNrik=;
	b=d/GWnyKhP5OdN/FwoZeN58jllQS4j1OQ9Opo/3nlNKj09J/EjFx9D5jk0CvFygD3nYmcdbfbp
	rCI6J2aiagXzUJlZApf+pFo0AMnJgoLif70IBWoHv3Wl5EA1H/AHwuhSuappH6oOZxlRXMsTTnK
	kMH6ECTvISsLQzWBCPTWAFo=
Received: from TW002-1.hihonor.com (unknown [10.72.0.137])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gQRdj3h0vzYl1Gk;
	Wed, 27 May 2026 19:06:49 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW002-1.hihonor.com
 (10.72.0.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:08:04 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:08:03 +0800
From: tao <tao.wangtao@honor.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<willy@infradead.org>, <sj@kernel.org>, <kees@kernel.org>,
	<luizcap@redhat.com>, <zhangjiao2@cmss.chinamobile.com>,
	<tao.wangtao@honor.com>, <kas@kernel.org>, <ljs@kernel.org>
CC: <hpa@zytor.com>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <jack@suse.cz>,
	<riel@surriel.com>, <harry@kernel.org>, <jannh@google.com>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>, <nao.horiguchi@gmail.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <pfalcato@suse.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<damon@lists.linux.dev>, <shakeel.butt@linux.dev>, <ryncsn@gmail.com>,
	<21cnbao@gmail.com>, <jparsana@google.com>, <dvander@google.com>,
	<zhangji1@honor.com>, <wangzicheng@honor.com>
Subject: [PATCH 15/15] mm: enable CONFIG_ANON_VMA_LAZY on arm64 and x86_64
Date: Wed, 27 May 2026 19:01:47 +0800
Message-ID: <20260527110147.17815-16-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527110147.17815-1-tao.wangtao@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: TW006-1.hihonor.com (10.77.215.153) To TA003.hihonor.com
 (10.72.0.43)

All prerequisites are in place, so enable CONFIG_ANON_VMA_LAZY for
arm64 and x86_64.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 arch/arm64/Kconfig | 1 +
 arch/x86/Kconfig   | 1 +
 mm/rmap.c          | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..9517883f0aaf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -81,6 +81,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_ANON_VMA_LAZY
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SCHED_SMT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f3f7cb01d69d..cc3430eaa7b4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -28,6 +28,7 @@ config X86_64
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_ANON_VMA_LAZY
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
diff --git a/mm/rmap.c b/mm/rmap.c
index e14509b47412..77e2ab95671a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -168,7 +168,7 @@ static struct kmem_cache *anon_vma_chain_cachep;
  *        covering both regular anon_vma and lazy anon_vma mappings.
  */
 
-bool anon_vma_lazy_enable;
+bool anon_vma_lazy_enable = true;
 #endif
 
 static inline struct anon_vma *anon_vma_alloc(void)
-- 
2.17.1

