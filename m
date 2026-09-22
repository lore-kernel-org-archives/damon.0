Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D26576ED9
	for <damon@lists.linux.dev>; Tue, 22 Sep 2026 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097304; cv=none; b=nrCdZ8IFywzarh9b3v+E9HPDqp7gZk9i/MJh/KZZFSk+Z/+qfmrXQpxnz5BJz5VQRqKL5MPOE61VY2LXlsLOTRmaFbvL75RooSUYd/UnXXVmQlN4kXdR1HR+NttdyhMun8XjjcZfQAafzgQoeGLh/RJ7LRvOfqyVfcHG/Xyzm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097304; c=relaxed/simple;
	bh=S1+moWK8WUqQqBwq12CGGS95zxJn4CEiSQR2ZbgzAjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=neusFZ1bmi2gN3uqN0yKimAkUKJCJmifU7EM4BPGKekmoHPRiDjmErw7PrHK0L+CWJiEy+visRTSf5HtwCDI72stztaXijoIIpLiyKQvqPmSY9p97dONf6JfaHssyN8Vf2TSsBdAYHMlYVx2uvWk3bNcsaPLliJ9ZkKyTDtbKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I3OhF8wv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I3OhF8wv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C71EE1595;
	Tue, 22 Sep 2026 10:14:58 -0700 (PDT)
Received: from [127.0.1.1] (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 056A83F86C;
	Tue, 22 Sep 2026 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790097302; bh=S1+moWK8WUqQqBwq12CGGS95zxJn4CEiSQR2ZbgzAjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I3OhF8wvoUdplYbIAxprYhaliSqNizYMQQKPtaoeJ91myAacTy8wDEGp9P9Hk+JYc
	 Cxti/txw6TGw66MJUNH7dnKqLXhJcsVRV8TfIQ9DU6Lzstr1QT53ZIGBG3xPD9QBrO
	 98HXGpHEpdXb5XLelYBAp6ylu9J64MVVJelAF18I=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Date: Tue, 22 Sep 2026 18:12:37 +0100
Subject: [PATCH v3 9/9] xen: use hw_pte_t for PTE range callbacks
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-pte0-v3-9-5670b8cb9059@arm.com>
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

Generic PTE range and remapping helpers now pass pointers to PTE table
storage as hw_pte_t *. Update the Xen callbacks to match those interfaces.

Keep software PTE values as pte_t and continue to access them through the
existing PTE helpers. This is required when Xen is built for an
architecture that selects the distinct hw_pte_t wrapper.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
Changes since v1:
- Use software PTE value terminology.

Changes since RFC v1:
- Clarify why the callback conversion is required after architecture
  opt-in.
---
 drivers/xen/gntdev.c               | 2 +-
 drivers/xen/privcmd.c              | 2 +-
 drivers/xen/xenbus/xenbus_client.c | 2 +-
 drivers/xen/xlate_mmu.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 1dcc4675580ed..b013bcad99b5b 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -301,7 +301,7 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 
 /* ------------------------------------------------------------------ */
 
-static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
+static int find_grant_ptes(hw_pte_t *pte, unsigned long addr, void *data)
 {
 	struct gntdev_grant_map *map = data;
 	unsigned int pgnr = (addr - map->pages_vm_start) >> PAGE_SHIFT;
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 7cfc28f1bb86f..e724cc053e264 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1658,7 +1658,7 @@ static int privcmd_mmap(struct file *file, struct vm_area_struct *vma)
  * on a per pfn/pte basis. Mapping calls that fail with ENOENT
  * can be then retried until success.
  */
-static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
+static int is_mapped_fn(hw_pte_t *pte, unsigned long addr, void *data)
 {
 	return pte_none(ptep_get(pte)) ? 0 : -EBUSY;
 }
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 27682cb5e58ab..387f97a555594 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -749,7 +749,7 @@ int xenbus_unmap_ring_vfree(struct xenbus_device *dev, void *vaddr)
 EXPORT_SYMBOL_GPL(xenbus_unmap_ring_vfree);
 
 #ifdef CONFIG_XEN_PV
-static int map_ring_apply(pte_t *pte, unsigned long addr, void *data)
+static int map_ring_apply(hw_pte_t *pte, unsigned long addr, void *data)
 {
 	struct map_ring_valloc *info = data;
 
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 8efd7b55223fb..d7244f9f9a545 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -93,7 +93,7 @@ static void setup_hparams(unsigned long gfn, void *data)
 	info->fgfn++;
 }
 
-static int remap_pte_fn(pte_t *ptep, unsigned long addr, void *data)
+static int remap_pte_fn(hw_pte_t *ptep, unsigned long addr, void *data)
 {
 	struct remap_data *info = data;
 	struct page *page = info->pages[info->index++];
@@ -269,7 +269,7 @@ struct remap_pfn {
 	unsigned long i;
 };
 
-static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
+static int remap_pfn_fn(hw_pte_t *ptep, unsigned long addr, void *data)
 {
 	struct remap_pfn *r = data;
 	struct page *page = r->pages[r->i];

-- 
2.47.3

