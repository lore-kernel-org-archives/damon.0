Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD57E6
	for <damon@lists.linux.dev>; Wed, 30 Aug 2023 01:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38016C433C8;
	Wed, 30 Aug 2023 01:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693359383;
	bh=0T61JhZvBgtGqTFCxU7ee9dwkyQB1gfq2ay5n+uX9HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBU3UyEDn9KBvrJspSdcvxZ/i/yQRLuIi/gAfUUsMXID2Az4PxAo4rK04tzWzyp+u
	 Se7JZy/rdzOxMjePY1C0mZ8gLkZxYrMNEtmCNpU9cI6TVtk3eu7M7rdnetGzvuExJW
	 llTxt0gPw/5049P/a7+dtBma2qaEMPSXXVSa/KuugzrUzj1wiZGrLsSAsyGj6ZbPCR
	 tzsnvvp1wIr2KYpsf0w6Rv0LGAEmGksaKp2U+D5gjWhSAFwU3PKh+PlRc5VLSAMAc/
	 pcWlX4mM4kcnr/zdvtUh8b974pDRnmQbtvDfDrhhuRiLqs7m7oB/BjmnthV8Kl+Gew
	 lnEKj6Hmd59zA==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: add a tracepoint for damos apply target regions
Date: Wed, 30 Aug 2023 01:36:21 +0000
Message-Id: <20230830013621.46216-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829191629.25c5f0e2@rorschach.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven,

On Tue, 29 Aug 2023 19:16:29 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 27 Aug 2023 00:40:45 +0000
> SeongJae Park <sj@kernel.org> wrote:
> 
> > +	TP_STRUCT__entry(
> > +		__field(unsigned int, context_idx)
> 
> 4 bytes
> 
> > +		__field(unsigned int, scheme_idx)
> 
> 4 bytes
> 
> > +		__field(unsigned long, target_idx)
> 
> 8 bytes
> 
> > +		__field(unsigned int, nr_regions)
> 
> 4 bytes
> 
> > +		__field(unsigned long, start)
> 
> This is going to cause a 4 byte hole. I would move nr_regions after end
> so that it stays properly aligned.

That makes sense, thank you for letting me know this!  I will do so in the next
spin.


Thanks,
SJ

> 
> -- Steve
> 
> 
> 
> > +		__field(unsigned long, end)
> > +		__field(unsigned int, nr_accesses)
> > +		__field(unsigned int, age)
> > +	),
> > +
> 
