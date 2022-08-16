Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBB6AD0
	for <damon@lists.linux.dev>; Tue, 16 Aug 2022 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975F9C433D6;
	Tue, 16 Aug 2022 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660683032;
	bh=fnwZMnqtegaClcWZTRjTTaochRsXSo1ahe6ca/cHXSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/+8Wo5DnV6OdtRCz9KqAa73uLQ5tZ6S8q7HzFNfRDDfaRtJzVzVDhxVqf7LBYYip
	 Xq5qU/ArGI/E9uGVUhI6T4BnGL8jHOxCdJmrS5FxqSd4QDiz+lM17gE6WOgTgrpWDT
	 TKoS158bDzUWy+5ZN6am1LLcTlLwSXhCppqS23yicyNNuKS3VPo+tQEnoicPY0Kz8S
	 qjcx6dzmelHe1qjwsgkdBAYacyytxos8FYC3vZ6X0qWDaFRFlyITyjPJeMnOf/MiYn
	 KSvJRFOjG01DBpK5MFucO6uy+U0JTRWdXY7Kmu0JH0Vx/mMaaBTeiRaSw7M0BC1c4C
	 NkWifW6umgJUw==
From: SeongJae Park <sj@kernel.org>
To: Gautam Menghani <gautammenghani201@gmail.com>
Cc: damon@lists.linux.dev
Subject: Re: Question about hugetlbfs tests
Date: Tue, 16 Aug 2022 20:50:30 +0000
Message-Id: <20220816205030.96988-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YvvLo7wDBA6qL0L9@biggie>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gautam,

On Tue, 16 Aug 2022 22:23:55 +0530 Gautam Menghani <gautammenghani201@gmail.com> wrote:

> Hi,
> 
> I have been looking to understand the TODO mentioned in the damon-tests repo
> on github here: https://github.com/awslabs/damon-tests/tree/master/corr
> 
> The TODO in corr/TODO says "Test hugetlbfs". I want to understand what is
> required in this.

Thank you very much for showing your interest in the TODO item!

> Do we need a test that writes data to hugepages and reads it back to check if
> read/write is successful?
> Or do we need a hugepage scheme that is applied on masim, which we then check
> to ensure hugepages were used?

I'd prefer this option.  That is, making 'masim' to support use of hugetlbfs
and checking if DAMON still monitors the access pattern well, maybe by
extending masim-record test[1].

> Or is something else required?
> Please advise on this.

No problem, hope the above answer be some help.  If there is anything unclear
or I'm wrong, please let me know.

And, now I remember that you already sent me this question via github[2], and I
was totally missing that.  Please forgive my dullness.  I was in vacation at
that time, so I wanted to answer as soon as return from vacation, but I was
forgetting till now.  Sorry again.

[1] https://github.com/awslabs/damon-tests/blob/master/corr/tests/masim-record.sh
[2] https://github.com/awslabs/damon-tests/issues/1


Thanks,
SJ

> 
> Thanks,
> Gautam
