Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB620492E4C;
	Wed,  9 Sep 2026 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914290; cv=none; b=VI1rTCfnN35auArT0mV/4b4i/LRFxOWCTRfuqSCxGpLcOTWd5d6H/dOk0GzXsZwM/qoZRd9n9zOK/i57vn7B4wdKs4ZyO/O55K3eoobfAYPQSpnz7DSZGUynqsdn7H8IJf5Wq8Qpfe2fUN6f/BrNT1IvZ3ieoOxNT351YW29hZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914290; c=relaxed/simple;
	bh=WDXVCXp54tcC37VGDDpXC7Ad4CbKESWsEb5Si6CaZ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxm0UweuzjYAV8IPBDfs8erE9lvQA8hiF2vS1BoBIOXJnKYthAZ/96A17Sxtx5hCLbCsGSuTFR5laHQibBZNZO5O+GAURNYDkXenBhkQwmhUEFbiZ9W6vjcah7YMHFTCRJUWEVpjYH36i82aOf2HB1KxTHx9eYLMxFF7RBosftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJDbuH4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJDbuH4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D81E1F00A3D;
	Wed,  9 Sep 2026 00:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914288;
	bh=LW2YRdHu/X4/AGFVGhsWuCM7o9IYlbhU7Z1SrOilMgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RJDbuH4Xd8C32OmTjQnl1Ekc1TagPeVNucME62r/LSxjMqbUS/NpGkKhLw7X77v+t
	 wMD2iRE4JvWPJckS/fJD5vdKocCwK6cSiFHPfLDFm5QCeOdDBUuqXySJuzh+hN4jIL
	 QJNwBLPpS66PBzJrC250WUOOlP7t5iDk9EddOCFqwsDJ7tkjd/gnVXUWP4NksqxE3f
	 PA1eV110rvY3PDvvKKUlioPKp2SknHbCSGVw/xhVwLX2zGKcypjNbH7ZZTrctTlWFl
	 VODweHOCKjSH0rM3I6byMsrxpjMyiMMkucPr1NxyRySHFGmzpeEO1O3IwZgiupc0NQ
	 qHZVDDlRkOWIw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Tue,  8 Sep 2026 17:38:00 -0700
Message-ID: <20260909003800.112569-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908175105.42558-2-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Wed,  9 Sep 2026 01:50:23 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> qt_exceeds counts how many times the quota of a scheme has exceeded.
> 
> The value can confuse users when the effective size quota is zero,
> because a zero effective size quota does not always mean the quotas are
> unset.
> 
> If the quotas are unset, that is, both ms and bytes are zero and no
> quota goal is set, qt_exceeds never increases.  But if the user uses
> the temporal auto-tuning algorithm, the effective size quota becomes
> zero once the goal is [over-]achieved.  In that case the quotas are
> still set, so qt_exceeds keeps increasing once per quota reset
> interval while the goal stays achieved.
> 
> Clarify this on the design document.

Thank you for keep working on this with patience.

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> 
> By the way, I found a thing in the design document that confused me.
> 
>     temporal: More straightforward algorithm. Tries to achieve the goal
>     as fast as possible, using maximum allowed quota, but only for a
>     temporal short time. ---> When the quota is under-achieved, this
>     algorithm keeps tuning quota to a maximum allowed one. Once the
>     quota is [over]-achieved <---, this sets the quota zero. Useful for
>     deterministic control required environments.
> 
> I'm not sure if "goal" was accidentally written as "quota" here.  Would
> this be better?
> 
>     When the goal is under-achieved, this algorithm keeps tuning quota
>     to a maximum allowed one. Once the goal is [over-]achieved, [...]

Good eyes!  Yes, seems it was only mistakenly written in the way.  Please feel
free to send a separate patch or include it into the next version of this
patch, whatever better for you.

> 
> ---
>  Documentation/mm/damon/design.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index d036340dae8a..e083b74d618b 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -863,6 +863,16 @@ scheme's execution.
>    completely tried to be applied.
>  - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
>  
> +``qt_exceeds`` is increased for schemes with set quotas when the quota is found
> +full at a quota reset interval boundary.  While the quotas are unset,
> +``qt_exceeds`` never increased.  However, a zero effective size quota does not
> +always mean the quotas are unset, if the ``temporal`` :ref:`auto-tuning
> +algorithm <damon_design_damos_quotas_auto_tuning>` is used, the effective size
> +quota is set to zero once the goal is [over-]achieved.  Since a set quota of
> +zero effective size is always considered full, ``qt_exceeds`` keeps being
> +increased once per quota reset interval in that case, until the goal is
> +under-achieved again.
> +
>  "A scheme is tried to be applied to a region" means DAMOS core logic determined
>  the region is eligible to apply the scheme's :ref:`action
>  <damon_design_damos_action>`.  The :ref:`access pattern

I think the clarification is better to be added to the 'temporal' quota tuner,
since this happens only when it is used.  Maybe the clarification could also be
shorter.  For example,

'''
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -775,7 +775,9 @@ There are two such tuning algorithms that users can select as they need.
   fast as possible, using maximum allowed quota, but only for a temporal short
   time.  When the quota is under-achieved, this algorithm keeps tuning quota to
   a maximum allowed one.  Once the quota is [over]-achieved, this sets the
-  quota zero.  Useful for deterministic control required environments.
+  quota zero.  Useful for deterministic control required environments.  Note
+  that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
+  <damon_design_damos_stat>` will keep increasing in the case.

 The goal can be specified with five parameters, namely ``target_metric``,
 ``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
'''

What do you think, Liew?


Thanks,
SJ

[...]
