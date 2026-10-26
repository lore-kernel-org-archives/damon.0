Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024975;
	b=llhGtQEpaoh8ru8XfUbKKEDYqFhsLgYHJD3yH4j8F4y/SoQ7VXdkkdFOYRs9Eha6MEmZ
	 fUihfwZ5s7OqegYHZUX2Ykm6rZ+KmfLf99x6KcPoK0P3NwcM0FlERwqSgVSSMLTYVQXeU
	 jCR6/UXQxt05z/1eqwuO/whZEIlPQpv5Da/L+Hxl8hzXOLtJ3f+ThB8vyHJ5ybn96veOx
	 9FM/xnhQEcyhduacYDLqSiCbsghLH69kh+sAIJOiNPN1uoGzmHO+P8h42aPR1d8yAu+A6
	 cDAV+0vF6PZnl+Od/Sz3T/sC6pSPsI+3Bv+jBkU7eXrbILlZExd7tQ3GtY12MtS08Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WZBVupOUuKnSknN2BKYrJ59ZtgUZFU1sRJU3GwWHfSE=;
	b=QcgZiYgVkKj+MjrP0et2VINsyVsFjSahnWvwJ4YLaUvOjik5Gw4PDsQhSX+wCcb414SN
	 4Hy0uaHDvLsCqTTXpK5pLqG6683xRi1RKVaw2DVo9+Kmc7uoCQ5ZNxL0DXkH0xGP8Uvi9
	 1lZ+PdH7UPdIYsK3ff66MPSm9hVM39/Pbno44Oc0uwKEO91DVCYoaq8k7XFZZ50jb2bK7
	 9/GnIx1BEChJqGKCxbLcdnXyIRkKidRHUKBakZxDuW/XiroW0QU+mFJGYZ8Dh1s6+whY2
	 QxHArpNHrasNWcroCO717kAq9tw+nUiFoHeoPZ1WbLHb2u+MXtpNf4JotTGteOrPmCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jc4Gc0Vr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C07606A31A;
	Mon, 26 Oct 2026 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jc4Gc0Vr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5146B1F01825;
	Mon, 26 Oct 2026 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024974;
	bh=WZBVupOUuKnSknN2BKYrJ59ZtgUZFU1sRJU3GwWHfSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jc4Gc0VrMoeEjDqcZyGdb4FpOMlHCGbAez6wW7ehQcMBBUd9gGlUaK1cCjC/iucc8
	 w6lImTj1ZUn4R7b+hl9p3NmSwACn0rSD+JOhT5FoczhbcHsjjJWcbEfWCAKHhVNPvy
	 ClqY+L0T5FBDGMVJTwoXs+RmgRkFbOAnf37tpiW0nTHDv4dihHoVz3/FamBzHRHYeY
	 eF+3/JpllVXrPk4v0bpidleO5Lxfy2K4rAjRCP2yClGSRM6Ty0eXuwkLfglc7P/LdB
	 0pDF50wsnHfuIBl0c8GlWeu08A9KXG+hoG9VbLV2w/E3pGQ8bYNNc61wa3uJ9uYofM
	 2jocnXFmJm0mQ==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Docs/admin-guide/mm/damon/start: fix grammar
Date: Mon, 26 Oct 2026 07:29:26 -0700
Message-ID: <20261026142927.149910-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b0d8d0ceda82e303262c0f61324fe8a84fd9f745.camel@mailbox.org>
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

On Mon, 26 Oct 2026 13:41:32 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> On Mon, 2026-10-26 at 22:14 +1100, Aveline Noir wrote:
> > Fix a few grammar slips in the getting-started guide, like "make DAMON
> > monitors" and a region "that has not accessed".
> > 
> > "The line of the commands" used to be "The first two lines".  With only
> > one masim line left, I make it "The first line". 
> > 
> > Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> > ---
> >  Documentation/admin-guide/mm/damon/start.rst | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
> > index d98b0eb8e771..a83fcc2265bd 100644
> > --- a/Documentation/admin-guide/mm/damon/start.rst
> > +++ b/Documentation/admin-guide/mm/damon/start.rst
> > @@ -63,7 +63,7 @@ the execution. ::
> >  
> >  The first command of the above example downloads and builds an artificial
> >  memory access generator program called ``masim``.  The second command asks DAMO
> > -to start the program via the given command and make DAMON monitors the newly
> > +to start the program via the given command and make DAMON monitor the newly
> 
> 'The second command asks ... and makes ...' Thus:
> 
> +to start the program via the given command and makes DAMON monitor the newly

My intention was saying DAMO is commanding DAMON to monitor the process.  So I
find Aveline's version is slightly better.

> 
> >  started process.  The third command retrieves the current snapshot of the
> >  monitored access pattern of the process from DAMON and shows the pattern in a
> >  human readable format.
> > @@ -71,7 +71,7 @@ human readable format.
> >  The first line of the output shows the relative access temperature (hotness) of
> >  the regions in a single row heatmap format.  Each column on the heatmap
> >  represents regions of same size on the monitored virtual address space.  The
> > -position of the column on the row and the number on the column represents the
> > +position of the column on the row and the number on the column represent the
> >  relative location and access temperature of the region.  ``[...]`` means
> >  unmapped huge regions on the virtual address spaces.  The second line shows
> >  additional information for better understanding the heatmap.
> 
> I have read the damon directory aswell but I didn't find enought to send a patch yet.
> But I found this, could you add it to your patch?
> 
> @@ -78,8 +78,8 @@ additional information for better understanding the heatmap.
>  
>  Each line of the output from the third line shows which virtual address range
>  (``addr XX size XX``) of the process is how frequently (``access XX %``)
> -accessed for how long time (``age XX``).  For example, the eleventh region of
> -~9.5 MiB size is being most frequently accessed for last 3.7 seconds.  Finally,
> +accessed for how long (``age XX``).  For example, the eleventh region of
> +~9.5 MiB size is being most frequently accessed for the last 3.7 seconds.  Finally,
>  the fourth command stops DAMON.

Looks good.  Unless Aveline objects or do this by themselves with revisioning,
I will add this change when I apply this patch to damon/next.

> 
> Rest looks good to me:
> 
> Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>

Thank you for reviewing!


Thanks,
SJ

[...]
