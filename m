Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7341F349
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441683; cv=none; b=leydLj780C59KotTIEZyLKgVHc+EYVfLV1sLCkLzxrbPX3SKm7jExjhBJhaolVZ9Cuqb/2IbOEzXvLRuASke/FDKjBSeKBeD3vrn+RmE+R7zvja1xpOKIvrPGEVwBGGJuZl52lO7uU2lsznC2YbcHghWUBo/pbOpR0GZfyFGFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441683; c=relaxed/simple;
	bh=9BoMtxA4Y0P7/HlT09wIdHqLAsjiBcPF0bOK0SA6y88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQCPG2O0gLKMC/1U+AYtVLBDVCC5ZZ9XS01QZjRAKRN6LZXni4Gm+bmKSnLOHvd9Jk0gH28DLiM3AofdORJrp/K4BHjZ5pTfQDLbu9X+d2DzvPyVEGHYGJiwcJNXedu34p54DXpqNq2mHAfxR3yvK6CMAcDGUpTJ2ruH3vQdmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d6ccwcWa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d6ccwcWa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53CA01682;
	Tue, 11 Aug 2026 02:47:56 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC363F632;
	Tue, 11 Aug 2026 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786441680; bh=9BoMtxA4Y0P7/HlT09wIdHqLAsjiBcPF0bOK0SA6y88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6ccwcWanhV2NaMQGyN2LuxorwwpnGJX87UVp3OA/ioC8kalbAN29GEdYDjGMly4L
	 +yi+Q/zEcN/N5K6/AZJJ9VjzIZc7OuAomjl/vPpcEdxNEFoRGn9LR525fZF+bpEreD
	 Ak2C6/i9Np4uONZAT7JjQS//RpxwX0LWi0gAmmt8=
Date: Tue, 11 Aug 2026 15:17:57 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
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
	pfalcato@suse.de, ryan.roberts@arm.com, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 1/9] mm: introduce hw_pte_t for PTE table storage
Message-ID: <u457qwrnkaquvqfn4op2a4wcdflm6d4gzut5ii4ialbeqjiyfj@qpn5fu5kwn4z>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-2-usama.anjum@arm.com>
 <3db8233c-3785-444e-b2eb-3e5fc5cb2f17-agordeev@linux.ibm.com>
 <eef14e97-20cd-4b08-ae22-7636af049b09@arm.com>
 <4a42c498-58ca-46f4-819f-da14cfba154f-agordeev@linux.ibm.com>
 <52b5066c-64f6-40bb-9bce-365a18f24265@arm.com>
 <b40d4359-3156-4d02-9662-73bfeace607c@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40d4359-3156-4d02-9662-73bfeace607c@kernel.org>

On Mon, Aug 10, 2026 at 01:20:00PM +0200, David Hildenbrand (Arm) wrote:
> On 8/10/26 12:09, Muhammad Usama Anjum wrote:
> > On 09/08/2026 6:45 pm, Alexander Gordeev wrote:
> >> On Fri, Aug 07, 2026 at 04:24:00PM +0100, Muhammad Usama Anjum wrote:
> >>> Thank you for testing it out on s390.
> >>>
> >>> As __hw_pte_t isn't being used yet in this series, would s390 enablement
> >>> patches add __hw_pte_t to this definition?
> >>
> >> I hope there is a better solution. As I noted m68k, powerpc and sparc
> >> may also be affected, so I would suggest to look into those as well.
> >> I would prefer s390 to use the generic one rather than circumvent a
> >> compile error in a custom way.
> > I've just checked all of these architectures by doing dirty conversion and
> > reached to same conclusion that __hw_pte_t must be defined like:
> >  
> > typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
> > 
> > I'lll add __hw_pte_t to this series. (Initially on last email I'd thought
> > that the first user would add __hw_pte_t. But it seems sensible to add it
> > now)
> 
> Yes, do it as part of the introduction. Also a good idea to mention in the patch
> description *why* that is required.

Agreed.

> 
> -- 
> Cheers,
> 
> David
