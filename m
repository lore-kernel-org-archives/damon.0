Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490604;
	b=sz8+jtt/C5/IfYCMThD+ZxUVDBuhII3lq0sLJ2WzzPm8EcMLhTFe6LheG2AAcXmUBZxS
	 uDf3y8C9cGQPQIG4xvm3XNipQA36sIwh10utIHXFKH6alr0pfAez3VGGE9v5JGUlxZNro
	 JJ9kP+Gm6aZ/u4sMdHLtNvf3L1lGIusOPDYLYtOU7SJjsKGUC3qkbtOAzeSVWjhVdcYFY
	 RP9VXzPUDCzYLUkpxqbPRkBMOX7w1sLhQo75UFRteb3EJOUsrdSpep3j3ZZ5RhXyOT5P9
	 nbdZ2carIGBK4LZgcA52NThs/tvAgbXq8neIVTev2SNo1hjM4MxhFrnEntaBcYhs2pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490604;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g2xYc13uIcoTxx1PIDsQUia73qmoO0NEeZoyYDssKHA=;
	b=w7APVmpuJ09dbLzt+a5s6TE4NWEVNvY40agH5bXDfyaF6RP08Y9GLgOJJ6MlSjUc5wHR
	 SUNIbR1rX/zDg55iCQfeM3EtAftFYunGp5iXHhpbRk/CZ4EWbp+ffAbQr1WRpZhiVQ8Mk
	 GUzL79LO+RPkfRhpfrKAf11CMYZx4p0+ESbzRrvJXO+d13W6+EJjyBl9eHYG1a5CCoj2n
	 SWso0HYpfKr7hk+hssje6V85OOFqfpQ2zWf7IGC3VtP6IoD/NLsT7VpQLcniTH9bsO/ui
	 hj6XK9EPJSOiGbk5ouHoB6CWcGw+gRpb/SRaPm0ERLisG46S8+kK4euGl3kDqRmbG4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4dN2K+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD5606A31E;
	Tue, 24 Nov 2026 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4dN2K+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538951F000CA;
	Tue, 24 Nov 2026 03:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795490604;
	bh=g2xYc13uIcoTxx1PIDsQUia73qmoO0NEeZoyYDssKHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4dN2K+oBMBLLRXtv/Nna9pSI/7QxrnjcmVbNUeHNe1OjRuXffrz3jgEekV6W/lje
	 wKqH5WTlXM9Iy7BDcSPIPLHxKzb/r3As+JnOObfHuwGwwVeemiccxNL+74pSRNtoUE
	 i149VYCLNhfx9V+lpjPJxudR/zmViitE0CdY2OQp4R6jy4wbE2Hg/GBRK5gxgWP+yh
	 /hvYUhc5AGcOwe1pqKc8ikHjCe9+9a/e++JCf3j1F6Y1+4tt/wGOPVaqF+vHewaAei
	 EDwmRBFylglsHeTsqEpnkRUFQ+OSxZ1hXdHBq0Kn8du+78+e3RfH80nisszaAAuus+
	 WNKQfW902mUqw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Mon, 23 Nov 2026 19:23:15 -0800
Message-ID: <20261124032317.10738-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmFCkqfgQLda1EUADP2fVx_o6g+w8RuTAV5ugJ_sP3OkyA@mail.gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 24 Nov 2026 13:04:44 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> HI SJ,
> 
> On Tue, Nov 24, 2026 at 12:05 PM SJ Park <sj@kernel.org> wrote:
> aid if that will add something that we need to maintain long term,
> > without clear use case.  I think we could revisit after we get such realistic
> > use cases.
> 
> Sure. That makes sense :)

Thank you for confirming, Aveline.


Thanks,
SJ

[...]
