Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8220311
	for <damon@lists.linux.dev>; Fri, 20 Oct 2023 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlgDo8lI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578F7C433C7;
	Fri, 20 Oct 2023 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697823082;
	bh=oljrLmjEHyjWNMK611/7HLPN620cBkukdqqw9gAc6OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlgDo8lImAgwGfJ0VCESmLVYH/IR9aoCqYKgaLCh2qXYogJJQ7yy0bIhWU/EnCsuf
	 5SV+I3PF2qpFnJ9FHqYwYrUknXyMzNfLO0/0bm5lKc2x365MF5pSpthEzH4M3PTnr7
	 4H6TIeaiDG7zqV4TbB5VbL94lNjRzmveTk8BHJ2zZ631LiwVtvPIv7c4e1RG2zS7Pd
	 JY+lyUXOTcfl3XA+8yjFEvXebDKueNuOYguyXoFOtFHCXEe7sBQR3P52xcPIm+AAik
	 LOaw00oqbSHEzSOBTbX+dj8OytQ2HdgKFg+zjs8+tP5c7Bfw8lSHkXTCMZunwkLmks
	 F3tyWiJ25SzFw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	acsjakub@amazon.de
Subject: Re: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date: Fri, 20 Oct 2023 17:31:20 +0000
Message-Id: <20231020173120.64224-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020171901.63994-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Oct 2023 17:19:01 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 19 Oct 2023 19:49:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > The maximum nr_accesses of given DAMON context can be calculated by
> > dividing the aggregation interval by the sampling interval.  Some logics
> > in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
> > shouldn't be zero.  Such case is avoided since DAMON avoids setting the
> > agregation interval as samller than the sampling interval.  However,
> > since nr_accesses is unsigned int while the intervals are unsigned long,
> > the maximum nr_accesses could be zero while casting.
> 
> Actually, the issue was reported by Jakub, and I didn't add 'Reported-by:' tags
> for him.  I sure Andrew could add that on his own, but I want to minimize
> Andrew's load, so will send v2 of this patchset.  Andrew, please let me know if
> that doesn't help but only increasing your load.

So sent the second version[1] with the
"Reported-by: akub Acs <acsjakub@amazon.de>" line, but then I noticed the patch
is already added to mm queue[2].  Somehow the notification mails delivered bit
later than usual.

Sorry for making this noise, Andrew.  Please add
"Reported-by: akub Acs <acsjakub@amazon.de>" to already added patches, or
replace those with the v2 if possible.  Also, please let me know if there's
anything I could help.

[1] https://lore.kernel.org/damon/20231020172317.64192-1-sj@kernel.org/
[2] https://lore.kernel.org/mm-commits/20231020171847.C6EEAC433C7@smtp.kernel.org/


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
