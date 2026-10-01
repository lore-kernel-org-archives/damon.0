Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4004E3786
	for <damon@lists.linux.dev>; Thu,  1 Oct 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850379; cv=none; b=HyDf6HeaAtxsmjjFW/0d+Z+3Afbt6n7tamPKUuY/wNHWPlIUSU9hYDsOZV9YqoevBtV1ljyN+AA3m2D1swntE3oQ6mbxINzg7AWYLzrNb8nex6YiEJbteqm4NI1eZ8hXcMY4joyJ+FQfZq2a+anLcGYFFLtAm/UEGRDrsnDXxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850379; c=relaxed/simple;
	bh=IzxcrXH13LV3igFK8WTnKWRkXAjt3kOOUrsjt7EN/xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdVDR1E6Bn2x1y/jxtxbGcYzCJ6X58hj5ptm3vINJbqp+XbHT++/2Yp5l+goT53CT93HbwZcbwJAEr1fs9zmsSKlOSgBayo7Ea5Fv9LHvyHoqHC+lEU1xlO7NQH13vRGusQtJB2px7qy8x1LyOiGHUIkdZLVowLc2P+fXTphP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na7763rM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na7763rM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BBA1F000FF;
	Thu,  1 Oct 2026 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790850373;
	bh=KV07UhrywjYghGWopWB6K0l1lGjSWXZiHMUS/pBpDpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=na7763rMGaWsiybuLOU1LRfojVFT5Mekb1wVhfGprvVPKkxH7OqNj2iWzSDaNmvgO
	 kT/MXqimmQYunb5HlgEJyORjSaST4662rI/WZ1QaYIdoM/XaPXFIpAw+xOsm93c2UA
	 hQSiiA5/24/g4+DVOpv8R7BK+VYC6JzrpCQyrOB/9GNgp/GbwVbW1HPf0oVh6O/2ST
	 BVl5OPVoR+2YrLEik+6/6CnEv3zaZiXpSydxAcumXornDGYVDFW/a08dCIAmyChvS5
	 z7BpHdhoPl9xMfUgtJYHL9tDoIG3KKCyREQxctAPzAUH51KGIIgfHuas0m3bANhQtL
	 f2+BHZEP+Hv7A==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Thu,  1 Oct 2026 03:26:08 -0700
Message-ID: <20261001102608.46491-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjpkSvWFu1018-wmOn963u8kjrzTWgG=NERQ3RudG1di3w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 1 Oct 2026 12:58:39 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> > So, your workload is using ~232 GiB of node 0 memory and no demotion of it is
> > occurred.  According to your original mail [1], the node 0 has ~377 GiB memory.
> > If we make 25% of it free, it means it should have 75% of it (~282 GiB) be
> > utilized.  If the node0 has only your workload, it means node 0 memory
> > utilization is still only ~61%.  In other words, 25% free memory goal is
> > already achieved.  Than DAMON wouldn't do any demotion.
> 
> OMG.... what was pretty easy.
> I feel ashamed.  My apologies.

No worry, I'm happy that I helped :)

> 
> I increased Valkey memory allocation to 300 GB and it works.

Awesome, thank you for confirming.

> 
> > No.  Because you set '--access_rate 0% 0%' for the demotion scheme, it will do
> > no demotion in the scenario.  You could try '--access_rate 0% max' if you want.
> > You may also need to remove '--damos_filter reject young' option from the
> > command if that is really what you want to do.
> 
> '--access_rate 0% max' means range 0% - 100% ?

That's correct.

> If yes, then I need memory management decisions based on criteria
> other than access frequency.
> Age-based filters or something else.

Maybe not.  Under the (auto-tuned) quota, DAMOS applies the action to hottest
or coldest quota amount of memory depend on the action.  For example, in your
current setup, let's suppose DAMON found 10 GiB of hot memory (have >=5% access
rate) on node 2.  And the quota is auto-tuned to 4 GiB.  In the case, DAMOS
will find hottest 5 GiB hot memory and migrate those to node 0.  For finding
the hottest memory, DAMOS calculates access temperature of each memory based on
the access frequency and the age.

If you set '--access_rate 0% max', DAMOS will show all memory in node 2 is
eligible to migrate to node 0.  But, because you have the auto-tuned quota that
has 8 GiB/s upperlimit, it will migrate only up to 8 GiB hottest memory per
second.

Note that your goal also have '--damos_filter allow young' option for the
promotion.  That asks DAMOS to double check if each migration candidate page is
marked as accessed since the last double check, by h/w.  If it is not marked as
accessed by h/w, DAMOS will not migrate it.  So to allow promoting short-time
unaccessed memory, you will need to turn off this double check, too.

> 
> The idea is for achieving a defined goal - keep 25% free for new hot
> allocations in the fastest tier, if there are no un-accessed pages,
> then start demoting the most-rare access or add aga-based filters.
> Complicated but interesting, I need to think more about that.

That makes sense, and I believe removing '--access_rate' (absence of
'--access_rate' is same to '--access_rate 0% max') and '--damos_filter' is one
of the ways to achieve that.


Thanks,
SJ

[...]
