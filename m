Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8E2D0C8F
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009770; cv=none; b=rMGN7iju9VIgrfXnPnO+f2KOaNQkVZQs3Em84Dm4U3MzT5Ch9rsXB2wBcWpSbyWOncUm99YypE1ug3WT2wMPK9KtN90Hzz00tPX60Poha0EXRJHh73SIOzB1t4oBCnrEFZo3zhktY+gjZ9jR8iL35Yho4PNZNjGy73tf3fGzinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009770; c=relaxed/simple;
	bh=CJGE+gkfzkkcjb7ZjZVdXrquFR3gCDiovGGTL3J5CJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8kLP01zk4yvJNaQMXvrYFJHb6F9JhIYYfcdMz0/b/pz6EGuDgX5YRpEW/hZUDaTJ0pHe13OHQ1qAcu7+6BnAFMAfwEfSTT/Av/q94p41QAHLhuwZaFCimOcJHCfbQwlILEmgzXI/pjv8khuvWatsNCnAAui/3whjyOb4FGqSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKkqkf+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKkqkf+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE29A1F000E9;
	Tue, 14 Jul 2026 06:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784009769;
	bh=w+Q82lvVtCQINFf8GRxxaG3w/j4QQIEMFX3DdGjhX0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKkqkf+JRdEMHBUDGffM++pDnRzDHDVIx4v/d8K1dzqopOcC/t9DpsuFWLnUrKPGF
	 DI2amqcYlkpCjoMkl5t+DAiIKry8flMAJ/Fl4PevCTedNAM5In5ljPlhNqrKHWF0nK
	 vu0OEImqtmo/5aHuNae0umbPrkdyF6uvHUEvpGzcD7wUESV5gmSu2li73RMkZS+8cQ
	 0Vo+LNuMTYOtKQvZMuWBzWA6Zl1W0Z11Hv8FNYNKVf6r1XmxKC+XRDIay5qZaf9geM
	 J+PEgbybJtzeeYk5m6jMckZqPQFaZKXD/IRiaq/rjvN8aBy+idUbDe7gJYUrf8H3kM
	 1UCgKp6AHVK5w==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 06/10] mm/damon/core: hide private damos fields
Date: Mon, 13 Jul 2026 23:16:00 -0700
Message-ID: <20260714061601.69289-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714055436.120034-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Jul 2026 22:54:50 -0700 SJ Park <sj@kernel.org> wrote:

> On Tue, 14 Jul 2026 04:52:40 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] `struct damos->last_applied` is left uninitialized upon allocation in `damon_new_scheme()`, leading to a potential read of uninitialized memory during the first scheme application.
> > --
> > 
> > --- Patch [6]: [RFC PATCH 06/10] mm/damon/core: hide private damos fields ---
> > Note: The format of this report has been altered to provide a free-form
> > summary instead of quoting the original patch code directly, due to system
> > recitation restrictions.
> > 
> > commit 74f6565901cd9e992427e68af079cc1885de502e
> > Author: SJ Park <sj@kernel.org>
> > mm/damon/core: hide private damos fields
> > 
> > This commit updates struct damos to hide several fields intended only for
> > the DAMON core layer by moving them under a private comment block.
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but while reviewing the changes
> > to the last_applied field, I noticed a potential uninitialized memory read.
> > 
> > In mm/damon/core.c:damon_new_scheme(), a new struct damos is allocated
> > using a non-zeroing kmalloc variant. While several fields are explicitly
> > initialized in this function, the last_applied pointer is skipped and
> > left uninitialized.
> > 
> > When kdamond_apply_schemes() performs the very first region walk, it calls
> > into operations layers like mm/damon/paddr.c:damon_pa_invalid_damos_folio()
> > before last_applied is ever cleared to NULL.
> > 
> > This causes damon_pa_invalid_damos_folio() to read the uninitialized heap
> > value and compare it against the valid folio pointer currently being
> > walked.
> > 
> > If a local user configures DAMON and the uninitialized heap memory happens
> > to match a valid folio pointer being walked, could this result in an
> > erroneous folio_put() being executed prematurely? Does this open up an
> > exploitable use-after-free vulnerability during the initial scheme
> > application?
> 
> Good finding.  I will separately work on this.

That said, the premature folio_put() and use-after-free cannot happen, because
damon_pa_invalid_damos_folio() is called only for the folio that DAMON_PADDR
has increased the reference.  The consequence is just not applying DAMOS action
to a valid folio, only once per DAMOS run, only if the uninitialized value
matches the valid folio.

I think this is still better to be fixed as long as the fix is simple.  Quite a
mild issue, though.


Thanks,
SJ

[...]
