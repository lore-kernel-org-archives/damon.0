Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC211D6DB6
	for <damon@lists.linux.dev>; Fri,  1 Aug 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067044; cv=none; b=PcuCeuElEse5SR7PklMv51qEWCNgqsw3d7VWlhleOhP8PtW3IywpCnjCSc0cVwWHGgTu99LU+fCbpFSc8Aa2PnwppkecsuGx6oYQRafi5e8lue9uSNu+AvJRdpARzkjnG9qycBHqE/h1BSYnFKQ+Z/V4ntGJKMbWBglg3lAvRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067044; c=relaxed/simple;
	bh=yCsTvSZ2uYa/j4iCTrOUQDgQlndbnppi7HrfEDho8dM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKbBIfskTGFmvKWlSJN+aGNxfHmVgvnq4Xlp/hduVIHHcg0V/wtkGqFUWmBiaAJo0eXCtgXUhR9fp/IFsDoY0u+eNgCoGkHiekSsQGCAi+76YDEDR0GOtgbNmuXqkxw7Tc4PPEmgaXIuVD5T8e/dHGREEb/oAcr+1malr5Eculo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qalISDDP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qalISDDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E70C4CEE7;
	Fri,  1 Aug 2025 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754067043;
	bh=yCsTvSZ2uYa/j4iCTrOUQDgQlndbnppi7HrfEDho8dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qalISDDP6/iAPrr19SGlBNPXQmhlSFAnk+oJd3w6ppesOlfJIP9wbLf10p2BTWmne
	 bUbzzB4ZsKmmAPEXeZozP8SEXMlJFzhZFYEcMK/3CxbN1QuWVS5faULBIt1uYVVLjy
	 d2+VaUPhhmmR+LGFeTSTQmmL0mk85TbsvHvYUsYrXTtXgA0YRMyFXe3PzJWJgCoqDI
	 sgwhDAE1aBo/JoTmG+fzAso59WIKpUy2u+M/hfJfDRJiDKL/RAxh6DSqKo0x3p5ocS
	 AS63BqAs13B+NHY7VCrdOkwrNFrlECoIFybYqww57rIXX4WcflVH1FGaJIcp8jT5Ze
	 LxxY2KZwNI8sQ==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Date: Fri,  1 Aug 2025 09:50:41 -0700
Message-Id: <20250801165041.8350-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMHamJ0m8Nq1L-4WNz4OwLaLVQdwV=X4_ZpK7Vd+RSTHVA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hi, Honggyu
> 
> On Fri, Aug 1, 2025 at 8:35 PM Honggyu Kim <honggyu.kim@sk.com> wrote:
> >
> > Hi Sang-Heon and SeongJae,
> >
> > On 8/1/2025 2:58 AM, SeongJae Park wrote:
> > > Hello Sang-Heon,
> > >
> > > On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> > >
> > >> Nowadays, damos operation actions support more various operation set.
> > >> But comments(also, generated documentation) doesn't updated.
> > >> So, fix the comments with current support status.
[...]
> > >> diff --git a/include/linux/damon.h b/include/linux/damon.h
[...]
> > >>    * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLNEED.
> > >>    * @DAMOS_COLD:              Call ``madvise()`` for the region with MADV_COLD.
> > >> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEOUT.
> > >> + * @DAMOS_PAGEOUT:   Reclaim the region.
> > >
> > > Nice!
> >
> > But doesn't it make confusion about whether this pages out to disk or does
> > demotion to the lower tier memory?  It's because PAGEOUT action doesn't do
> > demotion, but it looks "reclaim" includes pageout and demotion together in my
> > understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.

To my understanding, DAMOS_PAGEOUT can also do demotion when demotion_enabled
is set.  Am I missing something?

> 
> My intention was just to synchronize with the Design documentation.
> 
> So how about changing the description to `Page out the region`, Would
> this be also confusing?
> I feel like it would be clearer than using word "reclaim"

In my opinion, "reclaim" is good.


Thanks,
SJ

[...]
