Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140043B6E2
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579398; cv=none; b=XEFs8m4jUXy3w96OFlSWyy5Q7JU37IElcPhlIOr8ZKr0xrIvYHrSmIhq/9WLGRsbREg7tZh0U2W39lve6DOUUtbY2o5dw/ixR3C4abLa8VUa5afpXE1tS7+8VkVKDad7BaN9dx3kG+MZz2QDiiEeBSQ8GqLbPIZj2UuwHngyYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579398; c=relaxed/simple;
	bh=S8m7waj7GQq7vgANU2A02JA1/sDnhqqyj+WsYzKQ15U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfFbebhPLRWnIKfRriAmAAMvat+nCUMQVnH6ySboTLQwsHIVw8kZCTxEoYHKsVTBLFrcwtqBwzAbKWMJx7MYdhx7kPcl2ATsFokOpNeYgNYJkRVJSpJozzOeT9hEdkLGaE7kf2ZWTppKGD9TtJQVeVMoPwqTD2Y8VZDYz+B9PCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JYy+c8Ji; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JYy+c8Ji"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RH6Nfb3175554;
	Mon, 28 Sep 2026 07:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=U0Sqv66/lUO5fAJlL+QxeO6e18NIiL
	tdJqIDVEF6pVo=; b=JYy+c8JiVYKn8nouxfqxB62qRnE0w0KFaFzXksbh7vvAEL
	eXgYsBXTK2Q0/JC4VwMEh9Wwlyt0fkmlrYPk1hebyUUZnJr+feU7zZpKKCD/32/6
	GK32iuw74mDOqGX9iyfseMbRfLesf50WlGakV+9f53EZhKFMhbtEbO51ZWCt+ock
	/PE0Naan+UboeuNsatwP0qFylAPQ++Gg00G3nbQ/ri9MiOMUdZAZg7Or0NU9fxZX
	ewY6U6oBpIPo40E24MB0d6khSx9MkPg5zQ/6dsPbXRMVmqVFlHA8hhWnrPeRjvWF
	fheZ3R2ZDqUdhLBF01FckKKwv6/BTpjfJaIy8tMw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fdyn2k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 07:09:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2DNPM2055623;
	Mon, 28 Sep 2026 07:09:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpmaf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 07:09:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S79W8M49217996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 07:09:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 602C620043;
	Mon, 28 Sep 2026 07:09:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF6620040;
	Mon, 28 Sep 2026 07:09:30 +0000 (GMT)
Received: from tuxmaker (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 07:09:30 +0000 (GMT)
Date: Mon, 28 Sep 2026 09:09:29 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Pedro Falcato <pfalcato@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Chris Li <chrisl@kernel.org>,
        Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, SJ Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, damon@lists.linux.dev,
        kasan-dev@googlegroups.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/9] mm: distinguish HW PTE pointers from SW PTE value
 pointers
Message-ID: <20260928070929.80522Ae0-agordeev@linux.ibm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba12b0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=B2JZ75edH0TnST5CdBoA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyOCBTYWx0ZWRfX36xnl4F0X1lx
 fqVE8lBCzTdyT+J+ezyz2OlTCEkg9vyu9qTQRaxPpF6hKz2talO2Fe86TA25Yp12H8ZPv7JvxWM
 qv6KcELXddf1u30q8Q260QGIdLS20Wg=
X-Proofpoint-ORIG-GUID: eaaIQGcS1nHN1_JGmMiyppMCwLEK0T95
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyOCBTYWx0ZWRfX1MBO4JWQdoeD
 8e/68bQLQFipsPa8y4AzHDaALB9+xGvirrZGm50ERvkR7A4Zmo+9VoMtAbAofJ7oQOJiuTUdAd9
 pYrp0fl47P7f87KgOiwiuVK6WSw4/Q08fnfRkHE/X1Ai9A6dlbWlIo7+LVVTPJLsgynXNNkB0kF
 WnQFoGn5DSIyYo7xILZ6hH/F/C60+7m9PQlSHbBx3jboCRxWsXR22WO8HeZ8+dE8xnt0UQemj1c
 huDAEphBKpAazTr5qTLXkI/vWEj/lRuVslQwgv4QIXlC9LXTKVF5KNjtqj2g4nT1s0xXtn1VF6V
 ijawGq9T+QC3qMonTajwMYd4TChTOrZQYATczf6snahgRRwYDnzN7mjsrZMDXNCuTs6Tj36BMR0
 9fwweUvy9ESMXLTyt8Ig54jGwVq4e2vAuybWD7rHHUJqWlfa3crf8DG9VcvSSJhYeN2vcM1zaEu
 i7ia/6REAMnf2ZYz2JQ==
X-Proofpoint-GUID: ffa-cTAiHn0bqMqx9VhJ2VUgRwO1RQTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280028

On Tue, Sep 22, 2026 at 06:12:28PM +0100, Muhammad Usama Anjum wrote:
> Hi,
> 
> pte_t currently describes both a software PTE value and an element stored
> in a PTE table. Consequently, pte_t * can point either to a software PTE
> value, often a stack copy, or to a PTE-table slot. The compiler cannot
> distinguish these cases. A value pointer can therefore be passed to an
> interface that expects table storage, while table storage can be read by
> direct dereference instead of the architecture accessor.
> 
> This series begins a staged conversion at the PTE level. It introduces
> hw_pte_t as the element type for PTE-table storage and converts generic
> MM to use hw_pte_t *. Software PTE values remain pte_t. Interfaces that
> intentionally return a value through pte_t *, such as install_pte,
> remain value interfaces; the relevant parameters are named ptentp to
> make that distinction explicit.
> 
> The generic definition aliases hw_pte_t to pte_t unless an architecture
> selects ARCH_HAS_HW_PTE_T, which enables a distinct generic wrapper named
> __hw_pte_t. Some architectures define pgtable_t in headers parsed before
> the generic hw_pte_t typedef is visible. The structure tag allows those
> headers to define pgtable_t as struct __hw_pte_t * without creating an
> include-order dependency. This is required when converting s390, m68k,
> powerpc and sparc.
> 
> No architecture selects ARCH_HAS_HW_PTE_T in this series, so the
> representation and behavior of every architecture are preserved. ptep_get()
> keeps its existing READ_ONCE() semantics and converts the stored element
> through __pte_from_hw(). An architecture can later select the option and
> convert its PTE interfaces to make the distinction compiler-enforced.
> Architecture PTE implementations and most architecture code are
> deliberately left for those later opt-in conversions.
> 
> Here, hw_pte_t identifies PTE-table storage rather than table lifetime:
> complete PTE tables use hw_pte_t whether or not they are currently
> linked into a page-table hierarchy, while software PTE values use
> pte_t. The distinction between complete but unlinked tables and
> hardware-reachable tables was raised during discussion and remains an
> important point for review.
> 
> PMD, PUD, P4D and PGD storage are deliberately out of scope. They can be
> converted in later series after the PTE boundary is agreed, avoiding the
> PMD-specific cases that made an all-level conversion difficult to
> review.
> 
> Most mechanical pointer conversions were generated with the Coccinelle
> script included below, then audited and fixed by hand.
> 
> This series does not add a second ptep_get_once() accessor and does not
> remove or replace STRICT_MM_TYPECHECKS.
> 
> The design discussion is available at [1]; while the original idea came
> from [2].
> 
> I've the patches here [3] for arm64 conversion which I used to find
> usages in generic code which I missed during development.
> 
> [1] https://lore.kernel.org/all/6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com/
> [2] https://lore.kernel.org/all/a063f6c5-2785-4a9f-8079-25edb3e54cef@arm.com
> [3] https://lore.kernel.org/all/20260914-pte0_arm-v1-0-bb53b663e396@arm.com 
> 
> Testing:
> Testing was performed with and without the series on both x86_64 and
> arm64. KUnit and the MM kselftests produced matching before-and-after
> results problems or regressions. Fastpath performance testing was also
> completed on arm64. No regression was found.
> 
> Thanks,
> Usama
...
> Muhammad Usama Anjum (9):
>       mm: introduce hw_pte_t for PTE table storage
>       mm: rename pointers to software PTE values as ptentp
>       mm: use hw_pte_t for generic PTE table storage
>       mm: convert PTE table entries in ptep_get()
>       mm: convert PTE table entry to pte
>       mm: add hw_pte_val for HW PTE storage
>       mm/kasan: use hw_pte_t for the early shadow PTE table
>       drm/i915: use hw_pte_t for PTE range callbacks
>       xen: use hw_pte_t for PTE range callbacks
> 
>  MAINTAINERS                                        |  1 +
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  4 +--
>  drivers/gpu/drm/i915/i915_mm.c                     |  4 +--
>  drivers/xen/gntdev.c                               |  2 +-
>  drivers/xen/privcmd.c                              |  2 +-
>  drivers/xen/xenbus/xenbus_client.c                 |  2 +-
>  drivers/xen/xlate_mmu.c                            |  4 +--
>  fs/hugetlbfs/inode.c                               |  3 +-
>  fs/proc/task_mmu.c                                 | 33 ++++++++++----------
>  include/asm-generic/hugetlb.h                      | 15 ++++-----
>  include/asm-generic/pgalloc.h                      |  6 ++--
>  include/asm-generic/tlb.h                          |  5 +--
>  include/linux/hugetlb.h                            | 53 +++++++++++++++++--------------
>  include/linux/kasan.h                              |  2 +-
>  include/linux/mm.h                                 | 26 ++++++++--------
>  include/linux/page_table_check.h                   | 10 ++++--
>  include/linux/pagewalk.h                           | 10 +++---
>  include/linux/pgtable.h                            | 81 +++++++++++++++++++++++++-----------------------
>  include/linux/pgtable_types.h                      | 23 ++++++++++++++
>  include/linux/rmap.h                               |  2 +-
>  include/linux/swapops.h                            |  6 ++--
>  include/linux/vmalloc.h                            |  4 +--
>  include/trace/events/xen.h                         | 10 +++---
>  kernel/bpf/arena.c                                 |  9 +++---
>  kernel/events/core.c                               |  3 +-
>  mm/Kconfig                                         |  3 ++
>  mm/damon/ops-common.c                              |  2 +-
>  mm/damon/ops-common.h                              |  2 +-
>  mm/damon/vaddr.c                                   | 20 ++++++------
>  mm/debug_vm_pgtable.c                              |  2 +-
>  mm/filemap.c                                       |  4 +--
>  mm/gup.c                                           |  9 +++---
>  mm/highmem.c                                       | 15 ++++-----
>  mm/hmm.c                                           |  6 ++--
>  mm/huge_memory.c                                   |  4 +--
>  mm/hugetlb.c                                       | 60 ++++++++++++++++++-----------------
>  mm/hugetlb_vmemmap.c                               | 13 ++++----
>  mm/internal.h                                      | 16 +++++-----
>  mm/kasan/init.c                                    | 14 ++++-----
>  mm/kasan/shadow.c                                  |  6 ++--
>  mm/khugepaged.c                                    | 50 ++++++++++++++++++------------
>  mm/ksm.c                                           | 11 ++++---
>  mm/madvise.c                                       | 18 ++++++-----
>  mm/mapping_dirty_helpers.c                         |  4 +--
>  mm/memory-failure.c                                |  6 ++--
>  mm/memory.c                                        | 78 +++++++++++++++++++++++-----------------------
>  mm/mempolicy.c                                     |  4 +--
>  mm/migrate.c                                       |  4 +--
>  mm/migrate_device.c                                |  4 +--
>  mm/mincore.c                                       |  4 +--
>  mm/mlock.c                                         |  4 +--
>  mm/mprotect.c                                      | 19 ++++++------
>  mm/mremap.c                                        |  4 +--
>  mm/page_table_check.c                              |  4 +--
>  mm/pagewalk.c                                      |  9 +++---
>  mm/percpu.c                                        |  2 +-
>  mm/pgtable-generic.c                               | 20 ++++++------
>  mm/ptdump.c                                        |  4 +--
>  mm/rmap.c                                          |  6 ++--
>  mm/sparse-vmemmap.c                                | 22 ++++++-------
>  mm/swap_state.c                                    |  3 +-
>  mm/swapfile.c                                      |  5 +--
>  mm/userfaultfd.c                                   | 32 ++++++++++---------
>  mm/util.c                                          |  2 +-
>  mm/vmalloc.c                                       | 11 ++++---
>  mm/vmscan.c                                        |  6 ++--
>  66 files changed, 457 insertions(+), 375 deletions(-)
> ---
> base-commit: ead700ca770c82167af32622cf8b68c9f87c3c7c
> change-id: 20260914-pte0-6c88f5592d79

I backported this series to the Linus master and tested on s390
with the lazy mmu series applied on top. In case it still counts:

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

> Best regards,
> --  
> Usama

Thanks!
