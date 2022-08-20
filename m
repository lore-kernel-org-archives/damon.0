Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB762F51
	for <damon@lists.linux.dev>; Sat, 20 Aug 2022 21:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11E7C433B5;
	Sat, 20 Aug 2022 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1661030223;
	bh=Sb8q+wdl7LvC3K03D3hmnGvtwPPUklgx1RNisq/uZBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vaIY3p3qbtc5FEF/gv8e80FXAjxQrY4cgEWfZ8kn3457psduk9CsYcwGhWAh3tPPy
	 t9r/Fh4+WG8kUNlye8P1KwmGGPyB+73hScPPXDXl8gke/9XTV+4fO4pZUeSYemhbPk
	 H7ijKQ6ETGuT+VTsm7xzuxVZevSo8ZeNuzeJTiJw=
Date: Sat, 20 Aug 2022 14:17:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sj@kernel.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: validate if the pmd entry is present
 before accessing
Message-Id: <20220820141702.e731f2aade5da8cbe0c78cba@linux-foundation.org>
In-Reply-To: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Aug 2022 15:37:43 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
> page, also including the case of non-present (migration or hwpoisoned)
> pmd entry on arm64 or x86 architectures. That means the pmd_pfn() can
> not get the correct pfn number for the non-present pmd entry, which
> will cause damon_get_page() to get an incorrect page struct (also
> may be NULL by pfn_to_online_page()) to make the access statistics
> incorrect.
> 
> Moreover it does not make sense that we still waste time to get the
> page of the non-present entry, just treat it as not-accessed and skip it,
> that keeps consistent with non-present pte level entry.
> 
> Thus adding a pmd entry present validation to fix above issues.
> 

Do we have a Fixes: for this?

What are the user-visible runtime effects of the bug?  "make the access
statistics incorrect" is rather vague.

Do we feel that a cc:stable is warranted?
