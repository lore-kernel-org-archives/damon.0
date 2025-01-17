Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8113B59B
	for <damon@lists.linux.dev>; Fri, 17 Jan 2025 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133712; cv=none; b=A4VtY8773iNzWMGiFbr8lIEXkqRARWBWvBXTfw14aKYmu7VjXbfrl09YJYtHQeVLcnVOGwdDhDdkH6/329uprx+nTZxRLZkiNSZb5/0pMWaWTKMTpBHy8vtvUoAgw8z6he5brGN6AcnNi3H576F6oKeCx3Uw6aurv4SpeDVyjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133712; c=relaxed/simple;
	bh=sBLYq42nXCh1cJRuW3R19kQZcefoL+by29Bl3OgHDSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKRlvX0u/+oUVH3XxAh55v04nizuK3huOAADwkEGmUx+bTfKfRvoEhpJmBXBOnEDVAa54GNrIxqwYxzLgLZiReutePC812A5U2lTsXgBB0FLUlt+Khcq22jt8fE9IDZTBJcOaz+pNKONuAkBBw/QGAP7sFaT13MepYsZB/86kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFO6edxE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFO6edxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53148C4CEDD;
	Fri, 17 Jan 2025 17:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737133711;
	bh=sBLYq42nXCh1cJRuW3R19kQZcefoL+by29Bl3OgHDSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFO6edxEsGeX9NG+lTyELxT+h+oyhTM7HELAuOUf+4ChMYyGkwafwDUa7xarfeQlq
	 0b8g/6HcR7GC2XxhcO/k+OQ+8uNh2ztjKloCFsy0kOOXevumVav0jgTNhAH/Dx5Q7p
	 24emku++eCH0/KeFKNgClH2EydKK5boo1aQwpdc3YF4WcQTLhDCB1EASKbrqvXritD
	 buxuyMPUsQK8xDO6Cws+0z2VsGXB0zRQqrD2pE1I+ZwcCvQYN3geemReHFkf56Sabx
	 QGGSLFVbnuw/E3fjc5ne4TBy4B7WOEUvvXvUkKhlJqdV1JqEpa8z78yqeEKJlcE64o
	 Sox9IrkD0EcBg==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Fri, 17 Jan 2025 09:08:28 -0800
Message-Id: <20250117170828.55772-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cc2aa18d-c494-4b50-b695-3cb84a1ee87c@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jan 2025 11:02:05 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 16/01/2025 19:05, SeongJae Park wrote:
> > On Thu, 16 Jan 2025 14:44:36 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> > 
> >> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> >> index c0ccf4fade24..a9e69179d45c 100644
> >> --- a/mm/damon/paddr.c
> >> +++ b/mm/damon/paddr.c
> >> @@ -222,6 +222,9 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
> >>  		if (matched)
> >>  			damon_folio_mkold(folio);
> >>  		break;
> >> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> >> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
> >> +		break;
> > 
> > This will make build fails when CONFIG_PGTABLE_HAS_HUGE_LEAVES is not set, like
> > below:
> > 
> >  /include/linux/compiler_types.h:542:45: error: call to ‘__compiletime_assert_321’ declared with attribute error: BUILD_BUG failed
> >    542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >        |                                             ^
> > [...]
> >  /include/linux/huge_mm.h:111:35: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
> >    111 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
> >        |                                   ^~~~~~~~~~~~~~~
> >  /mm/damon/paddr.c:321:48: note: in expansion of macro ‘HPAGE_PMD_SIZE’
> >    321 |                 matched = folio_size(folio) == HPAGE_PMD_SIZE;
> >        |                                                ^~~~~~~~~~~~~~
> > 
> > 
> > This simple test might help you reproducing it:
> > https://github.com/damonitor/damon-tests/blob/master/corr/tests/build_i386.sh
> > 
> > What about enclosing the entire case with
> > 
> >     #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE) ?
> > 
> 
> Ah Thanks for pointing this out! Would 
> 
> #if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> 
> be better?

Yes, that also looks good to me :)


Thanks,
SJ
