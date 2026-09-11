Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5135202E
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136458; cv=none; b=f5zrqI7MRllj4jR1JcsyIsJNy21l83RrSNHd7rUzQwfO3vYhVpy946YR0zpMViZBoztg8BA1AEOYN0s4CvQHlK7SW/62aMoMHnzuY948WXapQYH9iXE/16lze2IOqVZtOC0TmybZR9MqpWwqoogV55YNLfSEwiiIzZWNjC4vjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136458; c=relaxed/simple;
	bh=Ik/s960xrhgcaZjxGdarvpkpnvSA2L1T+ow4igqd5rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpAlGyhy4lOqgHB1ceZ0mZO967svfR+TP8+Xses+wTs0H6QFx4oI65P54JIDUxf83aeEBkZ75QJqtsNem82bhqcp6BiNmTGKvPrqtxXAGPz4Gc55VLzFxCu2ECUiT7wWhj58o8hsUBE6LIksg+nXiRQ8oxJFY6nZ1kE6EnqeDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evc26UEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evc26UEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796241F000FF;
	Fri, 11 Sep 2026 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136456;
	bh=5JE8zWJWP8vhfeRkcNu8iDrtX4zx98G6SOWtcTwUae8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evc26UEcuIUZoj4uWIvXQYZcHfrj5N5Hbi0CZdwgOVUoCe+NrEHMWRawyVH5EgE+r
	 fSM8YyqnRic+WdwQgqUC7PBmca7V2DQe8Kj0hYMrxfZmbzuKqQtembRzoxX+qlH881
	 KM6DolW9GApCXq6BqS7HSYbjFfXKZtb578p1S7Wf99ASY5sX3PNXPXYOYcFI4gqbNs
	 CF0U5aH7zNKZqHHnsjotot4/vK2I3XDUtBbpMiZs2yoPKT5xhdmSR3WyMTKoPjm40V
	 7JgBmsvnHZBz1n4yNn2JaxlWhkbeSe55MEzbL2LEo7sSrfEknTqlYWx0e8F+RKUEYJ
	 G9uRVMt5hyFow==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Fri, 11 Sep 2026 07:20:47 -0700
Message-ID: <20260911142049.97838-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911140425.390011F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 14:04:24 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The docstring for damos_filter_type omits DAMOS_FILTER_TYPE_PROBE_HITS_WSUM from the list of core filters in the second sentence, creating a contradiction in the documentation.
> --
> 
> commit e68a3c149b1b27ea94bc8212e0cde17817f1e4cc
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
> 
> Update DAMON kernel API to introduce new DAMOS core filter type,
> PROBE_HITS_WSUM. It allows API callers to describe the DAMOS action
> target regions based on their probe_hits weighted sum.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 16800b3dc379b..9e84bdeb5616d 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -399,14 +399,15 @@ struct damos_stat {
> >   * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
> >   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
> >   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> > + * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
> >   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> >   *
> > - * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
> > - * are handled by the underlying &struct damon_operations as a part of scheme
> > - * action trying, and therefore accounted as 'tried'.  In contrast,
> > - * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are handled
> > - * by the core layer before trying of the action, and therefore not accounted
> > - * as 'tried'.
> > + * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
> > + * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
> > + * damon_operations as a part of scheme action trying, and therefore accounted
> > + * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR and
> > + * &DAMOS_FILTER_TYPE_TARGET filters are handled by the core layer before
> > + * trying of the action, and therefore not accounted as 'tried'.
> 
> [Severity: Low]
> This isn't a bug, but should &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM be included
> in this second sentence?
> 
> The first sentence explicitly excludes it from being handled by the underlying
> operations, but the second sentence omits it when listing the filters handled
> by the core layer. 
> 
> Could this omission in the enum damos_filter_type docstring confuse developers 
> about whether PROBE_HITS_WSUM is accounted as 'tried'?

Good finding.  Reposting the series for this is too much, though.  I will post
fixup patch and request Andrew to squash it if he doesn't mind.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911135510.96914-1-sj@kernel.org?part=1


Thanks,
SJ
