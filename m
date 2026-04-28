Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8295464D;
	Tue, 28 Apr 2026 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336567; cv=none; b=buKytp3IB0bLIWTXH2sA0ZvKzY/ZdfAnpAKhos2K/FIHLiYOJ1NEID5iZaE93V5BwtwBIK+V5t07aF/osR3ym2Xj6B4myOXZpMMXGFOQ7XeH2JZxDnNWuFCMz0ZL9FoGWe8/neo9xVyot5+dmQcZMtIichDwWK22yLdD8YLaHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336567; c=relaxed/simple;
	bh=w2G8seVe7Pb9QrXacqG3WVCNlqodGQ4ZiOZhzYJHsms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnvjnHFLJtLjZjDOBQIoTv1OTkVzsX80UJmIphVdJjQmYRydpiJwfTaB8r7dj631QYeydCJEdCuANjQiN9nzVgVzfqnz/NF8utzR3NzprsJxYHxSwHZOQdJshmv6gIB6jOKir1Ti3ueW5LqmNM6mQj3M1KfMdc5W3y98DejL1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxaYXX/E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxaYXX/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5612EC19425;
	Tue, 28 Apr 2026 00:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336566;
	bh=w2G8seVe7Pb9QrXacqG3WVCNlqodGQ4ZiOZhzYJHsms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxaYXX/ELr61hdvV5+eh4hrnDtONEmy2mtmezv1cWHoo5DWtA+eFo03VMe7VBXR/f
	 BIzU7JBQyJ7HtHkEXKSP9Cz6A5sxV/wD4rtanNSlYtXAv7WtLZo2jQxAYp/GEbYiBW
	 XJG1V7H5mjDh6MwvcSoPRnWkNP1wBza725SOdxMasvrLyrrpHjs6oDybj9mPNQt3qV
	 IMazqgkdcQHA+VPaY7vlxGR7ImCNaLI1v4GpyCNpkxEhkn1WE6Flk3FxTqb69b2Ukr
	 NupzIRCvqnq3fc2FS+nyLKYFpOKmuCzPM/kEIXFlr6XLj98XvPTQR5yWT8ZJDk8Bdu
	 PclGV8QKdcefg==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/19] mm/damon/core: embed damon_probe objects in damon_ctx
Date: Mon, 27 Apr 2026 17:35:58 -0700
Message-ID: <20260428003559.113178-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2e2bee93-d68c-4b29-9ad1-1ef975fccec4@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 16:18:14 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 4/26/2026 11:52 PM, SeongJae Park wrote:
> > Let damon_probe objects be able to be installed on a given damon_ctx, by
> > adding a linked list header for storing the objects.  Add initialization
> > and cleanup of the new field with helper functions, too.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
[...]
> > +static void damon_del_probe(struct damon_probe *p)
> > +{
> > +	list_del(&p->list);
> > +}
> > +
> > +static void damon_free_probe(struct damon_probe *p)
> > +{
> > +	kfree(p);
> > +}
> > +
> > +static void damon_destroy_probe(struct damon_probe *p)
> > +{
> > +	damon_del_probe(p);
> > +	damon_free_probe(p);
> 
> Why don't we inline list_del and kfree here instead of calling
> damon_del/free_probe?

I want to hide the fact that we are using linked list.  This abstraction also
makes it easy to control the calling paths of the data structure manipulation.
Meanwhile, smart enough compilers could inline these if it helps.


Thanks,
SJ

[...]
