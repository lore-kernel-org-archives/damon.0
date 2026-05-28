Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F0340A46;
	Thu, 28 May 2026 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952480; cv=none; b=JfdUs0RLhiVOy4keqDXzG9Q8OL586smvuG8MTZeNzqgKPXYlau8rvjaIcQNDBmCmKYxGfTzUSK2HoYGnqCFSgnmcounYehTBKnlUKeejVF4m6vBdRXxEFFEr+Dlzu2xbOHawxZnyCvbCx9rqeOap5+nwiC5yD6xGHO5eLglxVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952480; c=relaxed/simple;
	bh=AMHRCZ/Uj48KQbmFraAMkWjb/Yi2LkWhbHoiVD5mViA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi72XbylDId6rCKQ5y+WGuQvbHypI/rH02IAI+oGl5XavKpAE/LPTKQ+/4xdfSvWi12Ca/6tXv5GyisH3b2LkXicTwbFALA8AoIMG6PhKUmbhthHL59MB41WnCZXP8YnWSrbH/xIkM5iDkxZEW+Vm8Ug2TAN/X7d7GToB4UqHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCYo/kAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCYo/kAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A1F1F000E9;
	Thu, 28 May 2026 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952479;
	bh=AMHRCZ/Uj48KQbmFraAMkWjb/Yi2LkWhbHoiVD5mViA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VCYo/kAnidj7WuNhU0XFKQXOcDvDd/yD85UGCv9mwdHK+JS0RAVNF7KU9fdNcSszP
	 q3DhFo9mP3UPpT4llrLK3PAdb015+g1MqHUNYBFjramxw/+NA55SpoMw2afX2FPbqA
	 dPDrYC0TszCnjWWIvp73l9RfsDBQoRQNXw9IyIBwATsuwL5A0YGnxHp3mhXGJxoKb8
	 njAZvOUs7KjOyK8q9Ej2Ts56p6Z7IYxFXEQhdRxWxhC+cVJOHy+OXR2SI/0ljM79op
	 f59S3iQd7f3v8Vxj3jOhXRLSqucGWsIY3wo0U5HwRNTi9EGGggJzE41xcSGKKM46Rq
	 o3Z/5yWTfsPZA==
Date: Thu, 28 May 2026 08:14:23 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: wangtao <tao.wangtao@honor.com>
Cc: Pedro Falcato <pfalcato@suse.de>, 
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
	"baohua@kernel.org" <baohua@kernel.org>, "lance.yang@linux.dev" <lance.yang@linux.dev>, 
	"xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"jparsana@google.com" <jparsana@google.com>, "dvander@google.com" <dvander@google.com>, 
	zhangji <zhangji1@honor.com>, wangzicheng <wangzicheng@honor.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahfqKUDyIt6fhgts@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahbSwczOpsBKby7o@pedro-suse>
 <800d894e9a54440fa1d7f7b76e50a45b@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800d894e9a54440fa1d7f7b76e50a45b@honor.com>

On Thu, May 28, 2026 at 06:45:07AM +0000, wangtao wrote:
> > >
> > > Feedback and suggestions are welcome.
> >
> > I'm afraid, per previous discussions[1], that no one is really willing to maintain
> > extra complexity for the current state of anon rmap and anon vmas.
> > Sorry :/
> >
> > Also, please don't send series this large without previous discussion and _at
> > least_ an RFC tag.
> >
> > [1] https://lore.kernel.org/all/aec533b2-37a7-4f44-a279-
> > c4aa604206ac@lucifer.local/
> >
> > --
> > Pedro
>
> Thank you very much for your reply.
>
> As I am not very good at english, I haven't participated much in community discussions before and I'm still not very familiar with the usual process.
> I realize now that I should probably have started with a discussion thread first, and that this patch series would have been more appropriate with an RFC tag.
> I apologize for that.

Thanks, appreciate it.

It's also for your benefit - regardless of AI usage or not, you've spent time on
this needlessly, which a discussion could have avoided.

Also as I said, going this way has damaged trust, which also doesn't benefit
anybody.

mm is a welcoming and open community, the best approach when looking at
something like this is to engage with us :)

>
> I will read the discussion in [1] more carefully. I also noticed the related code here:
> https://git.kernel.org/pub/scm/linux/kernel/git/ljs/linux.git/log/?h=project/cow-context
>
> Many years ago I had already noticed that data structures such as vma, page_table, and anon_vma consume a significant amount of memory.
> However, since the mm subsystem is quite complex, I didn't look into it in depth at the time.
> Recently, with memory costs increasing, I revisited these structures and analyzed their memory usage again.
> Since anon_vma seems to have a relatively smaller impact compared to vma and page tables, I started by exploring possible optimizations for anon_vma first.
>
> Although anon_vma is relatively simple, there are still quite a few uncertainties.
> So I waited until the basic functionality was implemented before sending the patches for discussion.

Thanks, I am more than happy to discuss my approach. You can also see slides
from my talk on this at LSF/MM at https://ljs.io/talks

(Note that the code linked is an incomplete implementation, simply some early
code to give a sense of the approach taken!)

I would ask, however, in general that you hold off on anything code-wise before
I am able to issue my own RFC implementing this approach so we can avoid any
overlap/confusion.

>
> Thanks again for taking the time to reply.
>
> --
> Tao
>

Cheers, lorenzo
