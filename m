Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9803F65FC;
	Tue,  6 Oct 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290008; cv=none; b=dy19EId9iG1vTjYf0Nq9fyBepBb0zYYezL3P1iSJw1CxbygaVrWBNv1VWu8cev58hnUQjig1upbtO/S1WBpOOZRHAWZE2YIqUJV+fbhn7dnERT9tzZTSx48um5QhptBPJIdqqpeQwGXTwv3waRBZp4XTmBHusVBo+egzmKbm3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290008; c=relaxed/simple;
	bh=1yL3mOc5ltvCE2treMWX5UopM26Na+++i1RBZi7m9+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkfGLjygPeB8jcWZ7mKBaNXo9Bd3qeqSIMqlsKfhCQl0qWw+NLB3p+q6CzC9sQ4AO+I9iJ3TKj05H2zumS0qUoPQ5l6hz3gzyogHQATR1TgzlM1RwDRYgKBeYumz1KPvEmtMy7zOc6SHIu4b/JGgUFPV3ux+1uMjsWY/KiyE8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Fk7FAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Fk7FAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D9D1F000FF;
	Tue,  6 Oct 2026 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791290003;
	bh=WaBQXt6BAEwioRHAlv69sr1PP2qIDJgC8v1Jn1ojm/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0Fk7FAb6G2QU8TP5QP6Df4oU7KOmFNEPXnVkxGXn1ctfXOiKGH0dOOay6nYD+ZY3
	 sRYMUixtp15Xi+EtkAzidTbGMecS7m7P6+fWOHnWJztchDa3gcoUUW2WHlEg0Fb3xT
	 qV7yY7GxlVUqWa9X20gxwB/5qKiyV8PFyuRNv7MiQbaDC1MAZV6cIREacgP4T5V+f6
	 /KijtiWnRp0SzbcQ3ev5JarNjnzwscQmHlPyUXGqTk7slNKgbXvUBkkfS7KtY0suVl
	 9Uc726ShyDnmP0B01oIumZq8FE9OqRh6a+LI3OE8UvY4xCbXbJ4m0Sm9W4GM/D4GPb
	 oqE9FtO63i5Og==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com
Subject: Re: [PATCH 1/1] mm/damon: fix typos in comments
Date: Tue,  6 Oct 2026 05:33:18 -0700
Message-ID: <20261006123319.45800-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c2c4279ac5948b1debbe597eea1210fd667801f6.camel@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Manuel,

On Tue, 06 Oct 2026 10:38:38 +0200 Manuel Ebner <manuelebner@mailbox.org> wrote:

> Hi Adrian, 
> 
> On Tue, 2026-09-15 at 18:27 +0800, Adrian Huang (Lenovo) wrote:
> > Correct spelling mistakes. No functional changes.
> > 
> > Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> > ---
> >  mm/damon/core.c     | 6 +++---
> >  mm/damon/lru_sort.c | 2 +-
> 
> could you add this changes in this file?
> 
> DAMON_RCLAIM -> DAMON_RECLAIM
> 'set as' -> 'set to'
> 
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0c98f7e267d0..981a153619c0 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2447,7 +2447,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
> >   * This function checks if a given region should be skipped or not for the
> >   * reason.  If only the starting part of the region has previously charged,
> >   * this function splits the region into two so that the second one covers the
> > - * area that not charged in the previous charge widnow, and return true.  The
> > + * area that not charged in the previous charge window, and return true.  The
> 
> Please make it 'area that is not charged'

Would you mind posting those as another patch?


Thanks,
SJ

[...]
