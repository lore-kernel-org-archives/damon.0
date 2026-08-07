Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD8175A6B
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086592; cv=none; b=UYs0cy9LDnrh5EhXcvLBpG1NvnhFt6qpTSudU+PaO7Nx7UqTwUuKrPwBfI5NLfG8QZNjJTXdd9ZfZ6ZvHYZljhzPSA/5bJrnFpz/KF4YqqHfKHAAGqYLBlglq52gJRwQ+ByPhZArPHbZnpGRPdQBaT3bX5ZFlwduR9Yn5K4fpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086592; c=relaxed/simple;
	bh=okUo/lBwawQ2ShVhicuL+c1RSgIwQ+JfXxkA9MP2fZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqk2RNwCDd4wyXcLZMLUKSsrDBn1wx6VPyRX26wc8r+IH/skKs5g+r3m9bONbVrVCx+uDIpjIKAzPHtTqVKPnTpgLV4mUnsrp2Dj+4Epp4CBL+0HEi3jDt3LLS2jWjd2Sz2HPP4MLvsZy/sLXUe2OOKG5a+7A+NP3CHOhrDbb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qh6BCzQc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qh6BCzQc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770JZQv4064146;
	Fri, 7 Aug 2026 07:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jpeOcxycXBTAlw8xEd8qyVhgpwcjWF
	NB4soWtck85Pw=; b=Qh6BCzQcqD/AGOqi1hTQHgQVz6HuWuBJB87Gbu8R2QRIrL
	ftEfzBmybSkNntrd41XE524cbuEjupU7byCqaB7YxW9kBgydkUCxBhrhTSiwT6H+
	U4OKIllzATyLLGfNArjEOqj0akgLZ0asqOkSM0XKJyYYoIst8JvDseeB2sH706u4
	hhs9ueI6JSC+Ld/f6qPFOuLXDpab+v18Jf4LeEQIr4j5+MFCFi1kjnwg8/MvRqx/
	KhT+u3vzeF7qrRG7dH6ram2Pu9RQGcAByOzaawNWn2aii58OGSRM1hM7xmzHRjNe
	Si5vdvDt7lOVvC8K31hkxayAWljo7JjlQf3ZTeQg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02anmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 07:09:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6776uIAD024920;
	Fri, 7 Aug 2026 07:09:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhpmkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 07:09:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67779F7T51315084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 07:09:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 668A020040;
	Fri,  7 Aug 2026 07:09:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA50320043;
	Fri,  7 Aug 2026 07:09:12 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.55.180])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 07:09:12 +0000 (GMT)
Date: Fri, 7 Aug 2026 09:09:11 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        David Hildenbrand <david@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
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
        Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>, Mike Rapoport <rppt@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, ziy@nvidia.com, pfalcato@suse.de,
        ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 1/9] mm: introduce hw_pte_t for PTE table storage
Message-ID: <3db8233c-3785-444e-b2eb-3e5fc5cb2f17-agordeev@linux.ibm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-2-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806083926.1807279-2-usama.anjum@arm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75849e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7CQSdrXTAAAA:8
 a=knT6YJskkHJV9nTHl7IA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA0OSBTYWx0ZWRfX0nP+lx57+9VF
 1gmEHMdPT9FDdcpiQyi8SmdcwszvdSJS7mABzCaLeNrHd5Sn8+sTGSPk7wgKar3hoAN1E4B/pVx
 bnXvboS9h3/hfmNoqiGrVCRZoMjtdCQHGGcTi/BUQBFwhU3T8reyBMtbDszvLlwmh+wtmaSZLqp
 yvHKwixzlq6G3K0WuaMTKb0rV/vx4p/+UD+c1HQ1XyaQGUDlAtP+qGdAxuohRKj+obB6JSz4pJf
 zR2/7yIz+BcCrmWWxRtyEAkQu5yJbla8dkOuZTNT+Te2QfvIou3iP7qEQNN4GRIU2Q5uHMR6b+I
 Dj47k0jZ1vEd4+qsmknTL/rQ5DO0GSFvsjQsVYtZ2xV19zVeKyvXq+fRINOYMQUEmIHFL/MkEMn
 a61cmrTNbkwX+us4u3c+MP3DMEixACEHjWeKrnFUAYotTcrys6EiCMj8gXkAJjhYM+ZfvANLuAs
 LDq51urlTaBYjwemYPw==
X-Proofpoint-ORIG-GUID: 24rCQEgxgE9QBP75I4HmK7CgK28n9dSJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA0OSBTYWx0ZWRfX1i5aYO825ZYa
 TwQN6H3jwP2QZ+OLP/IGdT3C7Slc5GOjV5747KQtgAdatwi/16p60JYaM2efb4DysHgyipihWtH
 8fPlfABrpBSxaw7p4kLOdK2+bYjkzog=
X-Proofpoint-GUID: 24rCQEgxgE9QBP75I4HmK7CgK28n9dSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070049

On Thu, Aug 06, 2026 at 09:38:39AM +0100, Muhammad Usama Anjum wrote:
> pte_t is used both for logical PTE values and for entries stored in a PTE
> table, so pte_t * does not distinguish a pointer to a copied value from a
> pointer to table storage.
> 
> Introduce hw_pte_t as the generic name for a PTE table element. Define it
> as a macro alias of pte_t by default. When an architecture selects
> ARCH_HAS_HW_PTE_T, define it as a structure containing a pte_t instead.
> This preserves the representation while allowing converted architectures
> to enforce the distinction at compile time.
> 
> Keep the C type definitions behind an __ASSEMBLY__ check because
> architecture assembly sources can include this header indirectly. Include
> asm/page.h so consumers such as linux/vmalloc.h retain the page definitions
> they previously obtained from that header.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since RFC v1:
> - Add the ARCH_HAS_HW_PTE_T opt-in and generic wrapper definition.
> - Exclude the C type definitions from assembly sources.
> - Update the description for the new opt-in model.
> ---
>  MAINTAINERS                   |  1 +
>  include/linux/pgtable_types.h | 17 +++++++++++++++++
>  mm/Kconfig                    |  3 +++
>  3 files changed, 21 insertions(+)
>  create mode 100644 include/linux/pgtable_types.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9c8567308a75..7169bea968cf5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16982,6 +16982,7 @@ F:	include/linux/mmu_notifier.h
>  F:	include/linux/pagewalk.h
>  F:	include/linux/pgalloc.h
>  F:	include/linux/pgtable.h
> +F:	include/linux/pgtable_types.h
>  F:	include/linux/ptdump.h
>  F:	include/linux/vmpressure.h
>  F:	include/linux/vmstat.h
> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> new file mode 100644
> index 0000000000000..70c3edd00a01b
> --- /dev/null
> +++ b/include/linux/pgtable_types.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGTABLE_TYPES_H
> +#define _LINUX_PGTABLE_TYPES_H
> +
> +#include <asm/page.h>
> +
> +#ifndef __ASSEMBLY__
> +
> +#ifdef CONFIG_ARCH_HAS_HW_PTE_T
> +typedef struct { pte_t __pte; } hw_pte_t;

On s390 it fails to compile once we do typedef hw_pte_t *pgtable_t
in asm/page.h. m68k, powerpc and sparc may also have such problem.

The below declaration helps to resolve it using forward declaration
and without meddling with headers, though I do not like it much:

typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;

> +#else
> +#define hw_pte_t pte_t
> +#endif
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* _LINUX_PGTABLE_TYPES_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 331daf7fcfab5..31ba9ebf4aafd 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1316,6 +1316,9 @@ comment "GUP_TEST needs to have DEBUG_FS enabled"
>  config GUP_GET_PXX_LOW_HIGH
>  	bool
>  
> +config ARCH_HAS_HW_PTE_T
> +	bool
> +
>  config DMAPOOL_TEST
>  	tristate "Enable a module to run time tests on dma_pool"
>  	depends on HAS_DMA
> -- 
> 2.47.3
> 
