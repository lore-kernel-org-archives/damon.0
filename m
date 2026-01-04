Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD93A1E94
	for <damon@lists.linux.dev>; Sun,  4 Jan 2026 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767568059; cv=none; b=HfHztFpjY79Vk2R1gpNq8o2uv/YGogip+f4srm5QwJX19kTR2xOBWJICdZgGwzLuRsqFkw2TKmKzL9Rwd8lqq3LEX2Sf2nTziHscWkRhkrFibgCyK7c6Mok3nwdSScjmkL2JFenfyRYr54Lve5/7Q7DIworqk+EzlAYpnLJlF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767568059; c=relaxed/simple;
	bh=VjS3WbR+m1PlUG+vqvTDHxuJDU7kaIokVpYcq1mV1O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCh7DxXZuhvgY1udHNG6DXfHi0PY9a9MrRC6Ws3Y9pv0IdcGunocftL44NexKgzbBAlR48fI5E63yOvv/fOBM0RE8motKyI4Ucc6hCvKTFIkhMri0WB4AE1imlscPX70t68qraXFDZS69q2gzKgLopyPYO2oU07PtyKtlUkCzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv4/MaqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv4/MaqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51841C4CEF7;
	Sun,  4 Jan 2026 23:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767568059;
	bh=VjS3WbR+m1PlUG+vqvTDHxuJDU7kaIokVpYcq1mV1O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nv4/MaqF5xA2NXG/j2hRDkX5Yy2qSd+HYWjSA9aN1U1TQHUSsqKEPfOB272mlQsZd
	 E6e6yuwSzEJmVMCRNqHyM+hrjNamWjNwEAkFiz0Z7Bb4NDOpgM0LyW4G4qhPewZZYK
	 diPcsxDQqNFFi5s1tWJFTMiRWn1BiOkcug+ssiLhyHL5l/x0ce4pfgwYjlX47u58QH
	 Jikc1Rc5fqLmol2qAwE/fvc4Fwm0ZK3A+AbimX4gbIuGvhRSZuba2LAslfBoqQCpIr
	 JBHdRhkY7VqjRypsRJnDcadGJfYM4LPnUKoFploHb5NM5K1mPd/okks1GN/K9DqKY7
	 FlibPEnsFLfpA==
From: SeongJae Park <sj@kernel.org>
To: Aaron Yang <yangqixiao@inspur.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/paddr: initialize 'folio' variables to NULL for safety and clarity
Date: Sun,  4 Jan 2026 15:07:33 -0800
Message-ID: <20260104230735.67401-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260104013255.16962-1-yangqixiao@inspur.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  4 Jan 2026 09:32:55 +0800 Aaron Yang <yangqixiao@inspur.com> wrote:

> In damon_pa_mark_accessed_or_deactivate(), damon_pa_pageout(),
> damon_pa_migrate(), and damon_pa_stat(), the local variable 'folio' is
> declared but not initialized.
> 
> Initialize 'folio' to NULL to:
> - Follow kernel convention: uninitialized pointers should be
>   explicitly NULL

Technically speaking, this is required only if it avoids unsafe code such as
use of the uninitialized pointers.  Because zero-length DAMON region is not
allowed, this is not the main reason of this change that we discussed on v1 of
this patch [1].

> - Improve code readability and maintainability

This is the main goal of this change.  This change allows readers be able to
know the function is safe, without have to know the fact that length DAMON
regions is disallowed.

> - Provide safe fallback (NULL assignment to s->last_applied is harmless
>   and callers check for NULL before dereference)
> 
> Signed-off-by: Aaron Yang <yangqixiao@inspur.com>

Because my above comments are for only clarifications of minor details:

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---

FYI, this is a good place to summarize changes you made from the previous
version.  For more details, please refer to the doc [2].

[1] https://lore.kernel.org/20251231055737.73325-1-yangqixiao@inspur.com
[2] https://origin.kernel.org/doc/html/latest/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
