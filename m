Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578271C2AA;
	Sat,  6 Jun 2026 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707282; cv=none; b=RTvceZSwlQUvt3j2CgsbOMATO8iklkPcH63NrEriZyAHvReSB8Xn1d8g/U+o2nEzBPxvJiIGFkgJlvOOvs1s7YRYoKq6GRiKTWu+0nFG3DdTBv0HDAj7KT8RKDanlgY3C0OGY14/A1x6RkpJ5JcqcnMPEY+NmunHurLfIYMQKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707282; c=relaxed/simple;
	bh=SB+F5ry8r+8f9HZaAHfxQpdjMLgcjYruesr+UbHTpO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKdCQNhXWmw9WBeR2oEJRNeHR53B2QNF7zR+3BhQCysr31BJZXvNeXLN8265MsSh40QTwG+ozGhyTOCI4avIBemRxqoV+knSwuw3jrOOaZRgeC99vWFfnq64c3B0HWorJTDDDPpaysFjofKl6wr9olIfPc4IasHuWVtoongjaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvLlx+JX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvLlx+JX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160A51F00893;
	Sat,  6 Jun 2026 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707281;
	bh=bazsBwZAqXEpICcoFUWoIJvMdHrXGA7lTnnh4WSjPGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvLlx+JXPMuOfA7Efk8lfmz0Wv93vn7jXgI+HQEq113UtqBFcb/gZip6Qi/Q/of91
	 pJKgdBlQGU8pKabFx7bzsn9GmM8xMqHgs6+BXxZsRPkSTTh9ownIcxYO1fcX8jBTS5
	 HbAF5BBlHwXil7CtDIi37axnnhhE799MEbhqz8bblYIpdb5dNv7dmSI0zMkP88D7q6
	 T+d/Lu+//IrDhyVHDgk+Gd43yYPlPPEghzMSYC/6UOlwD+2Y+USiOL8U5CpcW3QW6f
	 2MCib+KAUEsn8m33Gk5v8Z/1guRrPooOPS6B4lackZR1Vx7fKe0EpFmyOkhxUgccsC
	 P3HANo7QAA8QQ==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Lian <lianux.mm@gmail.com>
Subject: Re: [PATCH] Docs/damon: add TLB flush policy document
Date: Fri,  5 Jun 2026 17:54:31 -0700
Message-ID: <20260606005431.89186-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605031008.397328-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kunwu and Lian,

On Fri,  5 Jun 2026 11:10:08 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> DAMON avoids TLB flushes after clearing PTE Accessed bits for sampling.
> The overhead was measured and found significant [1].  Production
> workloads with large working sets flush TLB buffers naturally, so
> accuracy impact is negligible.
> 
> On systems with large TLB buffers and small test workloads, stale TLB
> entries persist across sampling intervals and produce false negatives.
> This comes up repeatedly on the mailing list and in private inquiries
> [2][3].
> 
> Add a document on the design decision, trade-offs, test environment
> problems, and recommendations.
> 
> Link: https://lore.kernel.org/20200403103059.12762-1-sjpark@amazon.com [1]
> Link: https://lore.kernel.org/20260117020731.226785-3-sj@kernel.org [2]
> Link: https://lore.kernel.org/all/20260526145034.91594-1-sj@kernel.org [3]

Thank you for this great patch!

> 
> Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  Documentation/mm/damon/index.rst     |   1 +
>  Documentation/mm/damon/tlb_flush.rst | 131 +++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 Documentation/mm/damon/tlb_flush.rst
> 
> diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
> index 318f6a7bfea4..5e239437dab3 100644
> --- a/Documentation/mm/damon/index.rst
> +++ b/Documentation/mm/damon/index.rst
> @@ -19,6 +19,7 @@ DAMON is a Linux kernel subsystem for efficient :ref:`data access monitoring
>  
>     faq
>     design
> +   tlb_flush
>     api
>     maintainer-profile
>  
> diff --git a/Documentation/mm/damon/tlb_flush.rst b/Documentation/mm/damon/tlb_flush.rst
> new file mode 100644
[...]

Great document!  That said, it feels like a good complete article or a paper,
rather than DAMON documentation that pursue to be short and essential.  I feel
like this fit more to be published in a blog like DAMON project blog [1], or
news site like LWN.  If you'd like to, please feel free to upload a PR or send
patch for DAMON project blog source [2].

Mainly due to the verbosity, as I above mentionedd, I'm not sure if the current
shape of this patch is the best to be merged as is.  I also find the background
part of the document is a kind of duplicate of some information in design.rst.
What about putting only essential information in a condensed way on the
design.rst?

[1] https://damonitor.github.io/site_about
[2] https://github.com/damonitor/damonitor.github.io/tree/master/blog_src


Thanks,
SJ

[...]
