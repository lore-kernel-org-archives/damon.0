Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D00433BAA
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443316; cv=none; b=Z0xEZbi2q2qvobjsNdnMz/1U3ihFcVBqul44TXHrGut/L24SmyvTy01DzW5JnVuBBddd5PsWmxlsQs0wMWoz5NocD/dTK1XFR6CK6Dm1L5gvyVPc1ubk8ZCA5uw5TBVJEOEI00n3GUyHU3Ff53hub8d4tYYc1sT+Cq0Z9zFvzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443316; c=relaxed/simple;
	bh=+szcqBCq9eZ2ua7vWX4x/+s1q8ODJlqcpxLyiJuSiwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT3fvz8tLdeuGed4fazpYGV30fDPX4zebwIgjzsJ5/pVMgkRtg9r9DbgN4ah8iicW+BtULPFvit0Y+SqanBl3vNpcY/+WivKTmlxunbcjJNyXoMUoue7PVo9lmnym8GGk0LC6bJ2WWOzcd4r6dhA4H7/+oQr7KxdSG+Akb9xF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V+Vm46x3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V+Vm46x3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBBEA1682;
	Tue, 11 Aug 2026 03:15:05 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0350C3F86F;
	Tue, 11 Aug 2026 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786443309; bh=+szcqBCq9eZ2ua7vWX4x/+s1q8ODJlqcpxLyiJuSiwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+Vm46x3ghCefqeO2I1n6DA88n8dnPA9fKF0KOYZamwYwLaVm1b44z72dYIEIsYC0
	 p/UxibT9bkIS6vm2g/03/53REk/x6Bjd7ZTy6XlUazb0cSaz7+p0GyYbiNAyjJgZGx
	 FyXK8Yk5Rfauuo195Y0NDG5YghHuk7t+gElvU4PU=
Date: Tue, 11 Aug 2026 15:45:06 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, ziy@nvidia.com, 
	pfalcato@suse.de, agordeev@linux.ibm.com, ryan.roberts@arm.com, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	damon@lists.linux.dev
Subject: Re: [PATCH 2/9] mm: make hw_pte_t visible to generic PTE interfaces
Message-ID: <7xbai2nyu6nuyr6otqv556dnphpgwaqsmvwkqwoqwbh5nvj3ns@ddy5ezgvb7w3>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-3-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806083926.1807279-3-usama.anjum@arm.com>

On Thu, Aug 06, 2026 at 09:38:40AM +0100, Muhammad Usama Anjum wrote:
> Later conversions use hw_pte_t in page-table checking, generic page-table
> helpers, and vmalloc interfaces. Include linux/pgtable_types.h from the
> headers that declare those interfaces before changing their types.
> 
> For vmalloc.h, replace the direct asm/page.h include with
> linux/pgtable_types.h. The latter includes asm/page.h, so pgprot_t remains
> available. It also provides either the default alias or the opted-in
> hw_pte_t wrapper.

Stand-alone header file updates are not ideal. Why cannot these changes be
folded in, where hw_pte_t gets used first time ever in the above mentioned
places.

> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since RFC v1:
> - Clarify that the header provides both generic hw_pte_t definitions.
> ---
>  include/linux/page_table_check.h | 2 ++
>  include/linux/pgtable.h          | 1 +
>  include/linux/vmalloc.h          | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 12268a32e8be1..12ee6d16ad339 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -7,6 +7,8 @@
>  #ifndef __LINUX_PAGE_TABLE_CHECK_H
>  #define __LINUX_PAGE_TABLE_CHECK_H
>  
> +#include <linux/pgtable_types.h>
> +
>  #ifdef CONFIG_PAGE_TABLE_CHECK
>  #include <linux/jump_label.h>
>  
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8c093c119e5a8..cf595608cc4c4 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/pfn.h>
>  #include <asm/pgtable.h>
> +#include <linux/pgtable_types.h>
>  
>  #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
>  #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index aed121d729b01..b068e6ade4207 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -8,7 +8,7 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/llist.h>
> -#include <asm/page.h>		/* pgprot_t */
> +#include <linux/pgtable_types.h>	/* pgprot_t, hw_pte_t */
>  #include <linux/rbtree.h>
>  #include <linux/overflow.h>
>  
> -- 
> 2.47.3
> 
