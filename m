Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF887429CD6
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170906; cv=none; b=GaubOR9bOyCWCro8oHOADAiHpvV6r8Ah+QZoiU0Mg5bBMTwZD78HVPrqFmDQjlUnvIYfXuhHT/8/AXF3ybJ0rTQAa0c6euRNzQMGs9FvDC0LhYYZfzYonv8/NH4GDDbj6k037m/xL+q9DtJ3KuRyscCBF6bnKebMdg4gqR4DW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170906; c=relaxed/simple;
	bh=qIwnegDzdMrafDzJdJv9H+LswsYD+bpRBZRtWzKb88Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej6TfJ0ep+2rnsFp9vne1Qw0KojPUey3W9I0mNTcbBnGzN2tYXrB+7J6jjCdC9PIv20lGbhNOrzYb8dy4AHGpPtVnCLxMDu32btmRsQENXPkKAHsDK5qOkloMfcRt0Khsv7NntTNd1C8EHNYcrhEkY7EaImOYVnhMaip1kEhwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FO4F3Zw2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FO4F3Zw2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A84A01758;
	Mon, 27 Jul 2026 09:48:16 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 124133F86F;
	Mon, 27 Jul 2026 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785170900; bh=qIwnegDzdMrafDzJdJv9H+LswsYD+bpRBZRtWzKb88Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FO4F3Zw2hXfsGwPhUj1oZO4YZVZFDjBN2uvHs+TxtIa/K4rUEej4TySn/fu7EGLY4
	 vMvQADIrGp/sqI/eek2J5cHHZ8KXrC89o72EJBMI04r1d0coHNWS1Z85TZkghA7MLv
	 xBWvePNCX4gOsv+djUzCeqIiU6OEAmaaKyQdaBtA=
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
Subject: [PATCH RFC 05/11] mm: convert PTE table entries in ptep_get()
Date: Mon, 27 Jul 2026 17:46:56 +0100
Message-ID: <20260727164715.2866609-6-usama.anjum@arm.com>
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

ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a logical pte_t value. Add __pte_from_hw() as the conversion hook
and apply it in the generic ptep_get() implementation.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/pgtable.h       | 2 +-
 include/linux/pgtable_types.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index dad80d264aac2..3003ac9cd81fe 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #ifndef ptep_get
 static inline pte_t ptep_get(hw_pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	return READ_ONCE(__pte_from_hw(*ptep));
 }
 #endif
 
diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
index ed5dba42a4f8c..61afe27307ec2 100644
--- a/include/linux/pgtable_types.h
+++ b/include/linux/pgtable_types.h
@@ -6,6 +6,7 @@
 
 #ifndef __HAVE_ARCH_HW_PTE_T
 #define hw_pte_t pte_t
+#define __pte_from_hw(pte)	(pte)
 #endif
 
 #endif /* _LINUX_PGTABLE_TYPES_H */
-- 
2.47.3

