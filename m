Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DE7E
	for <damon@lists.linux.dev>; Tue,  1 Aug 2023 01:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DDEC433C8;
	Tue,  1 Aug 2023 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690853239;
	bh=KWIHlUVq7RPoPIKoVzh0uWwNJse5bLl7z8vrM8catMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7b0rr8NvKmQ9NDsv5DtBNC2+bvGCI5rXPEo52cH1G9kbxkYf0bli+EPpwHMUqSiz
	 FqBQJW6KIxJcsWr3UOXcqWpLsqRqgqm+JSxjDmhhdFa2jr+2EdmufSjWOM7NYY5MST
	 awW7OyNfS4HhdV71Uf46fWWW1RsgH0saP9Mv1K9t6YxTe1pCUFJTP98uRReSSV9eRY
	 +Vq32ZVxPSbaQxa9kREllXZ5mWPyl98js34I14vz8UMHC9i1wdHMc+f/zXH8cqto2o
	 XWCwcKfDu9++KuIblz/mfX3Qid4Q8vOhvZVDWSKtedskym9YS6tItdvHmdSAqvq1aI
	 hq4DI6JTkq3ZA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Tue,  1 Aug 2023 01:27:17 +0000
Message-Id: <20230801012718.6312-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801012126.6249-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Aug 2023 01:21:26 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello community,
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
> I'm gonna be out of office from mid of August to end of OSSummit Euro 2023[1],
> partly for preparation of my OSSummit Euro talk[2].  For the reason, I will not
> be able to schedule and attend the DAMON beer/coffee/tea meeting during the
> time.  I will still be reachable, though I might be less responsive during the
> period.

FYI, we will have one more meeting before that, on 2023-08-08.  And the regular
series will restart from 2023-09-26.  Updated the google doc.

> 
> Also, looking forward to meet some of you who will attend the conference! :)

And, hopefully we can have a small but physical version of Beer/Coffee/Tea
meeting there!  Feel free to ask me for a beer if you find me ;)


Thanks,
SJ

> 
> [1] https://events.linuxfoundation.org/open-source-summit-europe/
> [2] https://sched.co/1OGf9
> 
> 
> Thanks,
> SJ
