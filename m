Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025076;
	b=MOI77TksCspiDcz3hjDNGKzmhAAygXgbME+uXvwv9wqgWMqgPJ1yQl5cP2A4WS7HD4q5
	 uJuKCbbd800k81JPovkvARRE//l4lP6cpQLZuNtMRs/9w0mwuVTu05rdMaAbaQ08Wf5UO
	 BlLv4HoVQGoNnI2EnA7dcqnNyLRMHEKFfs0sK7ZIyRHW178XTAnBhBCkGj+6HQUpxBYEw
	 uGbedR3zJM3WGA/oczV5ReJMOObFEOLgLvEQhpbk5kM5Aa1sXa8yV4Whcd/OCCPq+bYY1
	 TTxajrGbrdcUqAO7mrDaY3gCzoP4u5NHR2Tc+mD9nGlC7I7jQN/+WJLYCcofyRmsB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HHYZN7CUNSVC86iKOqMGjhaR96VGj0GsKVxO2ePAdxU=;
	b=Sj5pltxm3Ge0THHeSI0wHT85FY8BMxjmFnEIqTc4lvxNlBQSMXOEPDxInQqnYkGV6JwM
	 IWY4Szwpl/I86gYH3ciVk+cEPBEUtC0SOeYfPhWw+31EDbX8Z3h7Rd4PenrJFRn2a1Z9a
	 jLJiupZhFQimNJ3fkJoUpRb80Vae6QFNdveAifoIq2wBGBuJOjffmZ/K7tjgAeSrTcNMT
	 R4wXCESQWDOo+TgmGpJ5KpizBS4bT7Io0JKmpv+o+FzUHVXZqoBleiOv+SZQpyH4b8C+c
	 VxiSuqENb8AWo8usukPL3OpMNpmHymGvfomPX0ae/aAPFm3pKvcrUB7EbLKMSuEIOkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bvu4++Ow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96118606A323;
	Mon, 26 Oct 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bvu4++Ow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077A91F01825;
	Mon, 26 Oct 2026 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025076;
	bh=HHYZN7CUNSVC86iKOqMGjhaR96VGj0GsKVxO2ePAdxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bvu4++OwAGVMLQ16yY85QEzvab4FU9r/RLkombk+8WziaGpwdrl9QXwIpuZv+5NP7
	 6AHYU2waZPDWZ/I5v63v65bImurDsoUN/G7fEHIqUieNkxz3ZXNNau5vcc/CDDmbDa
	 mmSCreJn18/wb41wKRbfo6OaMjF05WYkfPrAfQKqaSbuYpbkNABoUam2Goe7Xk3Zbz
	 wEKYIedkH2rLNDFkW5rftn+aRFc+bYkwhLBs28Yn76Kbwaf2Y2nc+03EFe6kXfnRuP
	 Yi9NXbujFsfSFP80yAkcP8eR2bSkKhCqyrNwtGwJjuba8tO+Vc77pSqbY+E6rohhYc
	 vzlNhN7SKEvzA==
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
Subject: Re: [PATCH 2/8] Docs/admin-guide/mm/damon/stat: fix pronoun agreement
Date: Mon, 26 Oct 2026 07:31:07 -0700
Message-ID: <20261026143109.150059-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <203ef50d11ae600ab06546d73a2290f291381551.camel@mailbox.org>
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

On Mon, 26 Oct 2026 13:44:55 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi Aveline,
> 
> On Mon, 2026-10-26 at 22:14 +1100, Aveline Noir wrote:
> > "converts it" refers to the access events, so I think it should be
> > "them".  Rewrap the paragraph while at it.
> > 
> > Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> > ---
> >  Documentation/admin-guide/mm/damon/stat.rst | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
> > index 4a9db755a526..a93609649a5f 100644
> > --- a/Documentation/admin-guide/mm/damon/stat.rst
> > +++ b/Documentation/admin-guide/mm/damon/stat.rst
> 
> Here I found this one:
> @@ -41,8 +41,8 @@ enabled
>  
>  Enable or disable DAMON_STAT.
>  
> -You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
> -Setting it as ``N`` disables DAMON_STAT.  The default value is set by
> +You can enable DAMON_STAT by setting the value of this parameter to ``Y``.
> +Setting it to ``N`` disables DAMON_STAT.  The default value is set by
>  ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` build config option.

Thanks.  Unless Aveline objects or add this part to the next revision of this
patch, I will add this  when I apply this patch to damon/next.

>  
> > @@ -68,10 +68,10 @@ estimated_memory_bandwidth
> >  Estimated memory bandwidth consumption (bytes per second) of the system.
> >  
> >  DAMON_STAT reads observed access events on the current DAMON results snapshot
> > -and converts it to memory bandwidth consumption estimation in bytes per second.
> > -The resulting metric is exposed to user via this read-only parameter.  Because
> > -DAMON uses sampling, this is only an estimation of the access intensity rather
> > -than accurate memory bandwidth.
> > +and converts them to memory bandwidth consumption estimation in bytes per
> > +second.  The resulting metric is exposed to user via this read-only parameter.
> > +Because DAMON uses sampling, this is only an estimation of the access intensity
> > +rather than accurate memory bandwidth.
> >  
> >  memory_idle_ms_percentiles
> >  --------------------------
> 
> 
> Thanks,
> Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>

Thank you for your review.


Thanks,
SJ
