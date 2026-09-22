Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE76572696
	for <damon@lists.linux.dev>; Tue, 22 Sep 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097250; cv=none; b=jRb9t7mxPbmHTsWPK1LbFodWJC6CDZjGUoSazDE/3TMLBQ2/O+6J1G/k/dslBTaOxS9LzJaZtetwXwd/6KFwfszegqnsIMFC0PwHRCnCXXiITOcLkhYfK6IDpQtEa7xJdi+V9koTIN27at5efR1bLTJbp+7TLPz7jMw/X7BVO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097250; c=relaxed/simple;
	bh=ycUddICsfxEifMnQljPG5LJ+QAfshpGj42pAhJYJWAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOmWz7Ffs0PIbvOxzQsj6sv5iIqRGMMKjCeKTZ4/QaRc9/OizzH5xkF/rgbWwSBA1e3fck9jthf+wT33I6NdYlZNeDxX/V/NThNucuHvYIYSVhMy//B0TwGyUm4f8M3ELw6ClcTJGAky712imhQsPr+xt5iJ/D3sdyufzHMQnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SBP5DIfa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SBP5DIfa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2F91576;
	Tue, 22 Sep 2026 10:14:04 -0700 (PDT)
Received: from [127.0.1.1] (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF53A3FA32;
	Tue, 22 Sep 2026 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790097247; bh=ycUddICsfxEifMnQljPG5LJ+QAfshpGj42pAhJYJWAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SBP5DIfa3nHM7wg1pyznXr/QOoBKyjohtWTUL8njVjJ2HZJ7Dx+/2lyN5lNkmMRzt
	 MkKJj6bY+fLt8c5gDKfHKPh91F5Et1R0ROJrwOWzqHfSea49QFldK5bBAeUeM9p2Ca
	 sZJWLtBML/JGGl2eO59i8Nq/hvCyVDsIRYBYPmlc=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Date: Tue, 22 Sep 2026 18:12:33 +0100
Subject: [PATCH v3 5/9] mm: convert PTE table entry to pte
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-pte0-v3-5-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
In-Reply-To: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Pedro Falcato <pfalcato@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, SJ Park <sj@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev, 
 kasan-dev@googlegroups.com, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>
X-Mailer: b4 0.16.0

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

