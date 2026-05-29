Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FE1F78E6;
	Fri, 29 May 2026 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069250; cv=none; b=SSAfNjErm7m+oxMKAAqkAhya57fArc9RnoqX0nUWkwg+N8qwqVMMsuczQyHzlFqyb2hcGoGlwPbRqf5jy2JEviubes2bMBPaRViMOIfuEXxf1QMZ9izpAX545CnzV65NGf9J21Ao3y2XpLXpZs/2fiUcRtIj2uzILv5mbAEtYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069250; c=relaxed/simple;
	bh=P5OXlc2w1jT8rpSydWhuQM+Wx/RRTDE8maGSqN+tbH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpBdmj0oYqSsREr4v8VeOO5LTrFsgGeHvIW4OGK8BPuW5jhOh57rOAXbFXqpaKulBc21HkH0jL6B5NVsn6Cpo0/VVPve1pRUjLxh/as0tlZv8OEUDcNb1538kXIF82TnJP2vhT6CW9g3hxuKUx3jYdkPGqr+Ee0QJFP5wf9Y8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUNwOBtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUNwOBtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC151F00893;
	Fri, 29 May 2026 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069248;
	bh=hAYoCu/RXfyftNoJ6VS8vSHQtBSJuT1PmOIzykcmtbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QUNwOBtdHlaVN6zntNCHNfsn9Ya0qsXlEmh52j+bxLKsBC7DIzIhnvBoM/3IgCcca
	 SCvz/Xu9OuvcHaAxbRg085ySDA5hW8nz97lugGsuVBxcKgxO0GYiYRmxvcuKmWaXGe
	 /yCDUypGwkcF+2Nio/qTMTlS5VxsGSXdcEvsi7O20rDRUhEG6P6txj3YadQLjzqxAa
	 SWQqIOHjkCz1TNbdHPsMERpiVQQKHfxRiuXjUNscx6ltv+N2VO6QzSyvNZP+YDsMHV
	 XYgxVmHVu1BvYKm/VTdcnV+jNFcB1EB0mOjWOr7ioAP8W/elBicMpuRwJrXVyYr5Uj
	 Y3d3AMnr7Thcw==
Date: Fri, 29 May 2026 16:40:33 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Barry Song <baohua@kernel.org>, wangtao <tao.wangtao@honor.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"david@kernel.org" <david@kernel.org>, "willy@infradead.org" <willy@infradead.org>, 
	"sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org" <liam@infradead.org>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"jack@suse.cz" <jack@suse.cz>, "riel@surriel.com" <riel@surriel.com>, 
	"harry@kernel.org" <harry@kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, "joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, 
	"rakie.kim@sk.com" <rakie.kim@sk.com>, "byungchul@sk.com" <byungchul@sk.com>, 
	"gourry@gourry.net" <gourry@gourry.net>, "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, 
	"apopple@nvidia.com" <apopple@nvidia.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahmzXSN_sQYmq2Jp@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <87qzmu2r0t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzmu2r0t.fsf@trenco.lwn.net>

On Fri, May 29, 2026 at 09:07:30AM -0600, Jonathan Corbet wrote:
> Barry Song <baohua@kernel.org> writes:
>
> > After coming back from Zagreb, I kept trying to find one or
> > two full days to read Lorenzo's code and slides carefully and
> > write a blog about them. Unfortunately, I have been completely
> > busy with other work. Sigh... we always seem to have too many
> > non-upstream tasks.
> >
> > If possible, I'd really appreciate it if you could take a
> > deep dive into it and write a detailed blog post. I'd be
> > very eager to read it and better understand the overall design.
> > Otherwise, I'll try to find some time next week or later to
> > go through it myself.
>
> It's still somewhat superficial, but in case it's helpful:
>
>   https://lwn.net/Articles/1072378/
>

I found it to be great as usual :)

> jon

Cheers, Lorenzo
