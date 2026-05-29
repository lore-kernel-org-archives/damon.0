Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323F3557F3;
	Fri, 29 May 2026 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037818; cv=none; b=sJ1smRbDWUEc/hqaDGC0OqjKSjAX9Z/BL2iQCTwvpToDgpiX67JHgewv0ULIlZ7nBXpIyanKHwCUPtgqudP0wXUvp0Nbc9inj5TQX9DtC/hPtj2/t/qlTYP993uOrbQO4B0i368KGCKlUZ1L+MFVt0glvrrGDaUqTKapKa6JBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037818; c=relaxed/simple;
	bh=bYhbJ03zngjCzkJ2hPrDNjIkIlO3ghoI+gEguCBz3YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBJetel0mVFJpvVnTyRrjDgfunbqquuEb+VEM6V0WTz7+QvO/CVABhvez4qohGnsFgnQ1um5L+vbOIKz7u01KFjvnD4qSgyfMejqTN2i+HCWaUTmDjdLvdXCXxdlvtI2WKdHj1jqHTszEtgOOUSBs0LnITJfTu0yhNAu7WmHsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3wokvyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3wokvyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E761F00898;
	Fri, 29 May 2026 06:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780037817;
	bh=bYhbJ03zngjCzkJ2hPrDNjIkIlO3ghoI+gEguCBz3YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q3wokvyV5MKZlsvJg4UNtT918QlXzkB1U0kHy4MQZf3J8TNDLjCs6GWuK6gBtLL2S
	 XwxTTnb8J8zHH5LRtHazfGYB3Umrz1PHhEDR9QNPU0EOEIaA3XN4JVt7wCnygoA1zV
	 4q+FTfFAUbdKZZbslBEY/VDMaQPAemhXbHlqgR6SKTL5Rr5iKO6uEFjESpmfoIwVLb
	 AEq9ZYzwDZSXe5A0SDEA94a3R1N1gVz2W5Cz4tTFDGKSsdQLDLv+lIcvVy+XKCnFA7
	 OOK4ThbmBiMKIXV7eLFB/GpX8xtJZgGZD4WmS5hEg3F41Iq5zx4rb+uQBIuKEyOAQl
	 hXnsGCXkomZXA==
Date: Fri, 29 May 2026 07:56:39 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: wangzicheng <wangzicheng@honor.com>
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
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahk2JJkUdpHQIqFa@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <3f7112ea7bc0409885f0fb0b4d09561e@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7112ea7bc0409885f0fb0b4d09561e@honor.com>

On Fri, May 29, 2026 at 02:20:38AM +0000, wangzicheng wrote:
> Hi Barry,
>
> Thank you for your guidance, it is very much appreciated.
>
> I work with Tao at Honor. The motivation behind this work is genuine and practical.
> The memory cost has increased significantly, and we have spent real effort investigating
> and prototyping solutions to reduce it.

Thanks, appreciate the input from your side Zicheng.

The series is unmergeable as-is, regardless of provenance.

What's unfortunate is that early discussion could have saved effort (and/or
tokens :). This is often the case with firms that develop something in-house in
isolation then present it to the community suddenly.

And as I said to Barry (+ Tao previously), the circumstances surrounding
this series are additionally very suspicious, and while we are fine with
LLM assistance where the authors fully understand it, it feels that this is
not the case here.

>
> We're happy to join "constructive" discussions and learn from the community.

So with the negativity above said, I'd really like us to move to a more
positive and constructive situation :)

One thing that is clear is that - we all want the same thing.

Reduced memory usage, reduced lock contention in the anon rmap.

So one thing that could be very useful is for you guys to help assist me
with testing of my anon rmap approach as it develops, and also provide
input, critique, and review.

I'd also love to be made aware of any testing you guys have done or input
on that, also any workloads where you have observed particularly
problematic memory usage or lock contention.

Please note that my work is currently under heavy development so the
proof-of-concept code provided is incomplete and not yet functional (it's
just there to give a sense of the shape).

I will likely provide a pre-RFC series to interested parties prior to
sending an RFC on-list.

I'd be more than happy to include you guys in that.

And as I said previously, I'm more than happy to engage in discussion
on-list or privately regarding this work :)

>
> Thanks,
> Zicheng

Cheers, Lorenzo
