Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0E2236F7
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968707; cv=none; b=YAMqfon7zvIlELtybC4nU2MxO8uSNOekmQk6bRH8PrvzecYIsiqXiK8bQd6fCjK5FCyxbwEGhs620dKAwCWnouKwICh4Jg3vmoJdeLUno1vCslBxHFj1XqGdK9ZMEg6XPhz2xVOXLMXcJuQDPFl800h734YFSGjkMZVchVdAQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968707; c=relaxed/simple;
	bh=P0MYaJ+ScdBrFPR7hVmj0u/XLYkXruwzFIZjjRrIWgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIu7yzrcCLxST0bLJwUn0Adk7kPUYvG5b8kxf9GSu6yp7br7Bqt/RrRl1+gPwO4OXgyAc/fZl+iPY5l3B4b2A10JKjJIiS8MjRW5EYmB8lre2za/hSXSjBBYf2rd2tsiWelePFtZMxUeSHaMvhwYQWMJG9SrD4MrMroRjdiqyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMEr5UHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMEr5UHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26193C19425;
	Sat, 16 May 2026 21:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778968706;
	bh=P0MYaJ+ScdBrFPR7hVmj0u/XLYkXruwzFIZjjRrIWgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMEr5UHcJGFTYqxvsqcVvW3QV6KG1khgbn67tZvf9PuC8k8x56oG8GJKbQcJKVxVr
	 ReU25szgndA949OILzeBhjoXL610GmQwYvmihLvGivkHMN6A+r7DHvDXIUn8X3ErQ5
	 PmJiL3cMnVLv7BQ0Vov/Trjmy13NSNboy4ELV7H4PkMrgSipKsdcSk83Z7WJJ0uoot
	 XKR9GrC7xynuJ1un+aevl4HnPg32eDfRTeC37mONV7u5w0BaUN1kyFDRQZUaKf66xh
	 11lCnxstHvINAI6HxPiqkpLnTcWyDKLhSaRdjs7DgfYYfFCn13LOqNXLJsdvyfQPjj
	 57gsWik67EHQA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 28/28] Docs/admin-guide/mm/damon/usage: update for memcg damon filter
Date: Sat, 16 May 2026 14:57:42 -0700
Message-ID: <20260516215743.3654-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516190932.1B49AC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 19:09:31 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Inconsistent sysfs UAPI naming for identical memcg filter concepts ('path' vs 'memcg_path').
> - [Low] Awkward and non-standard grammar in the documentation.
> --
> 
> commit eca4a8cfbb76f7f5c4df18fb3c84beeef902be91
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: update for memcg damon filter
> 
> Update DAMON usage document for the newly added belonging memory cgroup
> attribute monitoring feature.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index 7b6074a1666f3..b4584c0e4cd72 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> 
> [ ... ]
> 
> > @@ -283,7 +283,9 @@ the data attribute for the probe.
> >  In the beginning, ``filters`` directory has only one file, ``nr_filters``.
> >  Writing a number (``N``) to the file creates the number of child directories
> >  named ``0`` to ``N-1``.  Each directory represents each filter and works in a
> > -way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
> > +way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
> > +``type`` is ``memcg``, ``path`` file works the role of ``memcg_path`` for
>                                       ^^^^^^^^^^^^^^^^^^
> 
> This isn't a bug, but this phrasing is non-standard. Would it be clearer
> to use "acts as" or "serves the same role as"?

Good catch, I will update the next version to use "acts as".

> 
> Also, does exposing this as "path" instead of "memcg_path" create an
> inconsistent sysfs UAPI?
> 
> DAMOS memcg filters use "memcg_path" for the exact same concept. Could the
> underlying kernel implementation rename "path" to "memcg_path" before the
> interface is finalized to keep the naming consistent?

No, I'm here to avoid such thing.

> 
> > +:ref:`DAMOS filter <sysfs_filters>`.
> >  
> >  .. _sysfs_targets:
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516183712.81393-1-sj@kernel.org?part=28


Thanks,
SJ
