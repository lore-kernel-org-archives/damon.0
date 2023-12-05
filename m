Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8D692BF
	for <damon@lists.linux.dev>; Tue,  5 Dec 2023 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpMPJv4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEB9C433C7;
	Tue,  5 Dec 2023 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796989;
	bh=pU9M00dkHKU1TS7CBL1inocdlITXmGP7gY/XTaLHoyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpMPJv4XEKXQyQYQR6FkqXiXv1mDf/eSYeILTXcboW3xOS8bPLZL+N2huZtkLCQEL
	 0OtFsxwzAd6kdDSsD7WpB6tttxUtHcP0gxlldD7BJAy6XYXjMH4NSuRVOLFiD8ViIy
	 rWHgLBD2A0HITc0L8KBBIrpwPPqNjiN6VBG8xMYo0PWwMyIboOHek+V2R7b3GUSmdV
	 autTFncMlnDQxky1Dx0r5f3dzmt4BusJ8adkxkZBjU60FQGxSve3/r7MfAq/fQFb18
	 eYlvLHBXmriqKTncHF0mpyF1m4N3EZQG6v7p8F46z0Eip5rHX+UGN6gOo/6LwvQAcW
	 Zv1JAF3oYGeZw==
From: SeongJae Park <sj@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/damon: export DAMON symbols and add sample loadable modules
Date: Tue,  5 Dec 2023 17:23:07 +0000
Message-Id: <20231205172307.2310-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZW6xTyyl0qvcqi3O@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 2023-12-04T21:12:47-08:00 Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Dec 05, 2023 at 02:28:55AM +0000, SeongJae Park wrote:
> > DAMON cannot be used from loadable modules since it is not exporting its
> > symbols.
> 
> And that is a good thing.  We should absolutely not allow random modules
> probing MM internals.

I agree.

> What you posted here is basically just adding hooks without even real
> in-kernel users.

I was thinking someone might be able to think even the sample module as real
usage since there was actually some questions about it from real users.  That
said, those were more like questions than strong requests, so I still think
this change is somewhat better to be made for at least some folks, but I also
agree that this wouldn't be not really essential for everyone, and could be
only long term maintenance threat.

I personally don't have strong opinion, and thank you for raising your concern.
I will hold this patchset unless someone request this change again with good
rationale.

Btw, I know there were many concerns about unnecessarily exporting symbols, but
do we have a formal guideline or documentation about the requirements for
exporting symbols in sepcific subsystem?  I was hoping to have such one so that
I could provide better answer to DAMON's loadable module support questions, but
I was unable to find such one with my poor searching skill.  This reply could
be used for the purpose meanwhile, though, so appreciate again. :)


Thanks,
SJ
