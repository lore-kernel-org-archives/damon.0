Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841350;
	b=CW+fMbODFKdKPiOx7tNRvnMW6n+aRU0dL2vCe2Iz1tPUMmSTEUOQ14+nBqFx0pUyVSOQ
	 k49raaxrBqXi7u0Bgrbi1pdHCsYz8j8iqyZrokgiQJQVbS5WLsJVP8c4/2iuX10E//+NV
	 aD4vmG0NxtjQe/Qej8l2/TOn0I+0en3MfJfGAR3rE0t84SlrVQjDKZTSM2gjoEbGxmAQ6
	 ESvZZy4C8MCCwzc7vrTlxdZpvjPazbdSQ7W2cQY1o8WHbkgCsvyRZLZXaTnxpP5HoZku8
	 rol7F21AUZaxs6PQrTWbgerOE2338QLORHSXA1z+yGyQEDfHYyEAm5YSt4PSFzlkYOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Rko/oVa5FlJMWt6lgI18FJfDtxQ0qN5STtLR6l6SJiM=;
	b=1xDjYxZ3jTbfWoD845o84MnFoonKZZA+YjxxDvcoWoYX2NaB4oTf00CH2vcQKfW9L2WL
	 cXc25LREaeYjtqu1zReXDewB9oH38TZHfW1/DJalrCr2LILzbrWYcKkK7zSU6fxkB95Yh
	 kLHgvU0WOTmqBKT6ld4Aj5vC6DvM5/Ag/I7KtA+0jFhs0iTC3+cXZqa0PPjEGEfQgLpxX
	 AmtxmdTP8/z65eZcJBy4CSW/8gHVxlH+1myy/KcCmUMm6oCH2IbNr7ZGWdhMzwrq6IWFa
	 ZYqWBmf+p4smF2+qr0TJrro4ilNwWSF144wesJ/0D/yrrdpy6OCKeL7swtuWCrVdO/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWPhHi63;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E958606A31B;
	Thu,  5 Nov 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWPhHi63
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8A21F000C1;
	Thu,  5 Nov 2026 01:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793841349;
	bh=Rko/oVa5FlJMWt6lgI18FJfDtxQ0qN5STtLR6l6SJiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hWPhHi63xBWIe8w49sI1jemg42UKII7ysuNMr8mEs0I76GTzAMMS9I+OkKbonZvZ4
	 QSWOmxA1dYXxbaWc7H8ZMlJnQxTs+shIg0AmbKdZqNwjJ+2o8QIG/hbnkvPZA9PYbu
	 5fJXuOoDTeqnzgcwuV5v3gk+gGYspxsQdKXa6NrDE5lTxwbVc3wA5Mw7DmWXbijYrQ
	 5T9EFbM/hgxEX3nWa0Z7efOyzGquX3Caepdl1yyInswDFRChZjikU5uuRQF6HYcO5M
	 jH7X1ABapKmgbn0eTYj1lL4JbkR/mPJMCmTCoIhAdL91yeJsZ1h2nl0MfvmjzLjeri
	 iHnb62PFUYiWA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] DAMOS access pattern supports selecting regions to apply a given
Date: Wed,  4 Nov 2026 17:15:41 -0800
Message-ID: <20261105011542.87865-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104153645.82945-1-sj@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  4 Nov 2026 07:36:39 -0800 SJ Park <sj@kernel.org> wrote:

I forgot adding a subject line.  As a result, first part of below paragraph was
added to the subject.  Sorry for inconvenience.  So, please read below
paragraph before the quoted followup paragraph to read the full intentional
cover letter message.

    DAMOS access pattern supports selecting regions to apply a given
    operation to, based on their age (access frequency stability).  The age
    is specified in the aggregation intervals unit.  The aggregation
    interval can be changed by users or intervals auto-tuning features.  If
    the intention is to specify the age in a deterministic way (e.g., 2
    minutes), it should be updated for each aggregation interval update.
    Doing so is cumbersome and challenging, particularly in the interval
    auto-tuning case.

> One straightforward solution is extending the DAMOS access pattern for
> specific deterministic time based age specification.  However, DAMOS
> core filter is a better option.  It is playing a similar role in a more
> flexible way.  It can be used for both accepting and rejecting regions
> based on if they matched or unmatched to a given criteria.  Multiple
> filters can also be combined for more flexible and detailed rules.
> 
> Extend DAMOS core filter to support milliseconds unit based age
> criteria.
> 
> Implement a new DAMOS core filter type, DAMOS_FILTER_TYPE_AGE_MS, in
> core layer and expose to DAMON API, via patch 1.  Add the support of the
> feature on DAMON sysfs ABI with patch 2.  Update the design and usage
> documents to explain the new features with patches 3 and 4,
> respectively.
> 
> SJ Park (4):
>   mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
>   mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
>   Docs/mm/damon/design: update for age_ms damos core filter type
>   Docs/admin-guide/mm/damon/usage: update for age_ms damos core filter
> 
>  Documentation/admin-guide/mm/damon/usage.rst |  3 +++
>  Documentation/mm/damon/design.rst            |  3 +++
>  include/linux/damon.h                        | 16 ++++++++++------
>  mm/damon/core.c                              |  9 ++++++++-
>  mm/damon/sysfs-schemes.c                     |  5 +++++
>  5 files changed, 29 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 32e967f279b24f952a5482e2c427894787848ee0
> -- 
> 2.47.3
> 
> 


Thanks,
SJ
