Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6463A296
	for <damon@lists.linux.dev>; Fri, 10 Nov 2023 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLpW5BMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E427C43395;
	Fri, 10 Nov 2023 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699641096;
	bh=Cd+a5xzw1t7k6mz6ZPquvIB5Ojq2rLP5RewLP3v40qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLpW5BMj+iwJDnH11uWDwp+RwLlXxJL7ovTVethAaULIpRW2lNkTP+AW5E3SYrp2x
	 4BwwaIGsG5fmyT+COnH9i5YuP+6U33hW12UBly2A3EIrhf60g7hibgCykRoIMa4ti+
	 kZpWjxtJn2NhtqFEthWKsNa1cSK5s0aljGqfB2vbWJI6tD6UEUO2J0Ol/AyFfOuPrH
	 mNzuaoStE9hZ1guJsvj7CqmPovnLW8Y2z9R2b1pJT2fU/ol2HQJKs7/gD3iadvoT06
	 E6azr0SzwftNQKfG26nKMtzbDAaezkj8rJoZ+w/y/qfQNwUCgxrs4RiOIGo955KX02
	 N6xOSz7wK3tng==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Hyeongtak Ji <hyeongtak.ji@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of schemes
Date: Fri, 10 Nov 2023 18:31:33 +0000
Message-Id: <20231110183133.65565-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110182240.65426-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
> 

Also, I think we need to add below?

Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org> # 6.6.y

> > 
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
