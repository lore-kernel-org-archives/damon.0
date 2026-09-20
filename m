Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D82FD69D;
	Sun, 20 Sep 2026 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901368; cv=none; b=RFOphqW5MLPBBbGMQiaHPclwSvFXS+/tTOT6xRRbq6cw9VDn2yA3ycDLTqOsZOS5Da0XYsVs8HuEIgVpx9jam8X7G0yBazaGly9QNdnslBV4gODY+SavzPbhUmImB/FYFR/VECSzhGDF7/nJmUU+i/bJve6xThkK7cjQ9MF65i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901368; c=relaxed/simple;
	bh=UkzeUPJIusodyzmatggs0A8U37oz4ka5GzFpPrHMbr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf3/jqloAHANTuCioudjccQbonUKVq/Sw3rnN21rhMSY1+CwBhP596g666ux+fZs+6X6PWFapOXSInAgXTkszNfr6GmscPoPmuHMTQ+cVkVgffsHHvp81X93lGN5J4sHTPxiKRcbBEGgPWl/zP2uObCT4AzmznVVZMcIOHjd3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikcr+qnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikcr+qnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF271F000FF;
	Sun, 20 Sep 2026 10:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789901366;
	bh=JicpyNhz6N3EZ+HXyuGJGE/XahAzl0DJVcQ8CuCuwiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ikcr+qnWJfVqd2AgCrOOBMxrPGowMeVA+uVwPoanYFzc0rIQriUS+gZpQ0B+5RyHY
	 g6qhWeXZkgdllHuM6l1ytBBw/6iIuopCsJgKRfWDeFi4bDbWJQRlMOzfQCGt/Z9IER
	 psptqDk2r8Ot96aMNzlP2+xVQ7LuSKkgkxCPZ98OpnLM7hUKMoV+zvkct16xXcdzjN
	 tvB7ZE0zQ0hikbPrZqjnWzVXrqFtnv5zZROTr1kHkiMv5jJfQ7moCOagMO6xw+558l
	 4GBrOimDySU1V/bzeIEEx9E4NmGlmvCnv8hEiGj5fFDb/zslGvpEKwZRxDhysko1fP
	 PfsLVlMVkSglA==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Docs/admin-guide/mm/damon/usage: document the temporal tuner's quota limit
Date: Sun, 20 Sep 2026 03:49:20 -0700
Message-ID: <20260920104921.48065-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920023111.2466265-4-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 11:31:11 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> The temporal goal tuner converts the size quota into basis points in an
> unsigned long, so a quotas/bytes above ULONG_MAX / 10000 does not fit,
> and is handled as if no size quota were set.  On 32-bit that is 429496
> bytes, well below the "echo $((1024*1024*1024)) > quotas/bytes" this
> document instructs.  addr_unit does not raise the limit, though a larger
> unit does make it harder to reach.
> 
> Note both in the goal_tuner description.
> 
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index ba47255448564..ea7443b307826 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -455,6 +455,13 @@ the background design of the feature and the name of the selectable algorithms.
>  Refer to :ref:`goals directory <sysfs_schemes_quota_goals>` for the goals
>  setup.
>  
> +The ``temporal`` algorithm converts the size quota into basis points, so it
> +cannot represent a ``bytes`` value larger than 429496 on 32-bit kernels, or
> +1844674407370955 on 64-bit ones.

This feels like too much implementation details.

> Larger values are handled as if no size
> +quota were set.

I don't get what this means.

> :ref:`addr_unit <damon_design_addr_unit>` does not raise the
> +limit, but it does make the limit harder to reach: with a larger unit, the
> +same amount of memory is written to ``bytes`` as a smaller number.

I suggested it might make sense to document this problem, but now I doubt if
this is really helpful for users.  Given the fact that the issue can happen on
only untested setups, I now think this documentation change is better not to be
made.  Correct me if I'm wrong.  If I'm not incorrect, could we drop this
patch?


Thanks,
SJ

[...]
