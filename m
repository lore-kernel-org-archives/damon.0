Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BFA3AE1B4
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668178; cv=none; b=J7lde1nZnKEfpn4pbJjRaRR1cOUKavgRPFLNOP2WdsorkLSljdbipTznWi/OHG6WUQiuZm353rbD4nO1b/b74elBmvDSuCiqn4jrkpDGT5TskVj2PxsrZZi7loq2DnF0SbPhiNcnj3zNFYOwik7mff8hRIT9GWe6mKwueB3U0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668178; c=relaxed/simple;
	bh=7vwGVA1CH5yyx9BHzVr7wZ/CTvFXV0JWKiQicg87sfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txzC5ZsQxPv4mBjRLj1UsRx/EqeqzK1BZDuV/dPwma9aTxOEU83KP2TYyUSetCFSZRk+LT2DTfjBVtq9RBAc8i5pJG9JdQGIrTgwHP7el31hi6Oa+aLsGKeirNZxLlpDOl68YeeSiCrZU79orpBYwGMgooVCfsGkz3bqT/eZ4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ2YLwTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ2YLwTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9BC1F000FF;
	Tue, 29 Sep 2026 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668177;
	bh=VPht9WNWFS86BiIEP+h7UzzhDcQB+WCi6crydl5nEfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQ2YLwTaDIxcBYOoI4mOPIWSdq18GRFv0q0uZuqdTDWbALLjOcgVWdg3c+RKhLFR8
	 KGLhxQvQuq8Nzu3u+DFIbrXHCSvk1EaAqClpilK/dmOLZwyu6v4DXjlgXBgaubL2nJ
	 vAldv3pr3TMd7LdzLwUC1LrcyLMrktiAbAnKsmHOjU7KVqXVnRPJQ0pA4luMYobMwF
	 Wrw1QVcN3ce8xT3qSXPRoWsvYbwX5aTdiuEn8B89wfCXPMZte0CTvGeIklunC5oP8c
	 wBERpyKX3RfOUBG3KNIpvxaB/tf8hZEsIulChpc24166BQ0C2V2/tXogOZDHkd5y6f
	 gIPiqUKxX1Uxw==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Tue, 29 Sep 2026 00:49:32 -0700
Message-ID: <20260929074932.40176-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjrJxoKy3AdXHiCSEGZyDwSqDJa4riO5FZeQX9uZKfjgmg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 20:02:43 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> > Thank you for sharing your use case and question!
> 
> Thank you for your quick response and your answer/comments.
> 
> We already had memory tiering implemented at hardware level 5-7 years
> ago with Intel's Optane PEM when configured in Memory Mode.
> Now we do the same thing at Linux level :-)

Interesting!

> I'm new at DAMON/DAMOS, there are lots of new tunables to me.

Indeed there are.  I'd recommend starting with existing DAMON-based memory
tiering solutions including SK Hynix HMSDK and my auto-tune based memory
tiering script [1] and ask questions to the authors.

> 
> > The example memory tiering script [1] uses 4% as intervals goal.  Is there a
> > reason to use 97% as the goal instead?
> 
> Oohhh... I moved to 5%.

I understand you mean 4%?

> 
> > Is the above node_mum_used_bp what you really want?  That means you want to
> > promote hot pages from node 2 to node 0, until the node 0 memory utilization
> > becomes 99.7%.  That overlaps with the demotion goal (50% free memory of node
> > 0) quite a lot.  I'd suggest smaller overlap, say, 50.3%, to keep healthy
> > circulation of hot/cold pages while not consuming too much resource under
> > stabilized access pattern.
> 
> > DAMOS quota auto-tuning supports two tuner algorithms [2], consistent and
> > temporal.  As the documentation [2] explains, 'consistent' tuner assumes it
> > should keep applying the action in a level to keep the goal achieved.  In this
> > case, for example, the demotion scheme assumes there will be continued
> > promotion and therefore it keeps demoting.  If there is no appropriate
> > promotion, it could result in demoting more than expected amount.
> 
> So let me firstly understand what I really want to test :-)

Sure, and please feel free to ask any question in any ways.  If you prefer to,
you could also ask questions privately to me or use DAMON Beer/Coffee/Tea Chat
series [2].

[1] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh
[2] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

[...]
