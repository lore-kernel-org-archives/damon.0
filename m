Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0905213227
	for <damon@lists.linux.dev>; Wed,  5 Feb 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793131; cv=none; b=hLXCN+bu7x9OJIK2+VpX6x7qOaVUVGNjgtA/IcEu3uDVPdRTX78JKmOSi/97g37RmY4h/HbzbR+aIxtMytAwhdf3FsOk1TZrdi1BdHHBpwh3fsXNDxO6CGv4KCgpiQAlHmCRpzo7w9MZD2+1w5YwFXQzmfzspf35+lVYjiFQQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793131; c=relaxed/simple;
	bh=XVzRJVi7hVpCHr4wEdIMv0ZBwmAPeB7hb58ATE1IIJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSKvlAS1dy7730ME6CQK8+7AImsZaAnB06K4lWrFTx3HclBfVkATMc+koCnK7iXAOS+fmafJVS9TCIO3zu9YeeM7MWzIgY1RiyQwH8sL9YcIhx0UnDiyHxLIIhhcypipg5CVW3E1fsfuD0jvMFbN6/1hIDw5AxswGtv/y9czfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKhUA/Xq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKhUA/Xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE43C4CED1;
	Wed,  5 Feb 2025 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738793130;
	bh=XVzRJVi7hVpCHr4wEdIMv0ZBwmAPeB7hb58ATE1IIJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKhUA/XqcjyrJTKhaor5M6A8u1GjPz9xDbt0JWEldUEq79Y+yIbrDW4AdwnYma01c
	 kr9PSrhYq25W+8GI4Vu5WUck18+O8BfONsND9ECQwr69+qnRisus80wpRVKxfXk37J
	 0mc7/4hzPDALmGBxfQOYBm4ObMnRjvWM4zIRJLdFNc/pOs2lVrjFY3q4QKuhHwuugx
	 cNUXUH9R1bh7ei8naM35k9hvtJq+xlRVfft9RBgCoyZYWJ3zASJRDcjZNWnJmkw1P0
	 bkuRdm0hxRG0aKV8TpdPcBrZckDSdzKeaP8fpKsLKBWJvmX7AUCerMOx/gYh1DWLNn
	 CfIk/xWhIWCcA==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 4/6] mm/damon: introduce DAMOS filter type hugepage
Date: Wed,  5 Feb 2025 14:05:27 -0800
Message-Id: <20250205220527.60313-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <49382f59-afea-41b2-8ca5-1bec9fb179dc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Feb 2025 13:52:37 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 04/02/2025 23:12, SeongJae Park wrote:
> > On Mon,  3 Feb 2025 22:55:31 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> > 
> >> This is to gather statistics to check if memory regions of specific
> >> access tempratures are backed by hugepages of a size in a specific
> >> range
> > 
> > nit.  A period is missed?
> > 
> >> This filter can help to observe and prove the effectivenes of
> >> different schemes for shrinking/collapsing hugepages.
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
[...]
> >> --- a/mm/damon/sysfs-schemes.c
> >> +++ b/mm/damon/sysfs-schemes.c
> >> @@ -330,6 +330,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
> >>  	"anon",
> >>  	"memcg",
> >>  	"young",
> >> +	"hugepage",
> > 
> > hugepage_size?
> > 
> 
> So from https://lore.kernel.org/all/20250121200510.43645-1-sj@kernel.org/, my understanding
> was you didn't have a preference between "hugepage" and "hugepage_size"?

You're right.  And sorry, I changed my mind.

> 
> I do prefer hugepage over hugepage_size. This is because this is a type of filter, I would
> say hugepage_size is not a type, but hugepage is. For e.g. we have anon as type and not 
> anon_number. And the "size" part is clear from the min and max which is documented in patch
> 5 and 6.

I agree your points. The meaning of "min" and "max" is well documented.  But,
not everyone reads the documentation, and human's memory is volatile.  Also we
might want to further extend DAMOS fitler for other hugepage properties, say,
zero-filled hugepage-internal base pages ratio.  So now I prefer
"hugepage_size".

> 
> TBH my preference would be "folio". What I think we should do is let users input any value
> for min and max, as long as max > min, even if its just 4K page. If the user just wants
> to know how much of the region is 4K page, they will get it with this.

We can still do this, since DAMOS filters work for not only matching memory but
also non-matching memory.  It's not very intuitive, but at least makes a sense
in my opinion.

> But as David said,
> folio is a kernel concept so might not be best to expose it as sysfs to userspace?
> 
> As folio might not be an option, my preference is going with hugepage, but as its not
> an implementation detail and just naming, I am ok to change it to hugepage_size if
> you have a strong preference for it.

Yes, I'd suggest calling it "hugepage_size".  I don't find a problem it will
cause, other than the length.  Please let me know if I'm missing something,
though!

Again, sorry for changing my mind after the last discussion.


Thanks,
SJ

[...]
