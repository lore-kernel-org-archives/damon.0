Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486B3A294
	for <damon@lists.linux.dev>; Fri, 10 Nov 2023 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LW65BgWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16845C433BF;
	Fri, 10 Nov 2023 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699641083;
	bh=hwCvephXkVaTmz22ATWp2p7mlz7+SKurkbCDiuKn4Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LW65BgWnZC7HeHU+pkcCg+T+OR16Z6yZdHaj3NMy3LFgtdfdJhfNlRetWITbmG0Sg
	 yAuSXeDpXHtDAa017hsIv+elgdjy2N5bik8uQvJJTVJnPKFugwhtLuxs7DvkDUqP+G
	 IpwJ9b+R7+6MThAVIAB9+g1OvsDpdK7Wp7X+e/eo=
Date: Fri, 10 Nov 2023 10:31:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Hyeongtak Ji <hyeongtak.ji@gmail.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hyeongtak Ji
 <hyeongtak.ji@sk.com>
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of
 schemes
Message-Id: <20231110103122.21d5fb5f3d60f1f4f5bd143f@linux-foundation.org>
In-Reply-To: <20231110182240.65426-1-sj@kernel.org>
References: <1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com>
	<20231110182240.65426-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 18:22:40 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello Hyueongtak,
> 
> On Fri, 10 Nov 2023 14:37:09 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:
> 
> > The function '__damos_filter_out()' causes DAMON to always filter out
> > schemes whose filter type is anon or memcg if its matching value is set
> > to false.
> > 
> > This commit addresses the issue by ensuring that '__damos_filter_out()'
> > no longer applies to filters whose type is 'anon' or 'memcg'.
> 
> Nice catch, thank you!
> 
> checkpatch.pl shows one warning, though:
> 
>     WARNING: From:/Signed-off-by: email address mismatch: 'From: Hyeongtak Ji <hyeongtak.ji@gmail.com>' != 'Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>'

This can be addressed by including an explicit From: line at start of
changelog.  Which should we use?

> > 
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

I'll add 

Fixes: ab9bda001b681 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org>

