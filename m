Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95D1486E4D
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431509; cv=none; b=DAoEe2OziH6rxZittbA+2DvJVTa2TG6OP04k6Fzmh/WtKWeRWN7Rs78vEUrAB7e945pA8CRQtfYkbtWLF2Wme6xYxH4EvNNIyNd6i2ARJuw0TI5R18PSf8Ke/e8CXWdVvzpYx0xpX78Lju7WokIjsJOG3w06Q6XmaBJGYUvkzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431509; c=relaxed/simple;
	bh=8uqvVZKecvI6tof0d601k1uUFNGK7TSPrxBJrkWSFMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r91xDOnNwTJ4ajhOyx3hKJaTVLTh1TOOygsK8LYAuCw5/P+RbKYpVylNzy/EkZIpGTkwaVVmbElYtgUzAkgxOLAQdYs8GJ/kx1thdqz5Ult8mJ0ecCtQe1nXwwLvxEFcYF/joUGMVpsAEIqanqIeMMO3lNizjNkD9MBj7zaXLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sXvoBVq6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sXvoBVq6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C8A1F37;
	Thu,  3 Sep 2026 03:31:30 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75F4A3F673;
	Thu,  3 Sep 2026 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788431494; bh=8uqvVZKecvI6tof0d601k1uUFNGK7TSPrxBJrkWSFMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXvoBVq6thF4MC66REFWIycWWSSZel6llh2rEnxk29YVxzxeqTuvKzkLPQExpL5vP
	 VIAxdYcA409XP5txGxWv7JlB54zBOpxe/Awbpe8nex8QVvSi/N1WKiqaShe9lPoTL+
	 u61Zttng6oGMuIVLrzcTlmYO3afTqLY+B5XmFwf0=
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
Subject: [PATCH v2 5/8] mm: convert PTE table entry to pte
Date: Thu,  3 Sep 2026 11:29:57 +0100
Message-ID: <20260903103002.1091859-6-usama.anjum@arm.com>
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

The non-MMU stub receives hw_pte_t but returns a software PTE value. It
has no attached PTE that requires ptep_get(), so convert only the stored
entry through __pte_from_hw().

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
Changes since v1:
- Explain why the NOMMU stub does not use ptep_get().
- Use software PTE value terminology.
---
 include/linux/hugetlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0d2101facaa50..637fc863d3687 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1278,7 +1278,8 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 #ifdef CONFIG_MMU
 	return ptep_get(ptep);
 #else
-	return *ptep;
+	/* No attached PTE that requires ptep_get(). */
+	return __pte_from_hw(*ptep);
 #endif
 }
 
-- 
2.47.3

