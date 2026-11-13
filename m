Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581007;
	b=xOav7fPgfYqNkH7N7IXMB3W79rz/O35tkb+LnXJGw0HrdxOY+YUIee0/YdZBv7b14JBw
	 5aKeV2GgQFO/Vl0m9NKSRDV94xrCZ8K+ApahQde4kV3S4UDNXbADYPxLKcyDBZHa6FGBz
	 hGlkTSaY2N2R3dUlUfdZlRWlgvDLtzvPGVxaaer9vvp9ZoLj3lpUa7yuHDyyUjkS/vrzt
	 0Nc9h70h4vLz2CV9CkD6BIvTc8j3PEis+ms4l3LEen0WgUSSxHHFepazf1RMu/nRnVau9
	 zSCg14NwfOvra2cEDKZs/T2WXng9uT9Xel+TjBzbuVhiFAIwxwvvU283GYP5/m/gpjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a1q7tOBKKTq5abqvlVTiQBov0Mnni6BvhJAT3mdXSKc=;
	b=aTuziWwnJ2tPiDukvjEgGyJyZi2eikNFH5h0VjH3+edCoDFYDBbhdRmdKbds6l2nDhJQ
	 F7kIKWnWxZZWcJrchh00SiGpyE1Rzd1tU+7svVlUg57MUj68Y/flugYC6WxUzWZVg+Bxf
	 OEGvbYUT9FlvKo6DtMutritWk0sVC0JksZREeLCpRKwNszAkDU0IPpM+K9pjL6Lq/+4+s
	 LfUl/xH6/2jlAZ/4ojtCTqO/MOzmy8oav8+5qXlwSUctw2oRL77doEN5RX4HlTXKunj1h
	 1/hXSL6ZtPbcGc1Qvx1scWygS+/xhRIBEuJ4qkj0x5ZYQauZFCTMYrl9eyzSRbNfZgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGBCJrIb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69373606A330;
	Fri, 13 Nov 2026 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGBCJrIb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3C81F000C5;
	Fri, 13 Nov 2026 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581007;
	bh=a1q7tOBKKTq5abqvlVTiQBov0Mnni6BvhJAT3mdXSKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oGBCJrIbm4ca7kSdoD61vgbAK5Jv0ZyiJDP7tya/Slj9ksLssXTat/pX5YoIgnNmy
	 Jra8t9jEjDi2aDBeUXlaiIIvn8MuZzTfivUY5GmE11+J7xkqEftwE1oL8SkQ9evghl
	 VxBxT+5oa4Jy0Dumv+9Ueo1704OsVNIzEl08ckaZ5yE8IrXKaChwcGnalHl4MZZ68e
	 Wiku+M9KEEF3sxP3FERCgjZ4cJfuJFZ/100eBHU5HXiYIjwTUMSz6dOWeKI9/Vr6PO
	 dm5R1so8iM4lBQDfIky4pVpd5zaW3jG125PSapIeY3WGNxt1OOrLz/CsrKY3r6nKru
	 rcmcsCV5w4mdQ==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/4] Docs/mm/damon/design: update for DAMON_FILTER_TYPE_ACTIVE
Date: Fri, 13 Nov 2026 06:43:14 -0800
Message-ID: <20261113144314.97829-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <db00f01d-c9c1-4207-ae7d-9dd77cf5afa7@kylinos.cn>
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
Content-Transfer-Encoding: 8bit

On Fri, 13 Nov 2026 17:54:37 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SJ,
> 
> On 11/13/26 1:17 PM, SJ Park wrote:
> > Update DAMON design document for the newly added LRU-activeness DAMON
> > filter type.
> > 
> > Signed-off-by: SJ Park <sj@kernel.org>
> > ---
> >  Documentation/mm/damon/design.rst | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index 8440c4954090e..b676be6971589 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -302,6 +302,7 @@ filter types.  Currently below filter types are supported.
> >  - ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
> >  - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
> >    of a given size range.
> > +- ``active``: Same to that for DAMOS filters.
> 
> This reads a bit awkward to me.  How about:
> 
>   "Same as that for DAMOS filters."
> 
> The ``anon`` and ``memcg`` entries above use the same wording, so
> it would be nice to fix those at the same time.
> 
> WDYT?

Makes sense to me, thank you for sharing the finding, Enze!  I also find more
"same to" usages in the doc.  Would you like to send a patch for fixing those
at once?


Thanks,
SJ

[...]
