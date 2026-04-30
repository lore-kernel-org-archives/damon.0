Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4A14884C
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508939; cv=none; b=fmmfnstz0Y5xCQv2o6dsCZaUrO95y4l/zL6cEXJPKdwAUeHb8wiD/6VKhiYZLPzlNAZWdGv1bBtgbS2VwbfAOtSDw67LrXYn9U/9V5sPEF7NvRa379gaOT0fS8HecfJu+3ach6Si/2alRi6u7UQ2x4GPwppOKu+besVKov9fCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508939; c=relaxed/simple;
	bh=MmbWJxQdOxB7HPEusiiynggUGfwhdF7KZVUvajhDvVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edGUBK+tX/EHWMimWJaeSErHcdWTVa2SkWDiVYJIQVmBncBjN/u/qZAC9AnTdpWyJ7OQvufckPP/JO8oOY7gx8X7/ZCdQq+k7AAueOclNdAR7OV4Ff88NnwEj7CpOWerD3A2PRqxvr94W1qeUpnhgu/RfysZYV3I8+k51idmNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdJc1oaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdJc1oaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74354C19425;
	Thu, 30 Apr 2026 00:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777508938;
	bh=MmbWJxQdOxB7HPEusiiynggUGfwhdF7KZVUvajhDvVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdJc1oaEQhAEOvqSm7n1CXAWWvNuLceRXbyIcULvQovlTolvx0XS0wNvrNJyFejmH
	 29O6H/6yA5SuWujtQB4ppiFH5aW4ev5tkcOtezAGso6McvQPJNWp9RfiOOpa3xx/CX
	 0uBHKnmSiuo59E2qg/deIGNg7tzWS50L/bme32D/o3jjGDIC0b8Q9HILHAr/3fxjST
	 hGqH9EzDXztCYJzpnjzbBop4hlP45U3/zYrBu0cXrK9wGO8Q4BZyHKZ9r5xDYmtJ74
	 S7GTxiK/FKKAkgvXCRsK1Kv8BpgiKi7grBr6OXvkSf6hcQ1H0zsGKlYffngEQs0cCU
	 pThCaY6+eKBsQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/2] Docs/ABI/damon: mark schemes/<S>/filters/ deprecated
Date: Wed, 29 Apr 2026 17:28:53 -0700
Message-ID: <20260430002854.113319-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429193856.4E65FC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 19:38:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing `What:` entries for files under the deprecated `filters/` and newly added `ops_filters/` directories.
> --
> 
> commit d4b50ba450c215da3baec9d7d831c83147cf209c
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/ABI/damon: mark schemes/<S>/filters/ deprecated
> 
> This commit deprecates the filters/ directory in the DAMON sysfs interface
> and updates the ABI documentation to use the new core_filters/ path. It also
> adds documentation for the ops_filters/ and filters/ directories, noting
> they work the same as core_filters/.
> 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > index 2424237ebb10..b61a34b9b185 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > @@ -377,15 +377,20 @@ Contact:	SeongJae Park <sj@kernel.org>
> >  Description:	Writing to and reading from this file sets and gets the low
> >  		watermark of the scheme in permil.
> >  
> > -What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/nr_filters
> > -Date:		Dec 2022
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters
> > +Date:		Feb 2025
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	Directory for DAMON core layer-handled DAMOS filters.
> > +
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/nr_filters
> > +Date:		Feb 2025
> >  Contact:	SeongJae Park <sj@kernel.org>
> >  Description:	Writing a number 'N' to this file creates the number of
> >  		directories for setting filters of the scheme named '0' to
> > -		'N-1' under the filters/ directory.
> > +		'N-1' under the core_filters/ directory.
> 
> [ ... ]
> 
> >  What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/ops_filters
> >  Date:		Feb 2025
> >  Contact:	SeongJae Park <sj@kernel.org>
> >  Description:	Directory for DAMON operations set layer-handled DAMOS filters.
> >  		Files under this directory works same to those of
> > -		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
> > +		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters
> >  		directory.
> >  
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
> > +Date:		Dec 2022
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	Directory for DAMOS filters.  Files under this directory works
> > +		same to those of
> > +		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/{core,ops}_filters
> > +		directory.  This is deprecated.  Use the core_filters and
> > +		ops_filters instead.
> 
> Will automated ABI parsing tools like scripts/get_abi.pl be able to find the
> documentation for the individual files under the ops_filters/ and deprecated
> filters/ directories?

Seems now the script is renamed to tools/docs/get_abi.py.  And I'm not very
faimilar with the script, but I confirmed at least 'get_abi.py validate' is not
complaining anything about DAMON.

And this part was anyway like this before this patch.

> 
> Since the What: lines earlier in the patch were renamed from filters/ to
> core_filters/, the old sysfs attributes and the new ops_filters/ attributes
> are no longer explicitly listed. These tools rely strictly on explicit What:
> entries and ignore textual cross-references.
> 
> Should multiple What: lines be stacked above the shared descriptions so that
> the core_filters/, ops_filters/, and filters/ attributes are all correctly
> parsed?

So I will revisit if some people start complaining.


Thanks,
SJ

[...]
