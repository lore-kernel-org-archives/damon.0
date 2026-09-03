Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0843B488202
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431501; cv=none; b=DuGAveaHOoTyV/4sC+G7GNJpeKUoJ1s5Ih5CukBWDUCTuts4tGxL5D2ZgoM2hL09pVh6iO/cTg/Esr0viSPPBQcqEHPQvsnWtwmD+5U39dyvAeIfZTrnqBvLZKQ1Z6EgCSX27Sv5vSnPWCUNjSY/rq1zO+lWlP0ZWcGjpWbJPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431501; c=relaxed/simple;
	bh=wa6kw8wVjvVd2W8nAbhMf4/QKJIqMNke43dTRJ3tbuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5MlcVZIH0qChfDGAyLj6GT7CXdzctea/gM5rmUQ8g4KZKfGMH3UdGg8dac7HQ2thD/cUJwKT+XTzAszCNioHNqk1R1wiUkxwm2LhBnOR0axQP1doweLau0FY3gHy2bZ8kGVpRl2rFDSBMomESOSbglnwrJ0TOmBXK0GZ0YqL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QvHhv94l; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QvHhv94l"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BA421596;
	Thu,  3 Sep 2026 03:31:21 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F28AE3F673;
	Thu,  3 Sep 2026 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788431485; bh=wa6kw8wVjvVd2W8nAbhMf4/QKJIqMNke43dTRJ3tbuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QvHhv94lVGWx7TmcPQBRk7OR/PvY0hnXRhX9xVN5Y4qN+GDaWN+Xshh7VTAkVLSnY
	 Jdi6olRL94sQmWoyHi9kc6yp4HLF2iZAObXc9xsiPZr5FAVO73li6Y/Q2PlXwZuEJi
	 tFBQkMsde8wyKBlpx9nCFXxKYf2kd54KRIoPFYKU=
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
Subject: [PATCH v2 4/8] mm: convert PTE table entries in ptep_get()
Date: Thu,  3 Sep 2026 11:29:56 +0100
Message-ID: <20260903103002.1091859-5-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903103002.1091859-1-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
definitions. Read the hw_pte_t table element atomically before converting
it to pte_t.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
Changes since v1:
- Use software PTE value terminology.

Changes since RFC v1:
- Define __pte_from_hw for the opted-in generic wrapper.
- Apply READ_ONCE() to hw_pte_t before converting it to pte_t.
---
 include/linux/pgtable.h       | 2 +-
 include/linux/pgtable_types.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 19098e302b75a..41337da0d65aa 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #ifndef ptep_get
 static inline pte_t ptep_get(hw_pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	return __pte_from_hw(READ_ONCE(*ptep));
 }
 #endif
 
diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
index 07da05d375c2c..d6c5a7548550b 100644
--- a/include/linux/pgtable_types.h
+++ b/include/linux/pgtable_types.h
@@ -8,8 +8,10 @@
 
 #ifdef CONFIG_ARCH_HAS_HW_PTE_T
 typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
+#define __pte_from_hw(pte)	((pte).__pte)
 #else
 #define hw_pte_t pte_t
+#define __pte_from_hw(pte)	(pte)
 #endif
 
 #endif /* !__ASSEMBLY__ */
-- 
2.47.3

