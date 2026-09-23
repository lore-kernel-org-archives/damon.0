Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3630C60D
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164453; cv=none; b=FNw8r1fQA74/K74K3ZmvB7yF9UPlwjuKSKxmJfcyuX7yUNRatkSOBEhVU7inGrA0HATE+4RdggfvbENTl55f6CKh4Hj1J0eyVQ26FvE9ooGCJLzm1jim7CowonIw/f1dPjml0MZg5xjG+D1YlPpf9huIaV/YIGaoBdjzK7pac3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164453; c=relaxed/simple;
	bh=22/faKz6Gnw+zUvKjx8BiXp6H9FKIGfro4Ro+BBqUHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVbRkvpAUuc1h86CcYI+vngtKujVuxHj4rS9Sbx4zNvSChYuo682ZIMTBlS+E0JogtmZ8tW8lrKfrcYKMx8+1dCsF8JqDqfUiaWQkEWdpPdTv3rcKpcZQqjT1sLrw7c4/Fr6ccDYfFsjXBl5Sz1muXmZCVcFWn9AU1ETdMZARAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ip/9PsmL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ip/9PsmL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZaCq2742039;
	Wed, 23 Sep 2026 11:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DZPR253R3+bl6LyBiXW5gQAtjY6DOY
	80tr7PJYJoSn0=; b=Ip/9PsmLLpYTUEIiqqN7PEUCjt/tbos3gbllDcLV+dKinE
	DxM4vzFM1FgDLuHauy7zkOFHkE+8QgTu4v3UOwe3wRUssGJANSTjHJOqGP138G+T
	Nhqd4UMt93hU/7hAzMP4DnDStV7v3lAJgOZvyhZ0P+hcH1+UYg4pIU0KHQpm5t+5
	XYQiGLs519bydF3F3Ly2mUsQkpmeIheUS2Amsu7SuvxdJgo6dsqyP4V/N6M8uPwo
	Yuml8Vro5Oj2/R/nPk2G/xRZFMnqki/FTHYZUvTsblhV4A+Kj49Gi5gWyBTzSy/p
	hvCA8ghvjVyo99no8eYyGLGNv+3L5xoksFaAmS9Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1jk3y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 11:52:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ILmd2892101;
	Wed, 23 Sep 2026 11:52:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkgqma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 11:52:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NBqkcL49086914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 11:52:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C3D920043;
	Wed, 23 Sep 2026 11:52:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F30620040;
	Wed, 23 Sep 2026 11:52:45 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 11:52:45 +0000 (GMT)
Date: Wed, 23 Sep 2026 13:52:44 +0200
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
Subject: Re: [PATCH v2 1/8] mm: introduce hw_pte_t for PTE table storage
Message-ID: <4fb9f42e-73c3-46db-ac10-351a90901b7c-agordeev@linux.ibm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-2-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903103002.1091859-2-usama.anjum@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zkg8Yjm8buhyt1eRNhnorvj4h8bfMg31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NiBTYWx0ZWRfX6bMVOEi2qN4e
 SEAEWElqPuFcMqb6XxMSAKgTBU7nj/dCzT7pboAwFXABTdsicPgdnhSpodFJ6O+u2hg509qHfDk
 z9HbX8YO6UJxXAtAPBr1SXV/yRHUshBZqtP38jfDABopi2Q8TlICK2s09kBGBV4exDZexYbukEp
 Oxg7zWWj4bwJEOGzokpvAGkgwx6mOV9Hci2samlSyJVgEXMEqtoph/gVCurHxiAAqf0TauaVInd
 IvHSuwss6TAgfLNFvMkfvgEfm/lWIxq4QqGWZb1wZGJTR0i8Aqwb5xGBOLcMv/lOTIYdxzI8o3R
 oPxWzTJkmoTyuCze3ranpvgoRtO0j9Fwo13juJtO4WWD8YTP1C0PjcAbhZUntKNvoYTNnIcU/mO
 iX0G+Pezy0wbnkBvSeLA9ii/P51EkQzABCycAD2yGmiU5zm9dKM8qjIMLGZaPS8vA+24yUC1vPk
 rGMSqvFG6FK+7tXalcw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3bd91 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=7CQSdrXTAAAA:8
 a=WBsaCDucxrlOMaPtzzAA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NiBTYWx0ZWRfX/Y5nhDG4vyXY
 k03GeTaIqKwMRq4AUpoHFMiSiGlDWAE+orQ24P6M5Bz7btA5rwd/KAwZVyCP0QeAkoFRkdQm8Rw
 gOzyts+JEL8Z8Grz2VhIOfiIo2KdxD0=
X-Proofpoint-GUID: zkg8Yjm8buhyt1eRNhnorvj4h8bfMg31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230046

On Thu, Sep 03, 2026 at 11:29:53AM +0100, Muhammad Usama Anjum wrote:
> pte_t is used both for software PTE values and for entries stored in a PTE
> table, so pte_t * does not distinguish a pointer to a software PTE
> value from a pointer to table storage.
> 
> Introduce hw_pte_t as the generic name for a PTE table element. Define it
> as a macro alias of pte_t by default. When an architecture selects
> ARCH_HAS_HW_PTE_T, define it as a structure containing a pte_t instead.
> This preserves the representation while allowing converted architectures
> to enforce the distinction at compile time.
> 
> Name the generic wrapper structure __hw_pte_t so architectures can
> forward-declare it when pgtable_t must be defined before the generic
> hw_pte_t typedef is visible. This avoids header-order dependencies.
> 
> Keep the C type definitions behind an __ASSEMBLY__ check because
> architecture assembly sources can include this header indirectly. Include
> asm/page.h so consumers such as linux/vmalloc.h retain the page definitions
> they previously obtained from that header.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v1:
> - Name the generic wrapper structure __hw_pte_t so architectures can
>   forward-declare it, and explain why this is required.
> - Use software PTE value terminology.
> 
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
> index 2133aec4a2004..da60a8bdcddb5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17140,6 +17140,7 @@ F:	include/linux/mmu_notifier.h
>  F:	include/linux/pagewalk.h
>  F:	include/linux/pgalloc.h
>  F:	include/linux/pgtable.h
> +F:	include/linux/pgtable_types.h
>  F:	include/linux/ptdump.h
>  F:	include/linux/vmpressure.h
>  F:	include/linux/vmstat.h
> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> new file mode 100644
> index 0000000000000..07da05d375c2c
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
> +typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
> +#else
> +#define hw_pte_t pte_t
> +#endif

I would suggest to provide __hw_pte() in this series - it is needed
by architectures along with __pte_from_hw() right away (as opposed
to when lands in arm64).

> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* _LINUX_PGTABLE_TYPES_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1ddf59c0d71a..5f462ec6fa5e5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1312,6 +1312,9 @@ comment "GUP_TEST needs to have DEBUG_FS enabled"
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
