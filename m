Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2622A4E1;
	Fri, 28 Aug 2026 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787884280; cv=none; b=ZW4JQimpmrdTEGXTCx5OY8D8oOoj+j/jVfbzaqhdw9FgKa5T3Hrkp58fkzz61WfBJy9F9spkvvCIV7SV8cly0gMbbnZ4vCDsS5NRHf34/qrrO0fbZIw5MQ9ud0tryTfuejHSGB7+T83FZ44zIcn+YUcFtT7N9al8JL8N6upXam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787884280; c=relaxed/simple;
	bh=xlOQdrBprBokycbVMKf803rz99E/fbIO9EHgKbCcaso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gntib1Yi9oBbyhjgKYK0MWY2Kh4fUGEF1invr2EAdtYclRDBAKOUVpyWuP9cA6MsbBSDhfbzHWonhRKBG8QH9lyI6BniFOgnFVM3F9UHIlwqPXq5Z6HtXbe60naZ6azEz/Bu31Toj3Wtwgn/bLZ8wUOWXnIbqdbZoCtZYqdElZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMyJlcCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMyJlcCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276BA1F000E9;
	Fri, 28 Aug 2026 02:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787884279;
	bh=uY6X52+CE/BlmGNPEenqX1diWJOnne8XyrPMIYHRTJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JMyJlcCZZCadNT68arE+NuHVNLfJoljWjgnNaTYHnUoH/ikEspa/3sSgkQ51iPMMW
	 juqRr12rV/tPIlwcIV/DwlC4d8RCzEDCpf5HXShxfHbHKRtcYVmQkF8lSUR+HReclr
	 Xf5Tp6mkQgk74UOlJ7RzdGge0V/pPx/fZ8Xz6+7n5sXW4nI36uSnKDIVsGKu9P/gr7
	 Nqw8qEyf9FqFBblT4Fgkiy9M4B+wqR5aoKYZTZ3IAgmlWJXB20x07cR4TuhgmswU3N
	 95skI+PX7BMU/kZj/YkBPeweAEoArbpFVJF/UlmTsA1ytt/N59Am5s/1Uv1u8GvRpL
	 apDqc7BZ6L4Fg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Thu, 27 Aug 2026 19:31:11 -0700
Message-ID: <20260828023112.122652-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828015429.131338-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 09:54:29 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Thu, 27 Aug 2026 17:40:48 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Fri, 28 Aug 2026 02:08:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > > While your approach works, I am curious, why should the cursor be reset
> > > every time the function returns false (does not skip)?
> > 
> > It doesn't.  It resets charge_{target,addr}_from only once after the regions to
> > skip are all skipped.  Am I missing something?
> 
> You are right.

Thank you for confirming.

> 
> My concern was that the current
> 'return false == reset charge_{target, addr}_from' might be a bit hard
> to understand.  However, I realize that my change was quite significant.
> 
> To make the existing logic clearer for future readers, I think adding a
> brief comment would be helpful.

Makes sense to me.

> For example:
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2368,6 +2368,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
>                         damon_split_region_at(t, r, sz_to_skip);
>                         return true;
>                 }
> +               /*
> +                * Reset the charge_{target,addr}_from so that the remaining
> +                * regions in this/next target can be processed normally.  If
> +                * the quota becomes full later during the walk,
> +                * damos_apply_scheme() will update the
> +                * charge_{target,addr}_from to the correct position.
> +                * Otherwise, it implies that all applicable regions in this
> +                * target have been processed.
> +                */
>                 quota->charge_target_from = NULL;
>                 quota->charge_addr_from = 0;
>         }
> '''
> 
> If this is not necessary or redundant, I am perfectly fine with dropping
> it and just applying your minimal fix for the last-region issue in the
> next revision.

I'd suggest to separate the minimal fix and readability improvement.  Could you
please post the minimal fix first, with Cc: stable@?  After it is done, we
could revisit this readability improvement.


Thanks,
SJ

[...]
