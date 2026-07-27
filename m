Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685F42DA40
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170869; cv=none; b=OFUCreswtXsY1+bV1MipdTy5pLbqpchxHXlA/S5cJduXn9XPYBoxDp4oN3wm/zZC362orr+xQdbIxnpUg16zG6pTAmKKkCA++ViqAVQfd0D9HEt4VBjmnmpiZmurRqrq808fM6zjPJIkYmdI88rRDkPolmCcfSzVplPt0OygnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170869; c=relaxed/simple;
	bh=HTxL5I80nQ3dFGJzsPYMsGaUEA0cATezEAGoZ6SZAko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWJUze9tH1EcWP1j9bImgycgYMVDdT4X6Lu2FrSsmW+kSZjWDDSCNN0v93ciBJOOxegy3uxNL+jwoNCh82ggdRyl1GXX03wricu7TtRXTpHz+xClSbf2Hm4VOU6G3+BksKrMBkwKmtx6EYwxXSGSwNFWt5f2/mYhs39dsjsgZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cD/2EUfM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cD/2EUfM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F79516F8;
	Mon, 27 Jul 2026 09:47:40 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB9873F86F;
	Mon, 27 Jul 2026 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785170864; bh=HTxL5I80nQ3dFGJzsPYMsGaUEA0cATezEAGoZ6SZAko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cD/2EUfMuUeyBVWNFHChNrDBH7K/jYSjTJKf2AXn2R9DI+PVxfhjgfb453XXO3T00
	 wM2xtUT1X0QX+sopNRnwbQI/o96tO4ir4xNQ7qJwgqdJF5QNcWrVk4USoCTYK5iOy/
	 9Wp82ZRCjM6t4RzOb3pUepvrD42VVL0Lu3oBSBc0=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	SJ Park <sj@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	ziy@nvidia.com,
	pfalcato@suse.de,
	agordeev@linux.ibm.com,
	ryan.roberts@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
Date: Mon, 27 Jul 2026 17:46:52 +0100
Message-ID: <20260727164715.2866609-2-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727164715.2866609-1-usama.anjum@arm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pte_t is used both for logical PTE values and for entries stored in a PTE
table, so pte_t * does not distinguish a pointer to a copied value from a
pointer to table storage.

Introduce hw_pte_t as the generic name for a PTE table element. Define it
as an alias of pte_t by default so architectures retain their existing
representation and behavior until they opt in to a distinct storage type.

Include asm/page.h so pte_t is defined before the generic alias.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 MAINTAINERS                   |  1 +
 include/linux/pgtable_types.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 include/linux/pgtable_types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15dd00c7ffec5..78aac05949829 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16981,6 +16981,7 @@ F:	include/linux/mmu_notifier.h
 F:	include/linux/pagewalk.h
 F:	include/linux/pgalloc.h
 F:	include/linux/pgtable.h
+F:	include/linux/pgtable_types.h
 F:	include/linux/ptdump.h
 F:	include/linux/vmpressure.h
 F:	include/linux/vmstat.h
diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
new file mode 100644
index 0000000000000..ed5dba42a4f8c
--- /dev/null
+++ b/include/linux/pgtable_types.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGTABLE_TYPES_H
+#define _LINUX_PGTABLE_TYPES_H
+
+#include <asm/page.h>
+
+#ifndef __HAVE_ARCH_HW_PTE_T
+#define hw_pte_t pte_t
+#endif
+
+#endif /* _LINUX_PGTABLE_TYPES_H */
-- 
2.47.3

