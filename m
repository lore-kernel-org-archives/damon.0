Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD862FB3
	for <damon@lists.linux.dev>; Fri,  3 Mar 2023 18:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1375EC433EF;
	Fri,  3 Mar 2023 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677868644;
	bh=5VS5XD3aopCKWM9JTeZDCTyMBWVPcB+DkyyfJ8MlSXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDsxeXbEpmzOFkAE0D7aQfG+IpmIJt9cqHZzJYXvK54CZ80JIipc9IeCzA618Cxeo
	 1Vl0LGnSiOFgTK1FlzNZKSXTsbztN3MBX0NYE+OQmC4ZeiLI7EQGfK/8Ek8hjTMAW/
	 KjqE64xMvoE8pv91cvzPPURq0d7TEQG1vRXoUn2je/m5scx+X+JpOf7HQoKp4IKJSg
	 rbIMtjW1XAtGQwgGqneY0zsjBdEaaec8m0fxM3Bb5z4ezKOPSeqKuWzSj6ZzY+tjiH
	 aU3Svqc1nFwitx7jHTGaC3bdkM4aXzhanrP1OnjCh5u/BG6dg1FejcPBRLwiNRVwXI
	 SwQQvGAIYh5Rg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mm/damon/paddr: minor refactor of damon_pa_mark_accessed_or_deactivate()
Date: Fri,  3 Mar 2023 18:37:22 +0000
Message-Id: <20230303183722.113464-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303182633.113353-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 3 Mar 2023 18:26:33 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 3 Mar 2023 16:43:43 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
> > Omit one line by unified folio_put(), and make code more clear.
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  mm/damon/paddr.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 2ef9db0189ca..6930ebf3667c 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -266,17 +266,16 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
> >  		if (!folio)
> >  			continue;
> >  
> > -		if (damos_pa_filter_out(s, folio)) {
> > -			folio_put(folio);
> > -			continue;
> > -		}
> > +		if (damos_pa_filter_out(s, folio))
> > +			goto put_folio;
> >  
> >  		if (mark_accessed)
> >  			folio_mark_accessed(folio);
> >  		else
> >  			folio_deactivate(folio);
> > -		folio_put(folio);
> >  		applied += folio_nr_pages(folio);
> > +put_folio:
> > +		folio_put(folio);
> 
> I think this change is ok, but shouldn't the 'folio_put()' have called before

s/before/after/

> 'folio_nr_pages()' anyway?  If so, could we make the change as a separate fix
> first, and then make this change, so that it can be easily applied to relevant
> stable kernels?
> 
> 
> Thanks,
> SJ
> 
> >  	}
> >  	return applied * PAGE_SIZE;
> >  }
> > -- 
> > 2.35.3
> > 
> > 
