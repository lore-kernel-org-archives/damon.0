Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCC4A1A;
	Wed,  2 Jul 2025 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415799; cv=none; b=ADMXgKQp+9LaK4uUweZdZ6LAlGbD8uIOPaCYV5dqkyQEhjOdkJxBBl2qdTuX9p6N4zfr4l/Ivi6SWEf7PybKShUl25/jUnH+Tizukddq0cFn0yxZeLl6OwQvXcuduQ+4lOeqFTb3FeIJEQcfGHoK0d0GhCQppUCYLoUU4beu1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415799; c=relaxed/simple;
	bh=3Dx6SOGktlpWitmJQ1//ZWkVkagwCpxpW8LCa46sgeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDYbSQtQMLfQrl3tc54pOCpo+INIGeLQFjLJxmTB5BlwSvG0udHhYXE2g5bPF5PMfawKA2p9c747fB+rtFF4shHzANUdgI9IFiPrKEJ46YjpN7ERlmPsGoN08jmpFglrl7eHrzEH+p1zb+Sg0w+ji9tT6okV2liKn1c75nNO4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw3I0MJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw3I0MJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06665C4CEED;
	Wed,  2 Jul 2025 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415799;
	bh=3Dx6SOGktlpWitmJQ1//ZWkVkagwCpxpW8LCa46sgeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rw3I0MJydoSdPJN4OEk94Fk1rh1bhKkg5CU2FAw7Xdepw9/MC0LggJYmc+t/ILPx9
	 Kzk9dmv4k8UEMrEvUV2Fahzh9x+F77o9cOwVlkKTYyCPxMyzijgCdhiGZdCLsd/KAO
	 wWq6mUeInWqQ9NvElb4M4PGTkPjrrDgLnud7SFDP3hvcItKthwXHqPz7Eaf9fqLaIQ
	 DGkL3IjT0VnTmjbVDqplZlJATIGtWh7VIEr/TOtIs9/EYl7BTwA1o1RXU+S1bfJXtC
	 Erp6aEL9Rztr4xEyFbxhazhqfXkKPpNOqrONYdhxQyoW2tUkLHImKGziJqVkteBYwM
	 smnWDqcnFmUeA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon: add DAMOS_MIGRATE_{HOT,COLD} destination nodes and weights
Date: Tue,  1 Jul 2025 17:23:16 -0700
Message-Id: <20250702002316.1139-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701224014.9008-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Jul 2025 17:39:37 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Sat, 21 Jun 2025 10:31:27 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMOS_MIGRATE_{HOT,COLD} action can migrate pages to only single node.
> > It could be useful to allow it migrates pages to multiple nodes with
> > different weights.  A work for dynamic interleaving[1] is in progress.
> > We also discussed this could be useful for memory tiering, e.g., when we
> > want to move pages to multiple noes of same tier.
> > 
> > Extend the API and ABI interface for specifying the multiple destination
> > nodes and their weights.
> > 
> > Note that this RFC is a prototype of the interface change for Bijan's
> > interleaving work[1].  Hence this patch series is only implementing the
> > interface part, not the real implementation of the migration behavior.
> > 
> > [1] https://lore.kernel.org/20250620180458.5041-1-bijan311@gmail.com
> > [2] https://lore.kernel.org/20240408175228.91414-1-sj@kernel.org
> > 
> > SeongJae Park (4):
> >   mm/damon: add struct damos_migrate_dest
> >   mm/damon/core: add damos->migrate_dest field
> >   mm/damon/sysfs-schemes: implement DAMOS action destinations directory
> >   mm/damon/sysfs-schemes: set damos->migrate_dest
> > 
> >  include/linux/damon.h    |  29 ++++-
> >  mm/damon/core.c          |   4 +
> >  mm/damon/sysfs-schemes.c | 253 ++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 282 insertions(+), 4 deletions(-)
> > 
> > 
> > base-commit: 78745efafbb93197e476717385616ed57ea2df22
> > -- 
> > 2.39.5
> 
> Hi SeongJae,
> 
> Thanks for putting this patch together. Sorry for taking a while to
> respond to it.

No worry!

> 
> I am finishing up V3 of the interleave patchset using these patches. It
> has mostly worked great, but I noticed that damos->migrate_dest was not
> being updated in damos_commit(), so new weights would not be applied. This
> meant that you could not update the interleave weights by committing the
> damon state. I also saw that damos->target_nid was also not being updated
> here. I will will have a patch fixing

Nice catch, thank you for finding the bug and making the fix!

> this with the V3 of the interleave
> patchset that I will hopefully send out tomorrow.

I cannot wait, but please take your time! :)


Thanks,
SJ

[...]
