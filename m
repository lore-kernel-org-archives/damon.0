Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728742DA45
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170952; cv=none; b=V1lJTaORLM127l3j04HHhlp7u5/ojrGFZvH7QYnnyA7DqSO0XcNL4e/dyEqsEZQf4fzQ7a3dYjUY5/QZA6b5klvN5gSBkOtlM9+WdLZr7VIN9X/FCfexhoRdyiMy3kepCTCQkLVZPcQcVdn1DXYSoVk+t+G5QUDC0kXfE8j4UDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170952; c=relaxed/simple;
	bh=0q+7yLXlDlEamYyqT8+gJuMmLMdePag4Q+fMTD4K878=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1HNknU1znWFOw/Ve89oe5AeSD1vweYfpHTPJg3nb07ZWP/m13E8l7lqRuSb/Wgr2xOqbrsoMbg1vlZ4RoP5ykKqpS822767hnTqSLp/sX4ZEC1RA9xzSBF7J0MxjXqOQBWkJhlcHffYCAj5tTI5+T7lagNjfujVVF+Mbk67QaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ecDWkEbb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ecDWkEbb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF6CA175A;
	Mon, 27 Jul 2026 09:49:01 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B7693F86F;
	Mon, 27 Jul 2026 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785170945; bh=0q+7yLXlDlEamYyqT8+gJuMmLMdePag4Q+fMTD4K878=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecDWkEbb2qtk+8ohd6Kewpw4n8VlI4E4Zyq+L1811WJFybbUDBiT4Z8cWhNiPrkBi
	 yWBZRoq7dWSZtF4v40NFDEpiduacWSK35tbmzo9qGFoi4xbTCiexyO5JyvZMXpFccf
	 raReWNwEs40DmEFZyWJK+vCB10Q+0nVfqhCKOuXI=
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
Subject: [PATCH RFC 10/11] parisc: use hw_pte_t for the data-break callback
Date: Mon, 27 Jul 2026 17:47:01 +0100
Message-ID: <20260727164715.2866609-11-usama.anjum@arm.com>
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

The DEBUG_DMB_TRAP path passes set_data_memory_break() to iterate_pages()
for PTE table storage. Update the local set_data_memory_break() declaration
to take hw_pte_t * so its argument is identified as table storage.

The generic hw_pte_t alias makes this a type-only change.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 drivers/parisc/sba_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index d9339dd508262..27a7efe3e0a70 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1697,9 +1697,9 @@ sba_common_init(struct sba_device *sba_dev)
 		int res_size;
 #ifdef DEBUG_DMB_TRAP
 		extern void iterate_pages(unsigned long , unsigned long ,
-					  void (*)(pte_t * , unsigned long),
+					  void (*)(hw_pte_t *, unsigned long),
 					  unsigned long );
-		void set_data_memory_break(pte_t * , unsigned long);
+		void set_data_memory_break(hw_pte_t *, unsigned long);
 #endif
 		/* resource map size dictated by pdir_size */
 		res_size = sba_dev->ioc[i].pdir_size/sizeof(u64); /* entries */
-- 
2.47.3

