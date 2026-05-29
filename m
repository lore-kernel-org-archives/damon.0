Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2863C457A;
	Fri, 29 May 2026 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098046; cv=none; b=KybWx+dOGm9OUAB1+3nBFWemyY4VQMucxBYARGkinXLS69GGiVdAycNAN+3yYxyZNUOxsAukssHZjsUDBkCOP1NBGNNdg3h0IjHGaFJ8iRLuKFqJ6HLPMdSAcBA3rFQEUQH11+YW+6idT7fUHvp2Kt3k5Aiy3zRO+aJAC7Bac5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098046; c=relaxed/simple;
	bh=U1HDzVJtKMpcCzxHFq1vNBJl1FTNQ/T6BbrXs9VXcqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkWKs1IgA05UyrKV5jnbruKBlN9ncB5frpkkUWT1NYR+Pm+Rx5HL9XUNlOkIvD4qvMUQKODy/hboElBVRxpPG+xMXKwCtY+xBhA4ZSX2gKSogJRL+d/OBO7KRzTYT3D2nLOuG3CNJUTri6NjhImg3sy1tWma39q1aagybImz7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Doa2M2Qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Doa2M2Qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864E71F0089D;
	Fri, 29 May 2026 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098044;
	bh=wqG+2yJQhX3QhV/XJDjT22cZXnVygwf7uv1jGGIA8wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Doa2M2QaJTMnV1NU8nm4lmlz/+tfEfm+WuMuK1PKUAmocD+JvBdI2ZbJ/Ro/t+oS7
	 tGEYZwT7b6a5pUC/wWo0nkhtuXq+rMLVMX0UaYp48QHiikO/nkdIBrIKnvHDe+/28b
	 S5BgB76t5PisQaYK55ECIrc2dOwPbhSI+mOZXuW7op5xec1xe+XW27hvjUIVWWRoQY
	 3jfS8lVNRIezTsNRk1nbXCqEktLkl4Cbj9kpS5JHn6FxkK/fzYes0LvjbfvVKopgon
	 Qib4FHagEy7N0GLDTlpJKm+5zdfgWbmfaOOhw/yT45bjbVuEIRbw/ZjYmAsi2iulNz
	 Ix4Lm/p0JOMPQ==
From: SeongJae Park <sj@kernel.org>
To: =?UTF-8?q?=EC=B5=9C=EC=9C=A0=ED=98=B8?= <dbgh9129@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon/stat: roll back context on damon_call() failure
Date: Fri, 29 May 2026 16:40:37 -0700
Message-ID: <20260529234038.87184-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CACrCO_Xend-ivqq6TZ3GDhfTm-JsyoYJQjgNa5pdeU+5sFwKrg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 16:29:44 -0400 최유호 <dbgh9129@gmail.com> wrote:

> On Fri, 29 May 2026 at 12:00, SeongJae Park <sj@kernel.org> wrote:
> 
> > Thank you for clarifying, Yuho.  I think the current cleanup is ok, but I
> > understand it is confusing to read.  Apparently that confused you at least, and
> > that's not ok.  What about adding a comment explaining the context?
> 
> Thank you for the explanation.
> 
> That makes sense. Looking again, I noticed the same retry-time cleanup
> pattern is also used in lru_sort.c and reclaim.c, so the behavior
> seems intentional.
> 
> I'll send v2 patch adding a comment explaining deferred cleanup and
> retry-time handling.

Sounds good, I'm looking forward to the v2!


Thanks,
SJ

[...]
