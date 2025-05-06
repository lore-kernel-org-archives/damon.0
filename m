Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4F2857F9;
	Tue,  6 May 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553377; cv=none; b=EPXNvL2P+Al8cSz+kZQMGd4Aat6ORQXixUUc9jfpiMdM3lHrryg0E1ef0pLJNBmQwaBQg5urCY0YrnTENq4BdJU7mbgGxPrdMGmBdw7BnAZp1PKMofGrz2IYPcjlThEwyceNJttzdAV94TJrab31Rt3bsc1QXKV0LtL0r6ubIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553377; c=relaxed/simple;
	bh=kcs3j6yJnBRC8+fAc22dByWPJhIT8E1SWYkXEc7r4A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVUJPCmTrR22wCa1AMFMw2DBaZdtpW0EopQb4MiQ453yn9IlrTctANP/EnOzhpQJ1MHPZXJ78701hqFubz2KzZYUH7OEOQQKQLxBLLH8IJ5wkAko08ymsKQII6lXrQsn3PaAhLTkA7xjPE1TrNFZe/wAfe/NyRHJhNG11r0BYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLbIGheh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLbIGheh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDC7C4CEEB;
	Tue,  6 May 2025 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746553376;
	bh=kcs3j6yJnBRC8+fAc22dByWPJhIT8E1SWYkXEc7r4A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLbIGhehmAHGeqTiUoK+v6YfKvcPJdn6SkTh7NTs0iNufs4D0u5PpQSEglntmWi5K
	 rgaymThaacp4GCfbQPknNEo+K0LTSMSq6O2wuFvVGK8XxfFAla6NizwOpVXKFfs633
	 q73IRYWrSpLn83OlhiRpB9MRnVLUUiLumM1pJCvFNsamY+zmNEN2VM5vMA2k6sYZOt
	 RUU81D6svIImwR5o22b43L1COoRfZhRuVVqGTNiVBk9Z0ljjuXdTtJg5YfWluvm6PT
	 AIBklamo4EACaaYVeL8CfH90EVma7bqBFdsRYaEGeAlYdocpUiA8vFjMsRJ4pUBAXg
	 +pGijXL1DXhgg==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	"Thushara.M.S" <thusharms@gmail.com>,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev,
	skhan@linuxfoundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm/damon/design: Fix spelling mistake
Date: Tue,  6 May 2025 10:42:52 -0700
Message-Id: <20250506174253.57341-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87zffpx5oz.fsf@trenco.lwn.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 06 May 2025 06:51:56 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> "Thushara.M.S" <thusharms@gmail.com> writes:
> 
> > The word accuracy was misspelled as "accruracy".
> >
> > Signed-off-by: Thushara.M.S <thusharms@gmail.com>
> > ---
> >  Documentation/mm/damon/design.rst | 2 +-
[...]
> 
> Applied, thanks.

Thank you Jon.  But Andrew already picked this up on mm tree.  I have no strong
opinion but I'd slightly prefer letting this go via mm tree[1].

[1] https://lore.kernel.org/20250505191435.61036-1-sj@kernel.org


Thanks,
SJ

[...]
