Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2140610E
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 22:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E72DC433C1;
	Thu,  8 Sep 2022 22:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1662675043;
	bh=XCIEEKRk/9WvUsGT3ciNFy1vp9nzMZ5TXc8Ty7hjscY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=w3vl4Md4FHGe0tnYeeCYkS5h5JMouvTrbMEHCgTuEJxAyd0WvjHEUVdC26QvLciGm
	 Q5wf0618dav32gRdyqyKw2UQ5JLNldT0FNoNuSqQ4j66Fdxjh6Eiy+6PyzyuCbZhWK
	 9a/Dju5mptLZw4vwp/HA3Z1+woZeG4meSvOxTEhU=
Date: Thu, 8 Sep 2022 15:10:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Xin Hao <xhao@linux.alibaba.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: change few functions execute order
Message-Id: <20220908151042.239189ddb1635c0f598c6fd2@linux-foundation.org>
In-Reply-To: <20220908184947.103206-1-sj@kernel.org>
References: <20220908081932.77370-1-xhao@linux.alibaba.com>
	<20220908184947.103206-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Sep 2022 18:49:47 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Xin,
> 
> On Thu, 8 Sep 2022 16:19:32 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> 
> > These nr_{schemes,regions,contexts,kdamonds}_store() functions are both call
> 
> checkpatch complains as below:
> 
>     WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
>     #10:
>     These nr_{schemes,regions,contexts,kdamonds}_store() functions are both call

I fix that sort of thing.  A lot ;)

> > kstrtoint() to get relative values from sysfs interface, if it return an
> > error, there get kobject instance would be meaningless through 'container_of'.
> 
> I was thinking the compiler could do that kind of optimization on its own, so I
> preferred to make the code shorter.

Yes, the compiler will do this.

> This change makes the code slightly longer, while the benefit of the change is
> unclear.  I'd like to keep it as is unless we get some clear benefit of this?

I find it a readability improvement.  Puts the initialization in a more
appropriate place and avoids those nasty tricks to prevent unreasonable
line lengths.

