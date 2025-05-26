Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E113AD38
	for <damon@lists.linux.dev>; Mon, 26 May 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748282963; cv=none; b=TjNz6rpvl5JZBuJNRwj+PwOs49olmwNoTIkD3aUZjYnGGoqLmxmAlTxN7ugwr0OE0i1C+PaeQfXl2EAj9GbyEk9Ic0AObH2PFfdnDfADCdwTPhwWd9ZktY0yAYOTYhUQ1DFCZMGwyHIITv+8xvNk+S9Lw82kPmmgeU391InItyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748282963; c=relaxed/simple;
	bh=xRX/8MXmrL3nVoDioj2GyHhqwrh89fHDd+r1rOKYhtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ss293uiQcFqvp9eIttuqTBSKRDqpXUqubI0BfttW8Es7OlLzJzdGL8hp1ujc9EqWaFYFD2TYoB/I/RgOOU5PCsZF0D+auSnY3xX9Jbp7JlDS/OYFH9Awh+8V9hfqAZ/0mH3tVzCbwmI04DpL0rV+EniPTOLWE+0RCewW/87F7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkhVDG/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkhVDG/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F5CC4CEED;
	Mon, 26 May 2025 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748282963;
	bh=xRX/8MXmrL3nVoDioj2GyHhqwrh89fHDd+r1rOKYhtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkhVDG/H49I/Zd3A1pTPKaUG0EzCe6JKYYNC4esD5WUg+Ryh2lsYcyYnVL2WJLYlx
	 qvPPOKloy07rDH9skdL/D19FOH0KnSRmR2HHxIcQsjZZ1WqOoW4rvI1kCthMpXysGp
	 pJFNMM6L3YamLV3Y6GT9qXYszOhdU6nzeutHlzOHa0cYRr0bRBTYVxS3OpyggwLQk8
	 5axwXEjQOVj0Bm4+R4Vxwws+48VpiK2Elo/ZIxBWzJmgLJwqbXD49fShZKWJ89iFkR
	 J5c99qJemUEDvA5zATW4oHIBx2hKclHGEMoh+9VHC2qvGtM9aTZ76qDcPKNs6U+ZXA
	 uA00PmzxDAT0w==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: rename primitives to operations
Date: Mon, 26 May 2025 11:09:21 -0700
Message-Id: <20250526180921.2932-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87o6vfj3bv.fsf@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 May 2025 14:25:40 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SeongJae,
> 
> On Sat, May 24 2025 at 09:29:10 AM -0700, SeongJae Park wrote:
[...]
> >
> > Could you please revise as abovely suggested and resend?
> 
> I've sent a v2 to the current thread,

I think it is more common to send new versions of a patch as a new thread,
rather than as a reply to an old version.  Please do so from next time, for a
consistency.

> many thanks for your review and
> suggestions!  Please let me know if further adjustments are needed.

David gave us good point[1] to think about the title.  I don't think that's a
strict blocker, but also no reason to rush on this.  So let's take a bit more
time for the discussion, unless this is urgent for you.

[1] https://lore.kernel.org/dc5391f3-6e0a-4e6a-b319-0c602af29202@redhat.com


Thanks,
SJ

[...]
