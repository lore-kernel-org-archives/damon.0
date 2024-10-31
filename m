Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81569126BFC;
	Thu, 31 Oct 2024 05:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730352076; cv=none; b=cfyTfbhGJusm8WesRJ6BXKlhZcJ/dnToXPfPu2S1Nc/vdOA9YrRxB8mmHC6jVdsKpTJEH+orLcgtjEyvfwaEy0k2e3qAqjGWa25ID9k03zHVREGZug1/xkvPIxu9NU0hi3bHoDByLoHRjRoldojQvPUs2HoKZJwFz4AKH8AYCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730352076; c=relaxed/simple;
	bh=oKvzKHSIFV/9a64ZyFXNr4nz7kAn5pfeSQBzNS7WmCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pd5nxHFwKkm7g8qhawsFvYuE2SuoIU6OY6OoImMJn3LKZW5mVnZbVoiQLiIeUS2/yAzrlxvsXbv15yx4+C6WG56wVyeszMXIF4H78rswMEjNBub36biIwxxw7vNkohkEhZQ+q0Iluj+XwJvyI8AEZ23NpB8rW36mRIjfWXyoKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caiZOHyS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caiZOHyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE78C4CEC3;
	Thu, 31 Oct 2024 05:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730352076;
	bh=oKvzKHSIFV/9a64ZyFXNr4nz7kAn5pfeSQBzNS7WmCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caiZOHyS42Gmy/N5hIh3F5TJLHa7uuNoOGhtp8aCIsFwS4zu/CDMaOaZagD+I791m
	 umBpbe/HVeTlgmX9sTjx40wXeASJem12UVa22xfvhINX4WH+LdXv3DchJhTMGTpuCJ
	 kUsy98+o/QOcdK9jOqEHe0vruZpJxUpPx5bo7OaRLWft8meWBp6b9+3JRxmVKt6jxZ
	 rphERfYhjCK+GyYjGcEX0Vh5CmxX+KgxdBEhSccOJVNblIInleRdzznjPmSWSG4N/b
	 sH596P1e521UefZSXg4HSDvW6KGQc3pKdD/OXEgnWt8dOCr134Gc3CrXDl0AG/i3r0
	 ZqPWmhX1Igq5g==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: avoid overflow in damon_feed_loop_next_input()
Date: Wed, 30 Oct 2024 22:21:13 -0700
Message-Id: <20241031052113.66155-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <4dd8ba2c-e994-417d-baa9-47e40b50c1b4@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Guenter,

On Wed, 30 Oct 2024 21:18:51 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Sep 05, 2024 at 10:24:05AM -0700, SeongJae Park wrote:
> > damon_feed_loop_next_input() is fragile to overflows.  Rewrite code to
> > avoid overflows.  This is not yet well tested on 32bit archs.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net
> > Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> > As mentioned on the commit message, this is not yet sufficiently tested
> > on 32bit machines.  That's why this is RFC.
> 
> Is that patch going anywhere ? I have been testing it on a lot of 32-bit architectures,
> and I do not see any failures.

Thank you for this nice reminder with the grateful test results, Guenter!

I was recently cleaning up the code and commit message, and testing on my own
with test setup.  I should confess that it took more than I expected in the
last RFC posting.  Sorry for the delay, and thank you for your patience.

I believe the patch is now in good form, but I was waiting just a couple of
more days before posting it, for a case that I find any mistake on it.  So
unless I find something wrong on the patch by Tomorrow morning (Pacific Time),
I will post it after dropping the RFC tag.

The current version of the patch to be posted is available at my patches
queue[1].  Please let me know if you find anything suspicious on it.

Thank you again for your patience and nice reminder!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/tree/patches/next/mm-damon-core-avoid-overflow-in-damon_feed_loop_next.patch?id=fb13d053bfdd5249bebdd1c253417f97cd41471e


Thanks,
SJ

> 
> Guenter
