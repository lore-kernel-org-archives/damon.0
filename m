Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B242BE82
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170878; cv=none; b=ldvgif//7e02ywtPdlMScdmIEDnBSdKObEFrNWuzH0M6O+FUIQ0aaiQyp3yMeuY+gypuUltU3p8rmfuL/mLlPTCh5Fds0tyHac+d0hrU6j/NTmXT+yQB2ks6phoEGbaR9P0p6vngLw9hlIkguJ4rA6d/gs3Ki4zcJe5mMybL6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170878; c=relaxed/simple;
	bh=OeHCtGC0uAROhEyzqyRGicgDGQ57E/f+pQoW3sVwCjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgYPFRyAb7YYJmwNfq5wcl9b3q0KXc/4TONae/+wI50hdLrn6Ns9Og1XTGKLCflx7ffM5nG6h9TEv5uU8teUSvTij75u4Xgp3XEkRk+MOQbtxhoThYlXv3Ys/CEchZv3eCmou9VoeIFkroYupKxU0pofdPseWqaxn+y3LU8HiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d9t9pVk3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d9t9pVk3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6328C1756;
	Mon, 27 Jul 2026 09:47:49 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CAAF73F86F;
	Mon, 27 Jul 2026 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785170873; bh=OeHCtGC0uAROhEyzqyRGicgDGQ57E/f+pQoW3sVwCjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9t9pVk3z+LotvxypYLqFho7KP5XEkp7l8lfha+xgcBRash4qGjZ0Vd/mV34z3ngj
	 YCiqC4R9lIHqddTtejnz0iRZ+amGDO4RrpcG6DeJWoifcWXWkFCXl4PCx8iVJw3r/E
	 fHskF6P1T34bdcplSjvRlLirD1a3/E+yp9d0XlLw=
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
Subject: [PATCH RFC 02/11] mm: make hw_pte_t visible to generic PTE interfaces
Date: Mon, 27 Jul 2026 17:46:53 +0100
Message-ID: <20260727164715.2866609-3-usama.anjum@arm.com>
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

Later conversions use hw_pte_t in page-table checking, generic page-table
helpers, and vmalloc interfaces. Include linux/pgtable_types.h from the
headers that declare those interfaces before changing their types.

For vmalloc.h, replace the direct asm/page.h include with
linux/pgtable_types.h. The latter includes asm/page.h, so pgprot_t remains
available.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/page_table_check.h | 2 ++
 include/linux/pgtable.h          | 1 +
 include/linux/vmalloc.h          | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 12268a32e8be1..12ee6d16ad339 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -7,6 +7,8 @@
 #ifndef __LINUX_PAGE_TABLE_CHECK_H
 #define __LINUX_PAGE_TABLE_CHECK_H
 
+#include <linux/pgtable_types.h>
+
 #ifdef CONFIG_PAGE_TABLE_CHECK
 #include <linux/jump_label.h>
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a8..cf595608cc4c4 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -4,6 +4,7 @@
 
 #include <linux/pfn.h>
 #include <asm/pgtable.h>
+#include <linux/pgtable_types.h>
 
 #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index e4d8d0a9f30f9..c59a68c183110 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -8,7 +8,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/llist.h>
-#include <asm/page.h>		/* pgprot_t */
+#include <linux/pgtable_types.h>	/* pgprot_t, hw_pte_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
 
-- 
2.47.3

