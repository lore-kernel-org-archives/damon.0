Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6231715D;
	Mon,  8 Jun 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929407; cv=none; b=CK0J7ORqw8Pih1ZvCsB83Sbvq5A2LNgguBll2J2YuoPslv3bkwjHkI4e6fbPSAwDCYshXvTUAPTVnXO2sQPdxokBuAhbclOArtfLwUlNJVFUjjMaHtpF9S1h9bu4mHwu6u3haC48wEOIs5bEF4HDWPQmS1XYYNeLS/k3DAC+V7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929407; c=relaxed/simple;
	bh=T4NZ0MN5P1FIlprxwSxuTRmldMz5FqJEHZ9cmOVq4j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1UkHTupFPQmxCH3DfGwr1uxQUZ7tqPBuoVBa35UKuw+05sRrQ2MqrNDyk16Bh6vG1jZ4juKZWGB6BrqlcMLuZH2N3lOPXYvy5TkSynWE8KgxLIETir4LqiW+guNy4pkw0Ne0tRsrlpnQpT+SWf2sNdpE8WcR2pq7JAmw2iRz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHIH4JHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHIH4JHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90C61F00893;
	Mon,  8 Jun 2026 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780929406;
	bh=YJ+dww3i2Z4HuF+mzXwFox0d5fpRC3Vr7GjOrj3pNoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AHIH4JHVf6Yqub9+Vx6THiZh/2oKTkLESUFxvgzdVVtvsXIKS0AY/Mkaub9aKTK3L
	 6Ku1JVaNWn5yDHIroDJ+BK7agCu4FDVip183rNznQ/sW2CSNcMRlvuhdgme9+3nIlS
	 U4Rd804umICyA1tHihcxUkG+TiSzGg14KuBwN+INo5qSzaP+GB/CMwwRlRQYyctPpI
	 qBAx3l7cqIFjfkmiUBBqu7wRfdwjpEBJ7LM7TqcRWHFoIHlV6FjdBTHOj//rpa/Z07
	 7h8BChGRoFARDXt8qrAnRHM53OJZQRiBLpz24ZOiVEbDgacVrXoM15I3XR0PLtvVX8
	 mYHmAfzgZhftQ==
From: SeongJae Park <sj@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 02/10] mm/damon/core: add damon_new_region() debug_sanity check
Date: Mon,  8 Jun 2026 07:36:38 -0700
Message-ID: <20260608143638.69148-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f8d25003-357d-cd65-dcf6-568dcbdc6412@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 8 Jun 2026 19:07:28 +0800 Zenghui Yu <yuzenghui@huawei.com> wrote:

> On 2026/6/8 0:53, SeongJae Park wrote:
> > Hello Zenghui,
> > 
> > On Sun, 7 Jun 2026 23:24:27 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:
[...]
> > > --- a/samples/damon/mtier.c
> > > +++ b/samples/damon/mtier.c
> > > @@ -118,6 +118,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> > >  	} else {
> > >  		addr.start = promote ? node1_start_addr : node0_start_addr;
> > >  		addr.end = promote ? node1_end_addr : node0_end_addr;
> > > +
> > > +		if (addr.start >= addr.end)
> > > +			goto free_out;
> > >  	}
> > >  
> > >  	region = damon_new_region(addr.start, addr.end);
> > 
> > Because mtier is just a sample module, and this doesn't cause a catastrophic
> > situation like system crash, I think this is very urgent.
> 
> I assume you meant "this is not very urgent" ;) .

Ah, you are right :)

> 
> > But, given the
> > simplicity of the change, this looks good to me.  If you'd like to send a
> > patch, please feel free to do.
> 
> Sure, I will send it out shortly.

Cool, I got it [1].

[1] https://lore.kernel.org/20260608111534.264-1-yuzenghui@huawei.com


Thanks,
SJ

[...]
