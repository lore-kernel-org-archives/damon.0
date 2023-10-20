Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DD208C1
	for <damon@lists.linux.dev>; Fri, 20 Oct 2023 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLZAT9s/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFADC433C9;
	Fri, 20 Oct 2023 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697824963;
	bh=0pd8oyJr8Z/2Zw3X/z3kmWzu508WFnpM4EOZnOcv7t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLZAT9s/4N6yBnQlsvKopCnL7ulX+4z0p8pH/yEGkOfPF7iqzGCYYJokZa3qR1pup
	 nEsz2gGLNTWvMxLKPQC9uMF0Lcch/uTkeuGzfqfYxiV8snTBoIthW0uIZDS3qrm2nI
	 c4i5fy3Y/tWT+0Sc1m254hXw3N1suzwa2k+ETC0FZ1iwwR9UEHyVN6vJffrbaAW6/V
	 C2ACzK+zKD+62atm7qzQZVzbD7WhGMOLyfO7CrR+8x86rNCm82lD++1isx6cQKnM2/
	 YB2ZEt8w3lBahnyuMmCohlLy4zqsGVX5Q6AoX/ibOojKyiqMZN0sBhXYCX+4YUNTQ3
	 Y9dTbzG4UpcyQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	acsjakub@amazon.de
Subject: Re: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date: Fri, 20 Oct 2023 18:02:42 +0000
Message-Id: <20231020180242.64276-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020103036.027282d16aaf56498230cc12@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Oct 2023 10:30:36 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 20 Oct 2023 17:19:01 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Thu, 19 Oct 2023 19:49:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > The maximum nr_accesses of given DAMON context can be calculated by
> > > dividing the aggregation interval by the sampling interval.  Some logics
> > > in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
> > > shouldn't be zero.  Such case is avoided since DAMON avoids setting the
> > > agregation interval as samller than the sampling interval.  However,
> > > since nr_accesses is unsigned int while the intervals are unsigned long,
> > > the maximum nr_accesses could be zero while casting.
> > 
> > Actually, the issue was reported by Jakub, and I didn't add 'Reported-by:' tags
> > for him.  I sure Andrew could add that on his own, but I want to minimize
> > Andrew's load, so will send v2 of this patchset.  Andrew, please let me know if
> > that doesn't help but only increasing your load.
> 
> Editing the changelogs is far quicker than updating a patch series ;)
> 
> btw, it's now conventional to add a link to the reporter's report.  The
> new "Closes:" tag, immediately after the Reported-by:.  But it's not a
> big deal.

Surely it is.  And in this case, the report was made privately, so no available
link.  I should have mentioned this early, sorry.  Anyway, thank you for your
help, Andrew :)


Thanks,
SJ
